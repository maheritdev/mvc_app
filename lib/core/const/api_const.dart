import 'dart:convert';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class ApiConst {

  static final String BASE_URL ="https://aed6017676c8.ngrok-free.app";
  static final String REGISTER ="${BASE_URL}/ECOMMERCE/auth/register.php";
  static final String LOGIN ="${BASE_URL}/ECOMMERCE/auth/login.php";

  static http.Response? response;



  static Future<http.Response?> POST({required Uri url,required Object bodyData}) async {

    try {
      response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(bodyData),
      );

      /*print('Response status: ${response.request}');
      print('Response status: ${response.statusCode}');*/
      // print('Response status: ${response.body}');
      return response;
    } catch (e) {
      print(e);
    }
    return response;
  }

  static Future<Map<String, dynamic>?> GET({required Uri url,String? token}) async {
    try {

      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      var response = await http.get(
        url,
        headers: headers,
      );
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }

      print('Response status: ${response.request}');
      print('Response status: ${response.statusCode}');
      print('Response status: ${response.body}');
      return convert.jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
    }
    return null;
  }


}