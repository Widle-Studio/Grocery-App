import 'package:f_groceries/payment/razorpay.dart';
import 'package:flutter/material.dart';


class SuccessPage extends StatelessWidget {
  final PaymentSuccessResponse response;
  SuccessPage({
    @required this.response,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Success"),
      ),
      body: Center(
        child: Container(
          child: Text(
            "Your payment is successful and the response is\n OrderId: ${response.orderId}\nPaymentId: ${response.paymentId}\nSignature: ${response.signature}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              color: Colors.green,
            ),
          ),
        ),
      ),
    );
  }
}