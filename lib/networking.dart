import 'package:dio/dio.dart';

class ApiServices {
  late Dio dio;
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  BaseOptions getOptions() => Dio().options
    ..baseUrl = baseUrl
    ..connectTimeout = Duration(seconds: 30)
    ..receiveTimeout = Duration(seconds: 30)
    ..receiveDataWhenStatusError = true
    ..headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
    }
    ..followRedirects = true;

  ApiServices() {
    dio = Dio(getOptions());
  }

  Future<List<dynamic>> getList() async {
    try {
      final response = await dio.get('/posts');
      if (response.statusCode == 200) {
        return response.data as List<dynamic>;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getDetail(int id) async {
    try {
      final response = await dio.get('/posts/$id');
      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> postData(Map<String, dynamic> data) async {
    try {
      final response = await dio.post('/posts', data: data);
      if (response.statusCode != 201) {
        throw Exception('Failed to post data');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> putData(int id, Map<String, dynamic> data) async {
    try {
      final response = await dio.put('/posts/$id', data: data);
      if (response.statusCode != 200) {
        throw Exception('Failed to update data');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteData(int id) async {
    try {
      final response = await dio.delete('/posts/$id');
      if (response.statusCode != 200) {
        throw Exception('Failed to delete data');
      }
    } catch (e) {
      rethrow;
    }
  }
}
