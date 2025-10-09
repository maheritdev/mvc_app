import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mvc_app/core/utils/safe.dart';
import 'package:mvc_app/features/login/controller/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/const/api_const.dart';
import '../../../core/const/png.dart';
import '../../../core/utils/shared_preferences_helper.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  bool isPassword = true;
  bool? isChecked = false;

  /*Future<void> Login({required String phone, required String password}) async {
    print("login");
    print(ApiConst.LOGIN);
    try {
      final body = {"phone": phone, "password": password};
      var response = await http.post(
        Uri.parse(ApiConst.LOGIN),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        String token = result['access_token'];
        String user_id = result['user']['id'].toString();
        String user_username = result['user']['username'];
        String user_email = result['user']['email'];
        String user_phone = result['user']['phone'];
        String user_role = result['user']['role'];
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


      }
    } catch (e) {
      print(e);
    }
  }*/

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final authProvider = context.watch<AuthProvider>();
    print("${authProvider.isLoading}");

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /*Image.asset(
                PNGs.logo,
                width: width * 1,
                height: height * 0.3,
                fit: BoxFit.cover,
              ),*/
              Image.network(
                "https://images.unsplash.com/photo-1756894256833-934a85a42df9?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                width: width * 1,
                height: height * 0.3,
                fit: BoxFit.cover,
              ),
              SizedBox(height: height * 0.02),
              Text(
                "welcome back !",
                style: TextStyle(color: Colors.amber, fontSize: 25),
              ),
              SizedBox(height: height * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    label: Text("Email"),
                    hintText: "please enter your email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  obscureText: isPassword,
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPassword = !isPassword;
                        });
                      },
                      icon: Icon(
                        isPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                    label: Text("Password"),
                    hintText: "please enter your password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.04),
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (value) async {
                      setState(() {
                        isChecked = value;
                      });
                      await SharedPreferencesHelper.saveBool(
                        "remember",
                        isChecked!,
                      );
                      bool isChecked2 =
                          await SharedPreferencesHelper.getBool("remember") ??
                          false;
                      print(isChecked2);
                    },
                  ),
                  Text("remember me"),
                ],
              ),
              authProvider.isLoading == true  ? CircularProgressIndicator():Container(),
              InkWell(
                onTap: () async {
                    if (emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) {
                      context.read<AuthProvider>().Login(
                        phone: emailController.text,
                        password: passwordController.text,
                      );
                      context
                          .read<AuthProvider>()
                          .isLoading = true;
                      await context.read<AuthProvider>().Login(
                        phone: emailController.text,
                        password: passwordController.text,
                      );
                      print("${context
                          .read<AuthProvider>()
                          .isLoading}");
                    }
                    print("${context
                        .read<AuthProvider>()
                        .isLoading}");
                },
                child: Container(
                  height: height * 0.05,
                  width: width * 0.44,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(child: Text("login")),
                ),
              ),
              SizedBox(height: height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("don't have an account ?"),
                  TextButton(
                    onPressed: () {
                      print("sign up");
                      /*Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignupScreen()),
                      );*/
                    },
                    child: Text("sign up"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}