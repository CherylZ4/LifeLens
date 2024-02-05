import 'package:dio/dio.dart';

final dio = Dio(BaseOptions(
  followRedirects: true,
));
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

Future<Map> getUser(String? username) async {
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

Future<Map> newGroup(Map group) async {
  Response response;
  response = await dio.post(
    'http://ec2-35-182-44-172.ca-central-1.compute.amazonaws.com:8000/newgroup',
    data: group,
    options: Options(
      validateStatus: (status) {
        return status == 307; // Allow 307 status
      },
    ),
  );
  // Check if it's a redirection
  if (response.statusCode == 307) {
    // Extract the redirection URL from response.headers
    String redirectionUrl = response.headers['location']![0];

    // Make another request to the redirection URL
    response = await dio.post(redirectionUrl, data: group);
  }
  print(response.data);
  return response.data;
}

Future<Map<String, dynamic>> addGroupMember(Map group) async {
  try {
    Response response = await Dio().post(
      'http://ec2-35-182-44-172.ca-central-1.compute.amazonaws.com:8000/addtogroup',
      data: group,
      options: Options(
        validateStatus: (status) {
          return status == 307; // Allow 307 status
        },
        headers: {
          'Content-Type':
              'application/json', // Adjust based on actual content type
        },
      ),
    );

    if (response.statusCode == 307) {
      // Extract the redirection URL from response.headers
      String redirectionUrl = response.headers['location']![0];

      // Make another request to the redirection URL using POST
      response = await dio.post(redirectionUrl, data: group);
    }
    print(response.data);
    return response.data;
  } catch (e) {
    print('Error: $e');
    // Handle the error, log additional details, or rethrow if needed
    throw e;
  }
}

Future<Map> groupUserList(String? username) async {
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
