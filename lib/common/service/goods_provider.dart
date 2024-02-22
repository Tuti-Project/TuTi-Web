import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuti/constants/string.dart';
import 'package:tuti/features/tutis/models/goods.dart';

final goodsProvider = FutureProvider<List<Goods>>((ref) async {
  final dio = Dio();
  final response = await dio.get('${StringConstants.baseUrl}/products');

  if (response.statusCode == 200) {
    final List<dynamic> goods = response.data['data'];
    final goodsList = goods.map((e) => Goods.fromJson(e)).toList();
    return goodsList;
  } else {
    throw Exception('Failed to load Goods');
  }
});
