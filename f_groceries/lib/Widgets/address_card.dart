
import 'package:cached_network_image/cached_network_image.dart';
import 'package:f_groceries/screens/item_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';

class Address_Card extends StatefulWidget {

  String firstname;
  String lastname;
  String address_1;
  String address_2;
  String city;
  String postcode;
  bool checkboxValueB;

  Address_Card({
    Key key,
    @required this.firstname,
    @required this.lastname,
    @required this.address_1,
    @required this.address_2,
    @required this.city,
    @required this.postcode,
    @required this.checkboxValueB,
  }) : super(key: key);

  @override
  _Address_CardState createState() => _Address_CardState();
}

class _Address_CardState extends State<Address_Card> {
  var unescape = new HtmlUnescape();

    @override
  Widget build(BuildContext context) {
    return Container(
                    height: 130.0,
                    width: 200.0,
                    margin: EdgeInsets.all(7.0),
                    child: Card(
                      elevation: 3.0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Column(
                            children: <Widget>[
                              new Container(
                                margin: EdgeInsets.only(
                                    left: 12.0,
                                    top: 5.0,
                                    right: 0.0,
                                    bottom: 5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Text(
                                      widget.firstname+" "+widget.lastname,
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                      Container(
                                      padding: EdgeInsets.all(2.0),
                                    ),
                                    new Text(
                                      widget.address_1,
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 13.0,
                                          letterSpacing: 0.5),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(2.0),
                                    ),
                                    new Text(
                                      widget.address_2,
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 13.0,
                                          letterSpacing: 0.5),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(2.0),
                                    ),
                                    new Text(
                                      widget.city,
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 13.0,
                                          letterSpacing: 0.5),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(2.0),
                                    ),
                                    new Text(
                                      widget.postcode,
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 13.0,
                                          letterSpacing: 0.5),
                                    ),
                                    new Container(
                                      margin: EdgeInsets.only(
                                          left: 00.0,
                                          top: 05.0,
                                          right: 0.0,
                                          bottom: 5.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          new Text(
                                            'Delivery Address',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black12,
                                            ),
                                          ),
                                         Container(
        margin: EdgeInsets.only(left: 3.0, right: 0.0, top: 0.0, bottom: 0.0),
      ),
                                          new Checkbox(
                                            value: widget.checkboxValueB,
                                            onChanged: (bool value) {
                                              // setState(() {
                                              //   checkboxValueB = value;
                                              // });
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );

  }
}
