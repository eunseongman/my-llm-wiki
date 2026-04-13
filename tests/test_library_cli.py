from pathlib import Path
from tempfile import TemporaryDirectory
import unittest

from scripts.library_cli import new_session, rebuild_index, slugify


def write(path: Path, content: str) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(content, encoding="utf-8")


class LibraryCliTests(unittest.TestCase):
    def test_slugify_basic_text(self) -> None:
        self.assertEqual(slugify("Hello World"), "hello-world")

    def test_new_session_creates_session_log_and_index(self) -> None:
        with TemporaryDirectory() as tmp:
            root = Path(tmp)
            source = root / "inbox/source.md"
            write(source, "# 원문\n\n이 대화는 위키와 도서관의 차이를 다룬다.\n")

            session_path = new_session(
                root=root,
                title="위키 도서관 세션",
                date="2026-04-13",
                summary_file=source,
                archive_copy=False,
            )

            self.assertTrue(session_path.exists())
            self.assertTrue((root / "library/log.md").exists())
            self.assertTrue((root / "library/index.md").exists())
            self.assertIn("위키 도서관 세션", session_path.read_text(encoding="utf-8"))

    def test_rebuild_index_lists_documents(self) -> None:
        with TemporaryDirectory() as tmp:
            root = Path(tmp)
            concept = root / "library/concepts/library.md"
            write(
                concept,
                "---\n"
                'title: "지식 도서관"\n'
                "type: concept\n"
                "---\n\n"
                "# 지식 도서관\n\n"
                "대화를 정리한 지식 저장소.\n",
            )

            index_path = rebuild_index(root)
            text = index_path.read_text(encoding="utf-8")
            self.assertIn("지식 도서관", text)
            self.assertIn("Concepts", text)


if __name__ == "__main__":
    unittest.main()
