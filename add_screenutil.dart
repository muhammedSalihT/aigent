import 'dart:io';

void processFile(File file) {
  String content = file.readAsStringSync();
  String original = content;

  if (content.contains("package:flutter/material.dart") && !content.contains("package:flutter_screenutil/flutter_screenutil.dart")) {
    content = content.replaceAll("import 'package:flutter/material.dart';", "import 'package:flutter/material.dart';\nimport 'package:flutter_screenutil/flutter_screenutil.dart';");
  }

  content = content.replaceAllMapped(RegExp(r'height:\s*(\d+(?:\.\d+)?)\b(?!\.h|\.w|\.sp|\.r|\s*\])'), (m) => 'height: ${m[1]}.h');
  content = content.replaceAllMapped(RegExp(r'width:\s*(\d+(?:\.\d+)?)\b(?!\.h|\.w|\.sp|\.r|\s*\])'), (m) => 'width: ${m[1]}.w');
  content = content.replaceAllMapped(RegExp(r'fontSize:\s*(\d+(?:\.\d+)?)\b(?!\.h|\.w|\.sp|\.r)'), (m) => 'fontSize: ${m[1]}.sp');
  content = content.replaceAllMapped(RegExp(r'radius:\s*(\d+(?:\.\d+)?)\b(?!\.h|\.w|\.sp|\.r)'), (m) => 'radius: ${m[1]}.r');
  content = content.replaceAllMapped(RegExp(r'circular\((\d+(?:\.\d+)?)\)'), (m) => 'circular(${m[1]}.r)');
  content = content.replaceAllMapped(RegExp(r'\.all\((\d+(?:\.\d+)?)\)'), (m) => '.all(${m[1]}.w)');

  content = content.replaceAllMapped(RegExp(r'symmetric\(([^)]+)\)'), (m) {
    String inner = m[1]!;
    inner = inner.replaceAllMapped(RegExp(r'horizontal:\s*(\d+(?:\.\d+)?)\b(?!\.w)'), (match) => 'horizontal: ${match[1]}.w');
    inner = inner.replaceAllMapped(RegExp(r'vertical:\s*(\d+(?:\.\d+)?)\b(?!\.h)'), (match) => 'vertical: ${match[1]}.h');
    return 'symmetric($inner)';
  });

  content = content.replaceAllMapped(RegExp(r'only\(([^)]+)\)'), (m) {
    String inner = m[1]!;
    inner = inner.replaceAllMapped(RegExp(r'(left|right):\s*(\d+(?:\.\d+)?)\b(?!\.w)'), (match) => '${match[1]}: ${match[2]}.w');
    inner = inner.replaceAllMapped(RegExp(r'(top|bottom):\s*(\d+(?:\.\d+)?)\b(?!\.h)'), (match) => '${match[1]}: ${match[2]}.h');
    return 'only($inner)';
  });

  if (content != original) {
    file.writeAsStringSync(content);
    print('Updated ${file.path}');
  }
}

void main() {
  final dir = Directory('lib');
  final List<FileSystemEntity> entities = dir.listSync(recursive: true);
  for (var entity in entities) {
    if (entity is File && entity.path.endsWith('.dart') && !entity.path.endsWith('main.dart') && !entity.path.endsWith('app_typography.dart')) {
      processFile(entity);
    }
  }
}
