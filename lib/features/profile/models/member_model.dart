class MemberModel {
  int memberId;
  String name;
  String university;
  String major;
  String imageUrl;
  String applyMatchingStatus;
  // String matchingDescription;
  List<String> jobTags;

  MemberModel({
    required this.memberId,
    required this.name,
    required this.university,
    required this.major,
    required this.imageUrl,
    required this.applyMatchingStatus,
    // required this.matchingDescription,
    required this.jobTags,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      memberId: json['memberId'],
      name: json['name'],
      university: json['university'],
      major: json['major'],
      imageUrl: json['imageUrl'],
      applyMatchingStatus: json['applyMatchingStatus'],
      // matchingDescription: json['matchingDescription'],
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
      // 'matchingDescription': matchingDescription,
      'jobTags': jobTags,
    };
  }
}
