#!/bin/bash
# Embed every base*.jpg into mockup_generator.html → produce a single-file index.html
set -e
cd "$(dirname "$0")"

python3 << 'PY'
import base64, pathlib

bases = ['base.jpg', 'laptop_only.jpg', 'phone_only.jpg']
html = pathlib.Path("mockup_generator.html").read_text(encoding="utf-8")
for fname in bases:
    path = pathlib.Path("assets") / fname
    b64 = base64.b64encode(path.read_bytes()).decode()
    marker = f"base: 'assets/{fname}'"
    replacement = f"base: 'data:image/jpeg;base64,{b64}'"
    if marker not in html:
        raise SystemExit(f"marker not found: {marker}")
    html = html.replace(marker, replacement)
pathlib.Path("index.html").write_text(html, encoding="utf-8")
size_mb = len(html.encode("utf-8")) / 1024 / 1024
print(f"index.html を生成しました ({size_mb:.2f} MB)")
PY
