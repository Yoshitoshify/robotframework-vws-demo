
import sys
import io
from pdfminer.high_level import extract_text

if len(sys.argv) != 2:
    print("Usage: extract_pdf_text.py <pdf_path>", file=sys.stderr)
    sys.exit(1)

pdf_path = sys.argv[1]
try:
    text = extract_text(pdf_path)
    sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', newline='')
    print(text)
except Exception as e:
    print(f"FOUT: {e}", file=sys.stderr)
    sys.exit(2)
