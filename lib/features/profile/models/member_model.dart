class MemberModel {
  String name;
  String university;
  String major;
  String imageUrl;
  String applyMatchingStatus;
  List<String> jobTags;

  MemberModel({
    required this.name,
    required this.university,
    required this.major,
    required this.imageUrl,
    required this.applyMatchingStatus,
    required this.jobTags,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      name: json['name'],
      university: json['university'],
      major: json['major'],
      imageUrl: json['imageUrl'],
      applyMatchingStatus: json['applyMatchingStatus'],
      jobTags: List<String>.from(json['jobTags']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'university': university,
      'major': major,
      'imageUrl': imageUrl,
      'applyMatchingStatus': applyMatchingStatus,
      'jobTags': jobTags,
    };
  }
}
