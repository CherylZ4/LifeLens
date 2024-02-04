import 'package:dio/dio.dart';

final dio = Dio();
Future<bool> checkUserExist(String? username) async {
  Response response;
  response = await dio.get(
      'http://ec2-35-182-44-172.ca-central-1.compute.amazonaws.com:8000/user/exist/$username');
  print(response.data);
  return response.data;
}
