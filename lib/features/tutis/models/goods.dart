class Goods {
  final String name;
  final double? regularPrice;
  final double? discountRate;
  final double discountedPrice;
  final String? discountPolicy;

  const Goods(
      {required this.name,
      required this.discountedPrice,
      this.discountRate,
      this.regularPrice,
      this.discountPolicy});

  factory Goods.fromJson(Map<String, dynamic> json) {
    return Goods(
        name: json['name'],
        regularPrice: json['price'],
        discountRate: json['discountValue'],
        discountedPrice: json['discountedPrice'],
        discountPolicy: json['discountPolicy']);
  }
}
