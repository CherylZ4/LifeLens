import 'package:dio/dio.dart';

final dio = Dio();
Future<bool> checkUserExist(String? username) async {
  Response response;
  response = await dio.get(
      'http://ec2-35-182-44-172.ca-central-1.compute.amazonaws.com:8000/user/exist/$username');
  print(response.data);
  return response.data;
}

Future<String> modifyUser(Map user) async {
  Response response;
  response = await dio.post(
      'http://ec2-35-182-44-172.ca-central-1.compute.amazonaws.com:8000/user/modify',
      data: user);
  print(response.data);
  return response.data;
}

Future<Map> addUser(Map user) async {
  Response response;
  response = await dio.post(
      'http://ec2-35-182-44-172.ca-central-1.compute.amazonaws.com:8000/user/add/',
      data: user);
  print(response.data);
  return response.data;
}

Future<Map> getUser(String username) async {
  Response response;
  response = await dio.get(
    'http://ec2-35-182-44-172.ca-central-1.compute.amazonaws.com:8000/get/$username',
  );
  print(response.data);
  return response.data;
}

Future<Map> getGroupInfo(String groupname) async {
  Response response;
  response = await dio.get(
    'http://ec2-35-182-44-172.ca-central-1.compute.amazonaws.com:8000/group/$groupname',
  );
  print(response.data);
  return response.data;
}

Future<String> newGroup(Map group) async {
  Response response;
  response = await dio.post(
    'http://ec2-35-182-44-172.ca-central-1.compute.amazonaws.com:8000/group/new',
    data: group,
  );
  print(response.data);
  return response.data;
}

Future<String> addGroupMember(Map group) async {
  Response response;
  response = await dio.post(
    'http://ec2-35-182-44-172.ca-central-1.compute.amazonaws.com:8000/group/add',
    data: group,
  );
  print(response.data);
  return response.data;
}

Future<Map> groupUserList(String username) async {
  Response response;
  response = await dio.get(
    'http://ec2-35-182-44-172.ca-central-1.compute.amazonaws.com:8000/grouplist/$username',
  );
  print(response.data);
  return response.data;
}

Future<Map> groupBirthday(String groupname) async {
  Response response;
  response = await dio.get(
    'http://ec2-35-182-44-172.ca-central-1.compute.amazonaws.com:8000/group/birthdays/$groupname',
  );
  print(response.data);
  return response.data;
}

Future<Map> genBirthday(String username) async {
  Response response;
  response = await dio.get(
    'http://ec2-35-182-44-172.ca-central-1.compute.amazonaws.com:8000/group/birthday/$username',
  );
  print(response.data);
  return response.data;
}
