// getter로 string 만들기
class StringConstants {
  static String appName = "TuTi";
  // 원래 서버 도메인 : 'https://www.tuti-service.site'
  // AWS 과금 정책으로 인해 도메인 적용까지 임시 서버 주소 사용
  static const baseUrl = 'http://52.78.238.81:8080';
}

final jobConstant = [
  'IT/SW',
  '사무/행정',
  '마케팅',
  '건축/건설',
  '영업/상담',
  '디자인',
  '광고/홍보',
];

final skillConstant = [
  '한글/워드',
  '엑셀',
  '일러스트',
  '포토샵',
  '피그마',
  '블랜더',
  '캐드',
  '스케치업',
  '라이노',
  '시장조사',
  '파워포인트',
  '외국어',
];

final daysConstant = [
  '월',
  '화',
  '수',
  '목',
  '금',
  '토',
  '일',
];
