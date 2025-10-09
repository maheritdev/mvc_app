import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mvc_app/core/utils/safe.dart';
import 'package:mvc_app/features/login/model/login_model.dart';

import '../../../core/const/api_const.dart';
import '../../../core/utils/shared_preferences_helper.dart';

class AuthProvider with ChangeNotifier {
  bool? isLoading=false;
  String? error;
  LoginModel? loginModel;


  Future<void> Login({required String phone, required String password}) async {
    isLoading = true;
    error = null;
    notifyListeners();
    print("login");
    print(ApiConst.LOGIN);
    Safe.call(() async {
      final body = {"phone": phone, "password": password};
      var response = await ApiConst.POST(url: Uri.parse(ApiConst.LOGIN), bodyData: body);
      /*var response = await http.post(
        Uri.parse(ApiConst.LOGIN),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );*/
      print(response?.statusCode);
      print(response?.body);
      if (response?.statusCode == 200) {
        var result = jsonDecode(response!.body);
        loginModel = LoginModel.fromJson(result);
        String token = loginModel!.accessToken!;
        String user_id = loginModel!.user!.id.toString();
        String user_username = loginModel!.user!.username!;
        String user_email = loginModel!.user!.email!;
        String user_phone = loginModel!.user!.phone!;
        String user_role = loginModel!.user!.role!;
        SharedPreferencesHelper.saveString("token", token);
        SharedPreferencesHelper.saveString("id", user_id);
        SharedPreferencesHelper.saveString("username", user_username);
        SharedPreferencesHelper.saveString("email", user_email);
        SharedPreferencesHelper.saveString("phone", user_phone);
        SharedPreferencesHelper.saveString("role", user_role);
        print("Token is : $token");
        print("user_id is : $user_id");
        print("user_username is : $user_username");
        print("user_email is : $user_email");
        print("user_phone is : $user_phone");
        print("user_role is : $user_role");
      }else{
        isLoading=false;
        error="Something went wrong";
        notifyListeners();
      }
    });
  }
}
