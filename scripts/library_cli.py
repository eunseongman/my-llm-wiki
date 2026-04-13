from __future__ import annotations

import argparse
import re
import shutil
import unicodedata
from datetime import datetime
from pathlib import Path


SECTION_ORDER = [
    ("sessions", "Sessions"),
    ("concepts", "Concepts"),
    ("topics", "Topics"),
    ("syntheses", "Syntheses"),
    ("questions", "Questions"),
]


def repo_root_from_script() -> Path:
    return Path(__file__).resolve().parent.parent


def slugify(value: str) -> str:
    normalized = unicodedata.normalize("NFKD", value)
    ascii_text = normalized.encode("ascii", "ignore").decode("ascii")
    lowered = ascii_text.lower().strip()
    slug = re.sub(r"[^a-z0-9]+", "-", lowered).strip("-")
    return slug or "untitled"


def ensure_structure(root: Path) -> None:
    required_dirs = [
        "inbox",
        "archive",
        "library/concepts",
        "library/topics",
        "library/sessions",
        "library/syntheses",
        "library/questions",
        "writing/posts",
        "system/templates",
    ]
    for rel in required_dirs:
        (root / rel).mkdir(parents=True, exist_ok=True)


def now_date() -> str:
    return datetime.now().strftime("%Y-%m-%d")


def read_text(path: Path) -> str:
    return path.read_text(encoding="utf-8")


def write_text(path: Path, content: str) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(content, encoding="utf-8")


def extract_title(path: Path) -> str:
    text = read_text(path)
    match = re.search(r"^title:\s*(.+)$", text, re.MULTILINE)
    if match:
        return match.group(1).strip().strip('"')
    heading = re.search(r"^#\s+(.+)$", text, re.MULTILINE)
    if heading:
        return heading.group(1).strip()
    return path.stem


def extract_summary_line(path: Path) -> str:
    text = read_text(path)
    lines = [line.strip() for line in text.splitlines()]
    in_frontmatter = False
    for line in lines:
        if line == "---":
            in_frontmatter = not in_frontmatter
            continue
        if in_frontmatter:
            continue
        if not line or line.startswith("#"):
            continue
        return line
    return "요약 없음"


def append_log(root: Path, entry_type: str, title: str, details: str) -> None:
    log_path = root / "library/log.md"
    if not log_path.exists():
        write_text(log_path, "# 지식 도서관 로그\n")
    stamp = now_date()
    block = (
        f"\n## [{stamp}] {entry_type} | {title}\n\n"
        f"- {details.strip()}\n"
    )
    with log_path.open("a", encoding="utf-8") as handle:
        handle.write(block)


def rebuild_index(root: Path) -> Path:
    ensure_structure(root)
    lines = [
        "# 지식 도서관 인덱스",
        "",
        "이 문서는 도서관의 입구다. 문서가 늘어날수록 아래 분류를 유지한다.",
        "",
    ]

    for folder, label in SECTION_ORDER:
        lines.append(f"## {label}")
        lines.append("")
        directory = root / "library" / folder
        entries = sorted(directory.glob("*.md"))
        if entries:
            for path in entries:
                title = extract_title(path)
                summary = extract_summary_line(path)
                rel = path.relative_to(root).as_posix()
                lines.append(f"- [{title}](/C:/Users/user/working/llm-wiki/{rel}): {summary}")
        else:
            lines.append("- 아직 등록된 문서 없음")
        lines.append("")

    writing_entries = sorted((root / "writing/posts").glob("*.md"))
    lines.append("## Writing")
    lines.append("")
    if writing_entries:
        for path in writing_entries:
            title = extract_title(path)
            summary = extract_summary_line(path)
            rel = path.relative_to(root).as_posix()
            lines.append(f"- [{title}](/C:/Users/user/working/llm-wiki/{rel}): {summary}")
    else:
        lines.append("- 아직 등록된 문서 없음")
    lines.append("")

    index_path = root / "library/index.md"
    write_text(index_path, "\n".join(lines))
    return index_path


def build_session_content(title: str, date: str, source_path: str, excerpt: str) -> str:
    return f"""---
title: "{title}"
type: session
status: draft
created: {date}
updated: {date}
source_path: "{source_path}"
---

# {title}

## 오늘 다룬 주제

- 

## 핵심 질문

- 

## 핵심 배움

- {excerpt}

## 새로 연결된 개념

- 

## 열린 질문

- 

## 관련 문서

- 
"""


def new_session(root: Path, title: str, date: str, summary_file: Path, archive_copy: bool) -> Path:
    ensure_structure(root)
    slug = slugify(title)
    source_abs = summary_file.resolve()
    session_path = root / "library/sessions" / f"{date}-{slug}.md"
    excerpt = extract_summary_line(summary_file)
    content = build_session_content(title=title, date=date, source_path=str(source_abs), excerpt=excerpt)
    write_text(session_path, content)

    if archive_copy:
        archived = root / "archive" / summary_file.name
        shutil.copyfile(summary_file, archived)

    append_log(root, "ingest", title, f"session note 생성: {session_path.name}")
    rebuild_index(root)
    return session_path


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description="대화 기반 지식 도서관 유지 도구")
    parser.add_argument("--root", default=str(repo_root_from_script()), help="저장소 루트 경로")
    sub = parser.add_subparsers(dest="command", required=True)

    sub.add_parser("rebuild-index", help="library/index.md를 재생성한다")

    log_parser = sub.add_parser("log", help="library/log.md에 로그를 추가한다")
    log_parser.add_argument("--type", required=True, dest="entry_type")
    log_parser.add_argument("--title", required=True)
    log_parser.add_argument("--details", required=True)

    session_parser = sub.add_parser("new-session", help="대화 파일에서 session note 초안을 만든다")
    session_parser.add_argument("--title", required=True)
    session_parser.add_argument("--date", required=True)
    session_parser.add_argument("--summary-file", required=True)
    session_parser.add_argument("--archive-copy", action="store_true")

    return parser


def main() -> int:
    parser = build_parser()
    args = parser.parse_args()
    root = Path(args.root).resolve()

    if args.command == "rebuild-index":
        path = rebuild_index(root)
        print(f"index rebuilt: {path}")
        return 0

    if args.command == "log":
        append_log(root, args.entry_type, args.title, args.details)
        print("log appended")
        return 0

    if args.command == "new-session":
        session_path = new_session(
            root=root,
            title=args.title,
            date=args.date,
            summary_file=Path(args.summary_file),
            archive_copy=args.archive_copy,
        )
        print(f"session created: {session_path}")
        return 0

    parser.error("unknown command")
    return 2


if __name__ == "__main__":
    raise SystemExit(main())
