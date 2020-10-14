import 'dart:convert';

import 'package:f_groceries/Objects/order.dart';
import 'package:f_groceries/Utils/constants.dart';
import 'package:f_groceries/Utils/woocommerce_api.dart';
import 'package:f_groceries/database/user/db_helper.dart';
import 'package:f_groceries/database/user/user.dart';
import 'package:f_groceries/screens/Cart_Screen.dart';
import 'package:f_groceries/screens/item_details.dart';
import 'package:f_groceries/screens/write_review_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart';

class Order_History extends StatefulWidget {
  final String toolbarname;

  Order_History({Key key, this.toolbarname}) : super(key: key);

  @override
  State<StatefulWidget> createState() => order_History(toolbarname);
}

class Item {
  final String name;
  final String deliveryTime;
  final String oderId;
  final String oderAmount;
  final String paymentType;
  final String address;
  final String cancelOder;

  Item(
      {this.name,
      this.deliveryTime,
      this.oderId,
      this.oderAmount,
      this.paymentType,
      this.address,
      this.cancelOder});
}

class order_History extends State<Order_History> {
  List list = ['12', '11'];
  bool checkboxValueA = true;
  bool checkboxValueB = false;
  bool checkboxValueC = false;
  bool _loading = false;
  List currentOrders = [];
  var userdb = UserHelper();
  User user;

  WooCommerceAPI wc_api = WooCommerceAPI("${Constants.baseURL}",
      "${Constants.consumerKey}", "${Constants.consumerSecret}");

  VoidCallback _showBottomSheetCallback;
  // List<Item> itemList = <Item>[
  //   Item(
  //       name: 'Jhone Miller',
  //       deliveryTime: '26-5-2106',
  //       oderId: '#CN23656',
  //       oderAmount: '\₹ 650',
  //       paymentType: 'online',
  //       address: '1338 Karen Lane,Louisville,Kentucky',
  //       cancelOder: 'Cancel Order'),
  //   Item(
  //       name: 'Gautam Dass',
  //       deliveryTime: '10-8-2106',
  //       oderId: '#CN33568',
  //       oderAmount: '\₹ 900',
  //       paymentType: 'COD',
  //       address: '319 Alexander Drive,Ponder,Texas',
  //       cancelOder: 'View Receipt'),
  //   Item(
  //       name: 'Jhone Hill',
  //       deliveryTime: '23-3-2107',
  //       oderId: '#CN75695',
  //       oderAmount: '\₹ 250',
  //       paymentType: 'online',
  //       address: '92 Jarvis Street,Buffalo,New York',
  //       cancelOder: 'View Receipt'),
  //   Item(
  //       name: 'Miller Root',
  //       deliveryTime: '10-5-2107',
  //       oderId: '#CN45238',
  //       oderAmount: '\₹ 500',
  //       paymentType: 'Bhim/upi',
  //       address: '103 Romrog Way,Grand Island,Nebraska',
  //       cancelOder: 'Cancel Order'),
  //   Item(
  //       name: 'Lag Gilli',
  //       deliveryTime: '26-10-2107',
  //       oderId: '#CN69532',
  //       oderAmount: '\₹ 1120',
  //       paymentType: 'online',
  //       address: '8 Clarksburg Park,Marble Canyon,Arizona',
  //       cancelOder: 'View Receipt'),
  // ];

  // String toolbarname = 'Fruiys & Vegetables';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String toolbarname;

  String getProductsString(var orderItems) {
    String productList = "";
    for (var i = 0; i < orderItems.length; i++) {
      productList = productList + orderItems[i]['name'];
      if (i != (orderItems.length - 1)) {
        productList = productList + ",";
      }
    }
    return productList;
  }

  order_History(this.toolbarname);

  updateOrder(int id, int index) async {
    setState(() {
      _loading = true;
    });
    var data = {"status": "cancelled"};
    var res = await wc_api.putAsync("orders/$id", data);
    print(res.statusCode);
    if (res.statusCode == 200) {
      currentOrders[index]["status"] = "cancelled";
      setState(() {
        currentOrders = currentOrders;
        _loading = false;
      });
    } else {
      setState(() {
        _loading = false;
      });
    }
  }

  getOrders() async {
    setState(() {
      _loading = true;
    });
    user = await userdb.getUser(1);

    setState(() {
      user = user;
    });

    if (user != null) {
      var res = await wc_api.getAsync("orders?customer=${user.userId}");
      var decodedJson = jsonDecode(res.body);

      if (res.statusCode == 200 && decodedJson != null) {
        setState(() {
          currentOrders = decodedJson;
          _loading = false;
        });
        // for(var i=0;i<decodedJson.length;i++){

        //   print("erferf");
        //   print(user.userId);
        //   if(decodedJson[i]['status'] == "processing"){
        //     currentOrdersList.add(decodedJson[i]);

        //   }
        //   else{
        //     pastOrdersList.add(decodedJson[i]);
        //   }
        // }

      } else {
        print("Something went wrong");
        if (mounted) {
          setState(() {
            _loading = false;
          });
        }
      }
    } else {
      setState(() {
        _loading = false;
      });
    }
  }

  void _showNotif(BuildContext context, String title, String body) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Html(
          data: body,
          onLinkTap: (url) {
            // _launchURL(url);
          },
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("OK"),
          )
        ],
      ),
    );
  }

    confirmationPopup(BuildContext context, int id, int index) {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            // backgroundColor:  Theme.of(context).backgroundColor,
            title: new Text('Are you sure?'),
            content: new Text('Do you want to cancel the order?'),
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
                  updateOrder(id, index);
                },
                child: new Text('Yes', style: TextStyle(color: Theme.of(context).accentColor,),),
              ),
            ],
          ),
        ) ??
        false;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrders();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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

    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    final Orientation orientation = MediaQuery.of(context).orientation;
    return new Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              _backIcon(),
              color: Colors.black,
            ),
            alignment: Alignment.centerLeft,
            tooltip: 'Back',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            toolbarname,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
        ),
        body: _loading
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).accentColor),
                ),
              )
            : currentOrders.length == 0? Center(
             child: Text("No orders yet!"), 
            ): ListView.builder(
                itemCount: currentOrders.length,
                itemBuilder: (BuildContext cont, int index) {
                  Order order = Order.fromJson(currentOrders[index]);
                  return SafeArea(
                      child: Column(children: <Widget>[
                    Container(
                        margin:
                            EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                        color: Colors.black12,
                        child: Card(
                            elevation: 4.0,
                            child: Container(
                                padding: const EdgeInsets.fromLTRB(
                                    10.0, 10.0, 10.0, 10.0),
                                child: GestureDetector(
                                    child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    // three line description
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        getProductsString(order.lineItems),
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontStyle: FontStyle.normal,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),

                                    Container(
                                      margin: EdgeInsets.only(top: 3.0),
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'To Deliver On :' +
                                            "delivery date here",
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            color: Colors.black54),
                                      ),
                                    ),
                                    Divider(
                                      height: 10.0,
                                      color: Colors.amber.shade500,
                                    ),

                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                            padding: EdgeInsets.all(3.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  'Order Id',
                                                  style: TextStyle(
                                                      fontSize: 13.0,
                                                      color: Colors.black54),
                                                ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 3.0),
                                                  child: Text(
                                                    order.id.toString(),
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.black87),
                                                  ),
                                                )
                                              ],
                                            )),
                                        Container(
                                            padding: EdgeInsets.all(3.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  'Order Amount',
                                                  style: TextStyle(
                                                      fontSize: 13.0,
                                                      color: Colors.black54),
                                                ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 3.0),
                                                  child: Text(
                                                    "₹" + order.total,
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.black87),
                                                  ),
                                                ),
                                              ],
                                            )),
                                        Container(
                                            padding: EdgeInsets.all(3.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  'Payment Type',
                                                  style: TextStyle(
                                                      fontSize: 13.0,
                                                      color: Colors.black54),
                                                ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 3.0),
                                                  child: Text(
                                                    order.paymentMethod,
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.black87),
                                                  ),
                                                )
                                              ],
                                            )),
                                      ],
                                    ),
                                    Divider(
                                      height: 10.0,
                                      color: Colors.amber.shade500,
                                    ),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          Icons.location_on,
                                          size: 20.0,
                                          color: Colors.amber.shade500,
                                        ),
                                        Flexible(child: 
                                        RichText(
                                          overflow: TextOverflow.ellipsis,
                                          strutStyle:
                                              StrutStyle(fontSize: 12.0),
                                          text: TextSpan(
                                            style: TextStyle(
                                                fontSize: 13.0,
                                                color: Colors.black54),
                                            text: order.billing.address1 +
                                                ", " +
                                                order.billing.address2 +
                                                ", " +
                                                order.billing.city,
                                          ),
                                        ),
                                        )
                                        
                                      ],
                                    ),
                                    Divider(
                                      height: 10.0,
                                      color: Colors.amber.shade500,
                                    ),
                                    Container(
                                        child: order.status ==
                                                "cancelled"
                                            ? _status(
                                                "cancelled", order.id, index, order.lineItems, order.metaData)
                                            : _status(
                                                order.status, order.id, index, order.lineItems, order.metaData))
                                  ],
                                ))))),
                  ]));
                }));
  }

  _verticalDivider() => Container(
        padding: EdgeInsets.all(2.0),
      );

  Widget _status(status, id, index, lineitems, metadata) {
    if (status == 'completed') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlatButton.icon(
          label: Text(
            "View Receipt",
            style: TextStyle(color: Colors.green),
          ),
          icon: const Icon(
            Icons.check_circle,
            size: 18.0,
            color: Colors.green,
          ),
          onPressed: () {
            // Perform some action
            _showNotif(context, "Receipt", "Receipt will go here");
          }),
          FlatButton(
          child: Text(
            "Review",
            style: TextStyle(color: Colors.blue, fontSize: 17),
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>WriteReview(key:UniqueKey() ,productList: lineitems, metadata: metadata,)));
          })
        ],
      ) ;
    } else if (status == "cancelled") {
      return FlatButton.icon(
          label: Text(
            "Order Cancelled",
            style: TextStyle(color: Colors.red),
          ),
          icon: const Icon(
            Icons.remove_circle,
            size: 18.0,
            color: Colors.red,
          ),
          onPressed: () {
            // Perform some action
            // updateOrder(id, index);
          });
    } else {
      return FlatButton.icon(
          label: Text(
            "Cancel Order",
            style: TextStyle(color: Colors.red),
          ),
          icon: const Icon(
            Icons.highlight_off,
            size: 18.0,
            color: Colors.red,
          ),
          onPressed: () {
            // updateOrder(id, index);
            confirmationPopup(context, id, index);
          });
    }
  }

  erticalD() => Container(
        margin: EdgeInsets.only(left: 10.0, right: 0.0, top: 0.0, bottom: 0.0),
      );

  bool a = true;
  String mText = "Press to hide";
  double _lowerValue = 1.0;
  double _upperValue = 100.0;

  void _visibilitymethod() {
    setState(() {
      if (a) {
        a = false;
        mText = "Press to show";
      } else {
        a = true;
        mText = "Press to hide";
      }
    });
  }
}
