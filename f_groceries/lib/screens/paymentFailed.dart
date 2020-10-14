import 'package:f_groceries/payment/razorpay.dart';
import 'package:flutter/material.dart';


class FailedPage extends StatelessWidget {
  final PaymentFailureResponse response;
  FailedPage({
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
            "Your payment is Failed and the response is\n Code: ${response.code}\nMessage: ${response.message}",
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