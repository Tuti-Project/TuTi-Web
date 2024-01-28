class ProfileModel {
  int? memberId;
  String? name;
  int? age;
  String? gender;
  String university;
  String major;
  String? imageUrl;
  String description;
  List<String> jobTags;
  List<String> skillTags;
  String applyMatchingStatus;
  List<String> availableDays;
  String matchingDescription;
  String? availableHours;

  ProfileModel({
    this.memberId,
    this.name,
    this.age,
    this.gender,
    required this.university,
    required this.major,
    this.imageUrl,
    required this.description,
    required this.jobTags,
    required this.skillTags,
    required this.applyMatchingStatus,
    required this.availableDays,
    required this.matchingDescription,
    this.availableHours,
  });

  factory ProfileModel.empty() => ProfileModel(
        memberId: -1,
        name: '',
        age: -1,
        gender: '',
        university: '',
        major: '',
        imageUrl: '',
        description: '',
        jobTags: [],
        skillTags: [],
        applyMatchingStatus: '',
        availableDays: [],
        matchingDescription: '',
      );

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      memberId: json['memberId'],
      name: json['name'],
      age: json['age'],
      gender: json['gender'],
      university: json['university'],
      major: json['major'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      jobTags: List<String>.from(json['jobTags']),
      skillTags: List<String>.from(json['skillTags']),
      applyMatchingStatus: json['applyMatchingStatus'],
      availableDays: List<String>.from(json['availableDays']),
      matchingDescription: json['matchingDescription'],
      availableHours: json['availableHours'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'university': university,
      'major': major,
      'imageUrl': 'string',
      'description': description,
      'jobTags': jobTags,
      'skillTags': skillTags,
      'applyMatchingStatus': applyMatchingStatus,
      'availableDays': availableDays,
      'matchingDescription': matchingDescription,
      'availableHours': availableHours,
    };
  }
}

enum Day {
  MON,
  TUE,
  WED,
  THU,
  FRI,
  SAT,
  SUN,
}
