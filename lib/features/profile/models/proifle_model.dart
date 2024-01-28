class ProfileModel {
  int memberId;
  String name;
  int age;
  String gender;
  String university;
  String major;
  String description;
  List<String> jobTags;
  List<String> skillTags;
  String applyMatchingStatus;

  ProfileModel({
    required this.memberId,
    required this.name,
    required this.age,
    required this.gender,
    required this.university,
    required this.major,
    required this.description,
    required this.jobTags,
    required this.skillTags,
    required this.applyMatchingStatus,
  });

  factory ProfileModel.empty() => ProfileModel(
        memberId: 0,
        name: '',
        age: 0,
        gender: '',
        university: '',
        major: '',
        description: '',
        jobTags: [],
        skillTags: [],
        applyMatchingStatus: '',
      );

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      memberId: json['memberId'],
      name: json['name'],
      age: json['age'],
      gender: json['gender'],
      university: json['university'],
      major: json['major'],
      description: json['description'],
      jobTags: List<String>.from(json['jobTags']),
      skillTags: List<String>.from(json['skillTags']),
      applyMatchingStatus: json['applyMatchingStatus'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'memberId': memberId,
      'name': name,
      'age': age,
      'gender': gender,
      'university': university,
      'major': major,
      'description': description,
      'jobTags': jobTags,
      'skillTags': skillTags,
      'applyMatchingStatus': applyMatchingStatus,
    };
  }
}
