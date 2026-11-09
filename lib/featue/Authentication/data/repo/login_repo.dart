import 'package:focus_flow/core/networking/apiEndPoint.dart';
import 'package:focus_flow/core/networking/dio_factory.dart';
import 'package:focus_flow/core/services/local/local_helper.dart';
import 'package:focus_flow/core/utils/app_constans.dart';

class AuthRepo {
  static Future<bool> Login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await DioFactory.dio?.post(
        ApiEndpoints.login,
        data: {
          "email": email,
          "password": password,
        },
      );

      if (response?.statusCode == 200) {
        final data = response?.data;

        final token = data?["data"]?["token"];

        if (token == null || token.toString().isEmpty) {
          return false;
        }

        await saveToken(token.toString());

        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }
  static Future<bool> Register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String address,
    required String city,
  }) async {
    try {
      final response = await DioFactory.dio?.post(
        ApiEndpoints.register,
        data: {
          "name": name,
          "email": email,
          "password": password,
          "password_confirmation": passwordConfirmation,
         
        },
      );

      if (response?.statusCode == 200 ||
          response?.statusCode == 201) {
        final userData = response?.data?["data"];

        if (userData == null) {
          return false;
        }

        final token = userData["token"];

        if (token == null || token.toString().isEmpty) {
          return false;
        }

        await saveToken(token.toString());

        await LocalHelper.prefs?.setString(
          "user_name",
          userData["name"]?.toString() ?? "",
        );

        await LocalHelper.prefs?.setString(
          "user_email",
          userData["email"]?.toString() ?? "",
        );

        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  
  static Future<void> saveToken(String token) async {
    await LocalHelper.prefs?.setString(
      AppConstans.userToken,
      token,
    );
  }
}