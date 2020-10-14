import 'package:f_groceries/payment/check.dart';
import 'package:flutter/material.dart';


class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Integration"),
      ),
      body: Center(
        child: Container(
          child: RaisedButton(
            color: Colors.green,
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => CheckRazor(),
                  ),
                  (Route<dynamic> route) => false,
                ),
            child: Text(
              "Pay Now",
            ),
          ),
        ),
      ),
    );
  }
}