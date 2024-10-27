import 'dart:convert';

import 'package:hrm/config/hrm_constant.dart';
import 'package:hrm/model/employee_model.dart';
import 'package:hrm/model/listUser_model.dart';
import 'package:hrm/model/login_model.dart';
import 'package:http/http.dart';

class ApiProvider {
  late Response response;
  String connErr = 'Please check your internet connection and try again';

  Future<Response> getConnect(String url, String token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      return await get(Uri.parse(url), headers: headers);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Response> postConnect(
      String url, Map<String, dynamic> map, String token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final uri = Uri.parse(url);
    var body = jsonEncode(map);
    final encoding = Encoding.getByName('utf-8');
    try {
      return await post(
        uri,
        headers: headers,
        body: body,
        encoding: encoding,
      );
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Response> postConnect1(String url, Map<String, dynamic> map) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    final uri = Uri.parse(url);
    var body = jsonEncode(map);
    final encoding = Encoding.getByName('utf-8');
    try {
      return await post(
        uri,
        headers: headers,
        body: body,
        encoding: encoding,
      );
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Response> deleteConnect(String url, String token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final uri = Uri.parse(url);
    final encoding = Encoding.getByName('utf-8');
    try {
      return await delete(
        uri,
        headers: headers,
        encoding: encoding,
      );
    } catch (e) {
      throw e.toString();
    }
  }

  Future<LoginModel?> login(
      String email, String password, String site, String token) async {
    var postData = {'no_': email, 'password': password, 'site': site};
    response = await postConnect(loginAPI, postData, token);
    if (response.statusCode == statusOk) {
      LoginModel model = LoginModel.fromJson(jsonDecode(response.body));
      return model;
    } else {
      return null;
    }
  }

  Future<LoginModel?> login1(String email, String password) async {
    var postData = {'email': email, 'password': password};
    response = await postConnect1(loginAPI1, postData);
    print('response.statusCode: ${response.statusCode}');
    if (response.statusCode == statusOk) {
      LoginModel model = LoginModel.fromJson(jsonDecode(response.body));
      return model;
    } else {
      return null;
    }
  }

  Future<List<ListuserModel>> getListUser(String site, String token) async {
    final response = await getConnect('$getListUserUri/$site', token);

    if (response.statusCode == statusOk) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      // Chuyển đổi danh sách JSON thành danh sách các đối tượng ListuserModel
      print(jsonList);
      return jsonList
          .map((jsonItem) => ListuserModel.fromJson(jsonItem))
          .toList();
    } else {
      return [];
    }
  }
}
