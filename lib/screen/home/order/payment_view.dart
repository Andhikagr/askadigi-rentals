import 'dart:convert';
import 'package:car_rental/core/services/config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

class PaymentView extends StatefulWidget {
  final int bookingId;
  final double totalPrice;
  final String username;
  final String email;
  final String phone;

  const PaymentView({
    super.key,
    required this.bookingId,
    required this.totalPrice,
    required this.username,
    required this.email,
    required this.phone,
  });

  @override
  State<PaymentView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentView> {
  late final WebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) => setState(() => isLoading = false),
          onNavigationRequest: (request) {
            return NavigationDecision.navigate;
          },
        ),
      );

    _createSnapToken();
  }

  Future<void> _createSnapToken() async {
    final url = Uri.parse(ApiConfig.snapCreate);
    final body = {"booking_id": widget.bookingId};

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final snapToken = data['snap_token'];
        final snapUrl =
            "https://app.sandbox.midtrans.com/snap/v2/vtweb/$snapToken";
        _controller.loadRequest(Uri.parse(snapUrl));
      } else {
        Get.snackbar(
          "Error",
          "Failed to create Snap token",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        if (!mounted) return;
        Navigator.pop(context);
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      if (!mounted) return;
      Navigator.pop(context);
    }
  }

  // ignore: unused_element
  Future<void> _updateBookingPaid() async {
    final url = Uri.parse(
      "http://localhost:8080/pay-booking/${widget.bookingId}",
    );
    final res = await http.post(url);

    if (res.statusCode == 200) {
      Get.snackbar(
        "Success",
        "Payment successful",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    if (!mounted) return;
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (isLoading)
              Container(
                color: Colors.black26,
                child: const Center(child: CircularProgressIndicator()),
              ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                ),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),

                      child: Icon(
                        Icons.close_rounded,
                        color: Color(0xFF003984),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
