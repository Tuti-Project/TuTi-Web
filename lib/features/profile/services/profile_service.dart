import 'package:dio/dio.dart';

import '../models/profile_model.dart';

class ProfileService {
  final Dio _dio = Dio();

  Future<List<Profile>> fetchProfiles() async {
    try {
      Response response =
          await _dio.get('https://your-api-endpoint.com/profiles');
      List<dynamic> data = response.data;

      List<Profile> profiles = data
          .map((item) => Profile(
                name: item['name'],
                university: item['university'],
                isOn: item['isOn'],
                keywords: List<String>.from(item['keywords']),
              ))
          .toList();

      return profiles;
    } catch (error) {
      throw Exception('Failed to fetch profiles');
    }
  }
}
