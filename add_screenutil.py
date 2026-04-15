import os
import re

def process_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    original = content

    # Add import if missing
    if "package:flutter/material.dart" in content and "package:flutter_screenutil/flutter_screenutil.dart" not in content:
        content = content.replace("import 'package:flutter/material.dart';", "import 'package:flutter/material.dart';\nimport 'package:flutter_screenutil/flutter_screenutil.dart';")

    # Simple regex replacements
    content = re.sub(r'height:\s*(\d+(?:\.\d+)?)\b(?!\.h|\.w|\.sp|\.r|\s*\])', r'height: \1.h', content)
    content = re.sub(r'width:\s*(\d+(?:\.\d+)?)\b(?!\.h|\.w|\.sp|\.r|\s*\])', r'width: \1.w', content)
    content = re.sub(r'fontSize:\s*(\d+(?:\.\d+)?)\b(?!\.h|\.w|\.sp|\.r)', r'fontSize: \1.sp', content)
    content = re.sub(r'radius:\s*(\d+(?:\.\d+)?)\b(?!\.h|\.w|\.sp|\.r)', r'radius: \1.r', content)
    content = re.sub(r'circular\((\d+(?:\.\d+)?)\)', r'circular(\1.r)', content)
    content = re.sub(r'\.all\((\d+(?:\.\d+)?)\)', r'.all(\1.w)', content)

    # symmetric(horizontal: X, vertical: Y)
    def symmetric_repl(m):
        inner = m.group(1)
        inner = re.sub(r'horizontal:\s*(\d+(?:\.\d+)?)\b(?!\.w)', r'horizontal: \1.w', inner)
        inner = re.sub(r'vertical:\s*(\d+(?:\.\d+)?)\b(?!\.h)', r'vertical: \1.h', inner)
        return 'symmetric(' + inner + ')'
    
    content = re.sub(r'symmetric\(([^)]+)\)', symmetric_repl, content)

    # only(\s*(?:top|bottom|left|right):\s*\d+\s*,?\s*)+\)
    def only_repl(m):
        inner = m.group(1)
        inner = re.sub(r'(left|right):\s*(\d+(?:\.\d+)?)\b(?!\.w)', r'\1: \2.w', inner)
        inner = re.sub(r'(top|bottom):\s*(\d+(?:\.\d+)?)\b(?!\.h)', r'\1: \2.h', inner)
        return 'only(' + inner + ')'

    content = re.sub(r'only\(([^)]+)\)', only_repl, content)

    if content != original:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"Updated {filepath}")

def main():
    lib_path = 'lib'
    for root, dirs, files in os.walk(lib_path):
        for file in files:
            if file.endswith('.dart') and file != 'main.dart' and file != 'app_typography.dart':
                process_file(os.path.join(root, file))

if __name__ == '__main__':
    main()
