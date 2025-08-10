import 'package:car_rental/core/services/order_controller.dart';
import 'package:car_rental/core/utils/mainpage.dart';
import 'package:car_rental/screen/intro/splash.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  var email = "".obs;
  var isLoggedIn = false.obs;
  var username = "".obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserLoginStatus();
  }

  Future<void> _loadUserLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    bool loggedIn = prefs.getBool("isLoggedIn") ?? false;
    if (loggedIn) {
      email.value = prefs.getString("user_email") ?? "";
      username.value = prefs.getString("username") ?? "";
      isLoggedIn.value = true;

      // Sync ke OrderController
      final orderController = Get.find<OrderController>();
      orderController.userEmail.value = email.value;
      await orderController.loadOrderData();
    }
  }

  //signup
  Future<void> signUp(
    String name,
    String email,
    String phone,
    String password,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("username", name);
    await prefs.setString("user_email", email);
    await prefs.setString("user_phone", phone);
    await prefs.setString("user_password", password);
    await prefs.setBool("isLoggedIn", true);

    this.email.value = email;

    isLoggedIn.value = true;

    Get.offAll(() => Mainpage());
  }

  //login
  Future<bool> login(String emailInput, String passwordInput) async {
    final prefs = await SharedPreferences.getInstance();

    String? savedEmail = prefs.getString("user_email");
    String? savedPassword = prefs.getString("user_password");
    String? savedUsername = prefs.getString("username");

    if (savedEmail == emailInput && savedPassword == passwordInput) {
      email.value = savedEmail!;
      username.value = savedUsername!;
      isLoggedIn.value = true;
      await prefs.setBool("isLoggedIn", true);
      final orderController = Get.find<OrderController>();
      orderController.userEmail.value = savedEmail;
      await orderController.loadOrderData();

      Get.to(() => Mainpage());
      return true;
    } else {
      return false;
    }
  }

  //logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLoggedIn", false);

    isLoggedIn.value = false;
    email.value = "";
    username.value = "";
    Get.offAll(() => Splash());
  }
}
