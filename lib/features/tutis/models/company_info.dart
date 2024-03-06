class CompanyInfo {
  final String title;
  final String contents;
  final String? subTitle;
  final String? subContents;

  const CompanyInfo(
      {required this.title,
      required this.contents,
      this.subContents,
      this.subTitle});
}
