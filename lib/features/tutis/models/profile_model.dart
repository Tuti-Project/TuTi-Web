final profiles = [
  {
    'name': '김지수',
    'university': '서울대학교 / 외교통상학과',
    'isOn': true,
    'keywords': ['퍼스널브랜딩', '마케팅'],
  },
  {
    'name': '김철수',
    'university': '연세대학교',
    'isOn': true,
    'keywords': ['개발자', '백엔드'],
  },
  {
    'name': '김영희',
    'university': '고려대학교',
    'isOn': false,
    'keywords': ['개발자', '프론트엔드'],
  },
  {
    'name': '김영희',
    'university': '고려대학교',
    'isOn': false,
    'keywords': ['개발자', '프론트엔드'],
  },
  {
    'name': '김영희',
    'university': '고려대학교',
    'isOn': true,
    'keywords': ['개발자', '프론트엔드'],
  },
  {
    'name': '김영희',
    'university': '고려대학교',
    'isOn': false,
    'keywords': ['개발자', '프론트엔드'],
  },
];

// 위 정보 model 로 만들기
class Profile {
  String name;
  String university;
  bool isOn;
  List<String> keywords;

  Profile({
    required this.name,
    required this.university,
    required this.isOn,
    required this.keywords,
  });
}
