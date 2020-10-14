import 'dart:convert';

import 'package:f_groceries/Utils/constants.dart';
import 'package:f_groceries/Utils/woocommerce_api.dart';
import 'package:f_groceries/database/user/db_helper.dart';
import 'package:f_groceries/database/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

class UnDeliveredOrder extends StatefulWidget {
  final int id;
  final String date;
  final String status;
  final String payment;
  final String total;
  final String itemstring;
  final List items;
  final String addressLine;

  var key_tile;

  UnDeliveredOrder(
      {Key key,
      @required this.key_tile,
      @required this.id,
      @required this.date,
      @required this.status,
      @required this.payment,
      @required this.total,
      @required this.itemstring,
      @required this.items,
      @required this.addressLine})
      : super(key: key);

  @override
  _UnDeliveredOrderState createState() => _UnDeliveredOrderState();
}

class _UnDeliveredOrderState extends State<UnDeliveredOrder> {
  List rating = [];
  bool _rLoading = false;
  bool _revieweCheckLoading = true;
  TextEditingController _commentsController;
  bool _reviewed;
  List rating_fromDB = [];
  String customer_comment;
  String review;
  String status;
  

  WooCommerceAPI wc_api = WooCommerceAPI("${Constants.baseURL}",
      "${Constants.consumerKey}", "${Constants.consumerSecret}");
  bool flag = true;

  initRatings() {
    for (var i = 0; i < widget.items.length; i++) {
      rating.add(0.0);
    }
  }

  checkReviews() async {
     if (mounted) {
        setState(() {
          _revieweCheckLoading = true;
         
        });
     }
     var res = await wc_api.getAsync("orders/${widget.id}");
     var decodedJson = jsonDecode(res.body);

    if (res.statusCode == 200){
      for(var i=0;i<decodedJson['meta_data'].length;i++){
        if(decodedJson['meta_data'][i]['key'] == "Review"){
          review = decodedJson['meta_data'][i]['value'];
          break;
        } 
      }
      if(review != null){
        print("reached");
        if (mounted) {
        setState(() {
          _reviewed = true;
          
         _revieweCheckLoading = false;
         customer_comment = review;
         getRatings();
        });
      }
      }
      else{
          if (mounted) {
        setState(() {
          _reviewed = false;
         _revieweCheckLoading = false;
        });
      }
      }
    }  else{
      if (mounted) {
        setState(() {
          _reviewed = false;
         _revieweCheckLoading = false;
        });
    }
  }
     
  }

   getRatings() async {
    var userdb = UserHelper();
    User user = await userdb.getUser(1);

    for(var i=0;i<widget.items.length;i++){
        var res = await wc_api.getAsync("products/reviews?reviewer_email=${user.email}&product_id=${widget.items[i]['product_id']}");
        var decodedJson = jsonDecode(res.body);
        if(mounted){
             setState(() {
           rating_fromDB.add(decodedJson[0]['rating'].toString());
        });
        }
       
        print(decodedJson);
    }
  }

   bool _showAlert(BuildContext context) {
    var alert = new AlertDialog(
       title: new Text('Review Submitted!'),
      content:new Text('Thank you for reviewing the order.'),
      actions: <Widget>[
        
              new FlatButton(
                //onPressed: () => Navigator.of(context).pop(true),
                color: Theme.of(context).accentColor,
                onPressed:() {
                  
                  Navigator.of(context).pop(false);
                    return true;
                },
                child: new Text('Ok',style: TextStyle(fontSize: 15,color: Colors.white),),
              ),
      ],
    );

    showDialog(context: context, builder: (context) => alert);
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _commentsController = new TextEditingController();
    // initRatings();
    // checkReviews();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.key_tile);
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
                                        // getProductsString(order.lineItems),
                                        widget.itemstring,
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
                                        'Delivered On :' +
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
                                                    widget.id.toString(),
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
                                                    "₹" + widget.total,
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
                                                    widget.payment,
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
                                            text: widget.addressLine,
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
                                        child: widget.status == "cancelled" ? FlatButton.icon(
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
          }):FlatButton.icon(
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
            // Perform some action
            // updateOrder(id, index);
          }))
                                  ],
                                ))))),
                  ]));
  }
}