#!/bin/bash
# Embed every base*.jpg into mockup_generator.html → produce a single-file index.html
set -e
cd "$(dirname "$0")"

python3 << 'PY'
import base64, pathlib, re

bases = ['base.jpg', 'laptop_only.jpg', 'phone_only.jpg']
html = pathlib.Path("mockup_generator.html").read_text(encoding="utf-8")
for fname in bases:
    path = pathlib.Path("assets") / fname
    b64 = base64.b64encode(path.read_bytes()).decode()
    # Match both single and double quotes (in case the HTML gets reformatted by Prettier etc.)
    pattern = re.compile(rf"base:\s*['\"]assets/{re.escape(fname)}['\"]")
    replacement = f"base: 'data:image/jpeg;base64,{b64}'"
    new_html, n = pattern.subn(replacement, html, count=1)
    if n == 0:
        raise SystemExit(f"marker not found: assets/{fname}")
    html = new_html
pathlib.Path("index.html").write_text(html, encoding="utf-8")
size_mb = len(html.encode("utf-8")) / 1024 / 1024
print(f"index.html を生成しました ({size_mb:.2f} MB)")
PY
