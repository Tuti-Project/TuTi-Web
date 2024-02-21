class GoodsCard {
  final String title;
  final double? regularPrice;
  final double? discountRate;
  final double discountedPrice;

  const GoodsCard(
      {required this.title,
      required this.discountedPrice,
      this.discountRate,
      this.regularPrice});
}
