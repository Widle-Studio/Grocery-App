import 'dart:convert';
// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:f_groceries/Utils/constants.dart';
import 'package:f_groceries/Utils/woocommerce_api.dart';
import 'package:f_groceries/database/cart/cart.dart';
import 'package:f_groceries/database/cart/db_helper.dart';
import 'package:f_groceries/payment/razorpay.dart';
import 'package:f_groceries/screens/HomeScreen.dart';
import 'package:f_groceries/screens/coupon_code.dart';
import 'package:f_groceries/screens/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:geocoder/geocoder.dart';
import 'package:http/http.dart';

class Payment extends StatefulWidget {

  final String firstName;
  final String lastName;
  final String email;
  // final String phone;
  final String address1;
  final String address2;
  final String city;
  // final String state;
  final String postCode;
  final String country;
  final String phone;
  final double grandTotal;
  final int userId;
  final bool new_address;


  Payment(
    {Key key,
      @required this.firstName,
      @required this.lastName,
      @required this.email,
      @required this.address1,
      @required this.address2,
      @required this.city,
      @required this.postCode,
      @required this.phone,
      @required this.country,
      @required this.grandTotal,
      @required this.userId,
      @required this.new_address}
  ): super(key: key);
  @override
  State<StatefulWidget> createState() => payment();
}

class Item {
  final String itemName;
  final String itemQun;
  final String itemPrice;

  Item({this.itemName, this.itemQun, this.itemPrice});
}

class payment extends State<Payment> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool checkboxValueA = true;
  bool checkboxValueB = false;
  bool checkboxValueC = false;

  WooCommerceAPI wc_api = WooCommerceAPI("${Constants.baseURL}",
    "${Constants.consumerKey}", "${Constants.consumerSecret}");

  bool _loading = false;
  List items = List();
  var db = CartHelper();
  Razorpay _razorpay = Razorpay();
  var options;
  String payment_method;
  var couponCode = null;
  double discountedPrice = 0.00;
  double grandTotal = 0.00;
  double shippingCharges = 0.00;
  double taxCharges = 0.00;
  final databaseReference = Firestore.instance;

  IconData _backIcon() {
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return Icons.arrow_back;
      case TargetPlatform.iOS:
        return Icons.arrow_back_ios;
    }
    assert(false);
    return null;
  }

  Future payData() async {
    try {
      _razorpay.open(options);
    } catch (e) {
      print("errror occured here is ......................./:$e");
    }

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

    void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print("payment has succedded");
    print(response.paymentId);
    print(response.orderId);
    print(response.signature);
    // Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(
    //     builder: (BuildContext context) => SuccessPage(
    //           response: response,
    //         ),
    //   ),
    //   (Route<dynamic> route) => false,
    // );

    // placeOrder(payment_method);
    _razorpay.clear();
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("payment has error00000000000000000000000000000000000000");
    // Do something when payment fails
    // Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(
    //     builder: (BuildContext context) => FailedPage(
    //           response: response,
    //         ),
    //   ),
    //   (Route<dynamic> route) => false,
    // );

    _showNotif(context, "Payment Failed", "Payment failed. Please retry.");
    _razorpay.clear();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("payment has externalWallet33333333333333333333333333");

    _razorpay.clear();
    // Do something when an external wallet is selected
  }

  int radioValue = 0;
  void handleRadioValueChanged(int value) {
    setState(() {
      radioValue = value;
    });
  }


  String toolbarname = 'CheckOut';

  getItems() async {
    setState(() {
      _loading = true;
    });
    // user = await userdb.getUser(1);
    List res = await db.getCarts();
    setState(() {
      if (res.length == 0) {
        _loading = false;
      } else {
        for (var i = 0; i < res.length; i++) {
          Cart cart = Cart.fromMap(res[i]);
          Map item = {"product_id": cart.productId, "quantity": cart.quantity};
          print("here");
          print(item);
          items.add(item);
        }
        _loading = false;
      }
    });
  }


  deleteItems() async {
    setState(() {
      _loading = true;
    });
    List res = await db.getCarts();

    if (res.length == 0) {
      _loading = false;
    } else {
      for (var i = 0; i < res.length; i++) {
        Cart cart = Cart.fromMap(res[i]);

        int del = await db.deleteCart(cart.id);
      }
      _loading = false;
    }

    _showNotif(context, "Order Received", "Thank You for your order.");
   
  }


  placeOrder(String method) async {
    print(widget.grandTotal);
    print(items);
      setState(() {
        _loading = true;
      });

      // var res = await wc_api.postAsync(
      //   "customers/${widget.userId}", 
      //   {
      //     "billing": {
      //         "first_name": widget.firstName== null ? "" : widget.firstName,
      //         "last_name": widget.lastName == null ? "" : widget.lastName,
      //         "address_1": widget.address1 == null ? "" : widget.address1,
      //         "address_2": widget.address2 == null ? "" : widget.address2,
      //         "city": widget.city == null ? "" : widget.city,
      //         "state": "",
      //         "phone": widget.phone == null ?"": widget.phone,
      //         "postcode": widget.postCode == null ? "" : widget.postCode,
      //         "country": widget.country == null ? "" : widget.country,
      //         "email": widget.email == null ? "" : widget.email,
      //       },
      
      //   }
      // );

      if(widget.new_address){
      DocumentReference ref = await databaseReference.collection("users").document(widget.email).collection("addresses")
      .add({
              "first_name": widget.firstName== null ? "" : widget.firstName,
              "last_name": widget.lastName == null ? "" : widget.lastName,
              "address_1": widget.address1 == null ? "" : widget.address1,
              "address_2": widget.address2 == null ? "" : widget.address2,
              "city": widget.city == null ? "" : widget.city,
              "state": "",
              "phone": widget.phone == null ?"": widget.phone,
              "postcode": widget.postCode == null ? "" : widget.postCode,
              "country": widget.country == null ? "" : widget.country,
              "email": widget.email == null ? "" : widget.email,
      });
      }

      
      var res = await wc_api.postAsync(
          "orders",
          {
            
            "status": "processing",
            "set_paid": false,
            "customer_id": widget.userId,
            "total": widget.grandTotal.toString(),
            "billing": {
              "first_name": widget.firstName== null ? "" : widget.firstName,
              "last_name": widget.lastName == null ? "" : widget.lastName,
              "address_1": widget.address1 == null ? "" : widget.address1,
              "address_2": widget.address2 == null ? "" : widget.address2,
              "city": widget.city == null ? "" : widget.city,
              "state": "",
              "postcode": widget.postCode == null ? "" : widget.postCode,
              "country": widget.country == null ? "" : widget.country,
              "email": widget.email == null ? "" : widget.email,
            },
            "payment_method": method,
            "line_items": items,
            "meta_data": [
            ],
            "shipping_lines": [
              {
                "method_title": "Flat Rate",
                "method_id": "flat_rate",
                "instance_id": "",
                "total": "0"
              }
            ],
          },
        );
      

      setState(() {
        _loading = false;
      });

      if (res.statusCode == 201) {
        setState(() {
          _loading = true;
        });
        deleteItems();
        setState(() {
          _loading = false;
        });

        var decodedJson = jsonDecode(res.body);

        databaseReference.collection("users").document(widget.email).collection("orders").document(decodedJson['id'].toString())
      .setData({
              "order_id": decodedJson['id'],
      });
  }
  }

 String getTime(){
      String time_string = "";
      TimeOfDay time = TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
      if (time.period == DayPeriod.pm){
        time_string = (int.parse(DateTime.now().hour.toString())-12).toString()+":"+DateTime.now().minute.toString()+ " " + "PM";
      }else{
        time_string = DateTime.now().hour.toString()+":"+DateTime.now().minute.toString()+ " " + "AM";
      }
      return time_string;
  }

  void _showNotif(BuildContext context, String title, String body){
    showDialog(
      context: context,
      builder: (context)=>AlertDialog(
        title: Text(title),
        content: Html(
          data: body,
        ),

        actions: <Widget>[

          FlatButton(
            onPressed: (){

              if(title == "Payment Failed"){
                Navigator.of(context).pop();
              }else{
                  Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Home_screen(
          );
        },
      ),
    );
              }
            
              },
            child: Text("OK"),
          )
        ],
      ),
    );
  }

createOrder() async {
  String username = Constants.razorpay_key_id;
  String password = Constants.razorpay_key_secret;
  String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$username:$password'));
  print(basicAuth);

  // Response r = await get('https://api.razorpay.com/v1/orders',
  //     headers: <String, String>{'authorization': basicAuth});

  String url = 'https://api.razorpay.com/v1/orders';
  Map<String, String> headers = {'authorization': basicAuth,'Content-type': 'application/json'};
  String data = '{"amount": ${widget.grandTotal.toInt()*100},"currency": "INR","receipt": "receipt#1","payment_capture": 1}';

  var response = await post(url, headers: headers, body: data);

  print(response.statusCode);
  print(response.body);
  if(response.statusCode == 200){
    var decodedJson = json.decode(response.body);
    String order_id = decodedJson['id'];
    payBill(order_id);
  }else{
    print("something went wrong");
  }

  }

  payBill(String order_id){

    print(widget.phone);
    print(widget.email);
    switch (radioValue) {
        case 0:
          payment_method = "wallet";
          break;
        case 1:
          payment_method = "upi";
          break;
        case 2:
          payment_method = "netbanking";
          break;
        case 3:
          payment_method = "card";
          break;
        case 4:
          payment_method = "COD";
      }

      if(radioValue==4){
        placeOrder(payment_method);
      }else{
      
      options = {
      'key': "rzp_test_ypyDSrafN496cJ", // Enter the Key ID generated from the Dashboard

      'amount': widget.grandTotal*100, //in the smallest currency sub-unit.
      'name': 'Imperial Infosys',
      'order_id': order_id,
      'currency': "INR",
      'theme.color': "#FFA500",
      'buttontext': "Pay with Razorpay",
      'description': 'RazorPay example',
      'prefill': {
        'contact': widget.phone,
        'email': widget.email,
        'method': payment_method,
      }
    };

    setState(() {
      payment_method = payment_method;
    });
    payData();
      }



  }
  
    _navigateAndDisplayCoupon(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Coupon_code(
                total: widget.grandTotal,
              )),
    );

    couponCode = result;
    setState(() {
      couponCode != null
          ? discountedPrice = -(double.parse((widget.grandTotal *
                  double.parse(couponCode['amount'].toString()) *
                  0.01)
              .toStringAsFixed(0)))
          : discountedPrice = 0.00;

      grandTotal = widget.grandTotal + discountedPrice + shippingCharges + taxCharges;
    });
  }


getShippingCharges(String query) async {
  try{
  var addresses = await Geocoder.local.findAddressesFromQuery(query);
  print(addresses.first.coordinates);

  Dio dio = new Dio();
  var response=await dio.get("https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=40.6655101,-73.89188969999998&destinations=40.6905615%2C,-73.9976592&key=AIzaSyCs4vV-s8QxwrwydI2KR_AxSqdmIt3UH7Q");
  print(response.data);
  }on PlatformException catch (e) {
    print(e.code);
    }
  }


  @override
  void initState() {
    super.initState();
    getItems();
    getShippingCharges(widget.address1+widget.address2+widget.city);
    taxCharges = widget.grandTotal*0.05;
      setState(() {
    grandTotal = widget.grandTotal + discountedPrice + shippingCharges + taxCharges;
  });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final double height = MediaQuery.of(context).size.height;

    AppBar appBar = AppBar(
      leading: IconButton(
        icon: Icon(_backIcon()),
        alignment: Alignment.centerLeft,
        tooltip: 'Back',
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(toolbarname, style: TextStyle(fontWeight: FontWeight.bold)),
      backgroundColor: Colors.white,
      actions: <Widget>[
        new Padding(
          padding: const EdgeInsets.all(10.0),
          child: new Container(
            height: 150.0,
            width: 30.0,
            child: new GestureDetector(
              onTap: () {
                /*Navigator.of(context).push(
                  new MaterialPageRoute(
                      builder:(BuildContext context) =>
                      new CartItemsScreen()
                  )
              );*/
              },
            ),
          ),
        )
      ],
    );

    return new Scaffold(
      key: _scaffoldKey,
      appBar: appBar,
      body: Container(
        color: Colors.orange.withOpacity(0.07),
        child: new ListView(
        // shrinkWrap: true,
        children: <Widget>[
          Container(

              margin: EdgeInsets.all(5.0),
              child: Card(
                  child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // three line description
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Container(
                                    alignment: Alignment.center,
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          'Delivery',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black38),
                                        ),
                                        IconButton(
                                            icon: Icon(
                                              Icons.play_circle_outline,
                                              color: Colors.black38,
                                            ),
                                            onPressed: null)
                                      ],
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Container(
                                    alignment: Alignment.center,
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          'Payment',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        IconButton(
                                            icon: Icon(
                                              Icons.check_circle,
                                              color: Colors.orange,
                                            ),
                                            onPressed: null)
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        ],
                      )))),

          // _verticalDivider(),
          Container(
              margin: EdgeInsets.all(5.0),
              child:  Card(
                child: Container(
                  // color: Colors.green.shade100,
                  child: Container(
                      padding:
                          const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      child:  couponCode == null ?  GestureDetector(
                        onTap: () {
                   _navigateAndDisplayCoupon(context);
                },
                child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(

                            children: <Widget>[
                               Icon(Icons.person_pin_circle, color: Theme.of(context).accentColor),
                          SizedBox(width: 10,),
                          Text(
                          "PROMO CODE",
                          maxLines: 10,
                          style: TextStyle(
                              fontSize: 13.0, color: Theme.of(context).accentColor, fontWeight: FontWeight.bold))
                            ],
                          ),

                          Icon(Icons.arrow_forward_ios,  color: Theme.of(context).accentColor)
                         
                        ],
                      )
                      ): Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(

                            children: <Widget>[
                               Icon(Icons.person_pin_circle, color: Colors.green),
                          SizedBox(width: 10,),
                          Text(
                          couponCode['code'] + " Applied!",
                          maxLines: 10,
                          style: TextStyle(
                              fontSize: 13.0, color: Colors.green, fontWeight: FontWeight.bold))
                            ],
                          ),
                                      InkWell(
                                        child: Text(
                          "REMOVE",
                          maxLines: 10,
                          style: TextStyle(
                              fontSize: 13.0, color: Colors.red, fontWeight: FontWeight.bold)),
                                        onTap: () {
                                          setState(() {
                                            couponCode = null;
                                          });
                                        },
                                      )
                                    ],
                                  ),   ),
                ),
              )
              
                                  ),
          new Container(
            alignment: Alignment.topLeft,
            margin:
                EdgeInsets.only(left: 12.0, top: 5.0, right: 0.0, bottom: 0.0),
            child: new Text(
              'Payment Method',
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
          ),
          // _verticalDivider(),
          new Container(
              // height: 264.0,
              margin: EdgeInsets.all(10.0),
              child: Card(
                child: Container(
                  child: Container(
                      child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Wallet",
                                maxLines: 10,
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.black)),
                            Radio<int>(
                                value: 0,
                                groupValue: radioValue,
                                onChanged: handleRadioValueChanged),
                          ],
                        ),
                      ),
                      Divider(),
                      _verticalD(),
                      Container(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("UPI",
                                maxLines: 10,
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.black)),
                            Radio<int>(
                                value: 1,
                                groupValue: radioValue,
                                onChanged: handleRadioValueChanged),
                          ],
                        ),
                      ),
                      Divider(),
                      _verticalD(),
                      Container(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Net Banking",
                                  maxLines: 10,
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.black)),
                              Radio<int>(
                                  value: 2,
                                  groupValue: radioValue,
                                  onChanged: handleRadioValueChanged),
                            ],
                          )),
                      Divider(),
                      _verticalD(),
                      Container(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Credit / Debit / ATM Card",
                                  maxLines: 10,
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.black)),
                              Radio<int>(
                                  value: 3,
                                  groupValue: radioValue,
                                  onChanged: handleRadioValueChanged),
                            ],
                          )),
                      Divider(),
                      _verticalD(),
                      Container(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Cash on Delivery",
                                  maxLines: 10,
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.black)),
                              Radio<int>(
                                  value: 4,
                                  groupValue: radioValue,
                                  onChanged: handleRadioValueChanged),
                            ],
                          )),
                      Divider(),
                    ],
                  )),
                ),
              )),
          // Container(
          //     alignment: Alignment.bottomLeft,
          //     height: 50.0,
          //     child: Card(
          //       child: Row(
          //         mainAxisSize: MainAxisSize.max,
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: <Widget>[
          //           IconButton(icon: Icon(Icons.info), onPressed: null),
          //           Text(
          //             'Total :',
          //             style: TextStyle(
          //                 fontSize: 17.0,
          //                 color: Colors.black,
          //                 fontWeight: FontWeight.bold),
          //           ),
          //           Text(
          //             '\₹'+ widget.grandTotal.toString(),
          //             style: TextStyle(fontSize: 17.0, color: Colors.black54),
          //           ),
          //           _loading?Center(
          //                               child: CircularProgressIndicator(
          //                                 valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
          //                               ),
          //                             ):Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Container(
          //               alignment: Alignment.center,
          //               child: OutlineButton(
          //                   borderSide: BorderSide(color: Colors.green),
          //                   child: const Text('PROCEED TO PAY'),
          //                   textColor: Colors.green,
          //                   onPressed: () {
                               
          //                   },
          //                   shape: new OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(30.0),
          //                   )),
          //             ),
          //           ),
          //         ],
          //       ),
          //     )),
        ],
      ),
   
       
      ) ,
      bottomNavigationBar: Builder(
        // Create an inner BuildContext so that the onPressed methods
        // can refer to the Scaffold with Scaffold.of().
        
        builder: (BuildContext context) {
          return Padding(
            
            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
            child:Container(
              color: Colors.white,
              child:  ListView(
              shrinkWrap: true,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // IconButton(icon: Icon(Icons.info), onPressed: null),
                    Row(
                      children: <Widget>[
                        SizedBox(
                        width: 10,
                    ),
                    Text(
                      'Total:',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                        width: 10,
                    ),
                    
                    Text(
                     
                     '\₹'+ (widget.grandTotal+discountedPrice).toInt().toString(),
                      style: TextStyle(fontSize: 17.0, color: Colors.black54),
                    ),
                    SizedBox(
                        width: 5,
                    ),
                     discountedPrice!=0 ? Text(
                     '\₹'+ widget.grandTotal.toInt().toString(),
                      style: TextStyle(fontSize: 13.0, color: Colors.black54, decoration: TextDecoration.lineThrough,),
                    ): Container(),
                      ],
                    ),

                    
                    Row(
                      children: <Widget>[
                        
                    Text(
                      'Shipping:',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                        width: 10,
                    ),
                    Text(
                     '\₹'+ shippingCharges.toInt().toString(),
                      style: TextStyle(fontSize: 17.0, color: Colors.black54),
                    ),
                   
                     SizedBox(
                        width: 10,
                    ),
                      ],
                    ),
                    
                    
                  ],
                ),

                Row(
                   mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  
                  children: <Widget>[
                  Row(
                      children: <Widget>[
                         SizedBox(
                        width: 10,
                    ),
                    Text(
                      'Tax:',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                        width: 10,
                    ),
                    Text(
                     '\₹'+ taxCharges.toInt().toString(),
                      style: TextStyle(fontSize: 17.0, color: Colors.black54),
                    ),
                   
                     SizedBox(
                        width: 10,
                    ),
                      ],
                    ),

                     Row(
                      children: <Widget>[
                       
                    Text(
                      'To Pay:',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                        width: 10,
                    ),
                    Text(
                     '\₹'+ grandTotal.toInt().toString(),
                      style: TextStyle(fontSize: 17.0, color: Colors.black54),
                    ),

                     SizedBox(
                        width: 10,
                    ),
                      ],
                    ),
                ],),
                Container(
              alignment: Alignment.bottomLeft,
              height: 60.0,
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // IconButton(icon: Icon(Icons.info), onPressed: null),
                   
                    
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                       child: _loading? Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).accentColor),
                  ),
                ): FlatButton(
            color: Theme.of(context).accentColor,
            shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15.0),
    
  ),
            onPressed: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=> PaymentPage()));
                              radioValue == 4?  confirmationPopup(context):createOrder();
                              
                                // payBill();
                                //  placeOrder();
                                // print(widget.address1);   
            },
            child: Text(radioValue == 4? 'CONFIRM ORDER':'PROCEED TO PAY', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          ),
                      
                      ),
                    ),
                  ],
                ),
              ),
              ],
            ) 
      ,
            )   );
              
              
              
        },
      ),
   
    );
  }

    confirmationPopup(BuildContext context) {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            // backgroundColor:  Theme.of(context).backgroundColor,
            title: new Text('Are you sure?'),
            content: new Text('Do you want to confirm the order?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                color: Theme.of(context).accentColor,
                child: new Text('No',
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
              new FlatButton(
                //onPressed: () => Navigator.of(context).pop(true),
                onPressed: (){
                  Navigator.of(context).pop(true);
                  placeOrder("COD");
                },
                child: new Text('Yes', style: TextStyle(color: Theme.of(context).accentColor,),),
              ),
            ],
          ),
        ) ??
        false;
  }

  _verticalDivider() => Container(
        padding: EdgeInsets.all(2.0),
      );

  _verticalD() => Container(
        margin: EdgeInsets.only(left: 5.0),
      );
}
