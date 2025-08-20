import 'package:car_rental/core/services/order_controller.dart';
import 'package:car_rental/core/utils/mainpage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  var email = "".obs;
  var isLoggedIn = false.obs;
  var username = "".obs;
  var phone = "".obs;
  var userPhotoPath = RxnString();

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
      phone.value = prefs.getString("user_phone") ?? "";
      userPhotoPath.value = prefs.getString("user_photo");
      isLoggedIn.value = true;

      // Sync OrderController
      final orderController = Get.find<OrderController>();
      orderController.userEmail.value = email.value;
      await orderController.loadOrderData();
    }
  }

  //signup
  Future<void> signUp(
    String nameInput,
    String emailInput,
    String phoneInput,
    String passwordInput,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("username", nameInput);
    await prefs.setString("user_email", emailInput);
    await prefs.setString("user_phone", phoneInput);
    await prefs.setString("user_password", passwordInput);
    await prefs.setBool("isLoggedIn", true);

    username.value = nameInput;
    email.value = emailInput;
    phone.value = phoneInput;
    isLoggedIn.value = true;

    Get.offAll(() => Mainpage());
  }

  //login
  Future<bool> login(String emailInput, String passwordInput) async {
    final prefs = await SharedPreferences.getInstance();

    String? savedEmail = prefs.getString("user_email");
    String? savedPassword = prefs.getString("user_password");
    String? savedUsername = prefs.getString("username");
    String? savedUserPhone = prefs.getString("user_phone");
    String? savedPhotoPath = prefs.getString("user_photo");

    if (savedEmail == emailInput && savedPassword == passwordInput) {
      await prefs.setBool("isLoggedIn", true);
      email.value = savedEmail!;
      username.value = savedUsername!;
      phone.value = savedUserPhone ?? "";
      userPhotoPath.value = savedPhotoPath;
      isLoggedIn.value = true;
      final orderController = Get.find<OrderController>();
      orderController.userEmail.value = savedEmail;
      await orderController.loadOrderData();

      Get.to(
        () => Mainpage(),
        transition: Transition.native,
        duration: Duration(milliseconds: 800),
      );
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
    phone.value = "";
  }

  Future<void> updatePhoto(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("user_photo", path);
    userPhotoPath.value = path;
  }

  Future<void> updateProfil({
    String? newName,
    String? newPhone,
    String? newPhotoPath,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    if (newName != null) {
      await prefs.setString("username", newName);
      username.value = newName;
    }
    if (newPhone != null) {
      await prefs.setString("user_phone", newPhone);
      phone.value = newPhone;
    }
    if (newPhotoPath != null) {
      await prefs.setString("user_photo", newPhotoPath);
      userPhotoPath.value = newPhotoPath;
    }
  }

  Future<void> updatePassword(String? newPassword) async {
    final prefs = await SharedPreferences.getInstance();
    if (newPassword != null) {
      await prefs.setString("user_password", newPassword);
    }
  }

  Future<bool> verifyOldPassword(String oldPasswordInput) async {
    final prefs = await SharedPreferences.getInstance();
    String? savedPassword = prefs.getString("user_password");

    if (savedPassword == oldPasswordInput) {
      return true;
    } else {
      return false;
    }
  }
}
