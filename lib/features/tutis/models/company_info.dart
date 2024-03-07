import 'package:flutter/material.dart';

class CompanyInfo {
  final String title;
  final String contents;
  final String? subTitle;
  final String? subContents;
  final VoidCallback onTap;

  const CompanyInfo({
    required this.title,
    required this.contents,
    this.subContents,
    this.subTitle,
    required this.onTap,
  });
}
