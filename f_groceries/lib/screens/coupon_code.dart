import 'dart:convert';

import 'package:f_groceries/Utils/constants.dart';
import 'package:f_groceries/Utils/woocommerce_api.dart';
import 'package:f_groceries/database/cart/db_helper.dart';
import 'package:f_groceries/database/user/db_helper.dart';
import 'package:f_groceries/database/user/user.dart';
import 'package:flutter/material.dart';

class Coupon_code extends StatefulWidget {
  final double total;

  @override
  _Coupon_codeState createState() => _Coupon_codeState();

  Coupon_code({Key key, this.total}) : super(key: key);
}

class _Coupon_codeState extends State<Coupon_code> {
  final TextEditingController controller = new TextEditingController();
  List couponList;
  bool _loading = false;
  bool _validate = false;
  var db = CartHelper();
  DateTime currentDate = DateTime.now();
  bool minPriceValidated;
  bool maxPriceValidate;
  bool usageLimitValidate;
  bool expiryDateValidated;
  bool productsValidated;
  bool customer_validate;
  bool flag_product = true;
  String errorText ;
  bool coupon_valid = true;

  var userdb = UserHelper();
  User user;

  List cartList;

  WooCommerceAPI wc_api = WooCommerceAPI("${Constants.baseURL}",
      "${Constants.consumerKey}", "${Constants.consumerSecret}");

  getCoupons() async {
    user = await userdb.getUser(1);
    cartList = await db.getCarts();
    setState(() {
      _loading = true;
    });
    var res = await wc_api.getAsync("coupons");
    var decodedJson = jsonDecode(res.body);

    if (res.statusCode == 200 && decodedJson != null) {
      if (mounted) {
        setState(() {
          print("something");
          couponList = decodedJson;
          print(currentDate);

          _loading = false;
        });
      }
    } else {
      print("Something went wrong");
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  validateCoupons(var coupon) async {
   
    flag_product = true;
    double.tryParse("${coupon['minimum_amount']}") < widget.total
        ? setState(() {
            minPriceValidated = true;
          })
        : setState(() {
            minPriceValidated = false;
          });
    print(minPriceValidated);

    double.tryParse("${coupon['maximum_amount']}") > widget.total || double.tryParse("${coupon['maximum_amount']}")==0
        ? setState(() {
            maxPriceValidate = true;
          })
        : setState(() {
            maxPriceValidate = false;
          });

    String date = coupon["date_expires_gmt"];
    if (date == null) {
      setState(() {
        expiryDateValidated = true;
      });
    } else {
      String dateWithT = date.substring(0, 4) +
          date.substring(5, 7) +
          date.substring(8, 13) +
          date.substring(14, 16) +
          date.substring(17, 19);
      DateTime dateTime = DateTime.parse(dateWithT);

      currentDate.difference(dateTime).inDays <= 0
          ? setState(() {
              expiryDateValidated = true;
            })
          : setState(() {
              expiryDateValidated = false;
            });
    }

    if(user != null && coupon['usage_limit_per_user'] == 1 && (coupon['used_by'].contains(user.email) || coupon['used_by'].contains(user.userId.toString()) )){
      setState(() {
              usageLimitValidate = false;
            });
    }else{
      setState(() {
              usageLimitValidate = true;
            });
    }

    if (cartList.isNotEmpty) {
      if (coupon['product_ids'].isEmpty) {
        flag_product = true;
      } else {
        for (var i = 0; i < cartList.length; i++) {
          int productId = cartList[i]['productId'];
          if (!coupon['product_ids'].contains(productId)) {
            flag_product = false;
            break;
          }
        }
      }

      flag_product
          ? setState(() {
              productsValidated = true;
            })
          : setState(() {
              productsValidated = false;
            });
    }
  }

  @override
  void initState() {
    super.initState();
    getCoupons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      
      appBar: AppBar(
        title: Text(
          "Apply Coupon",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(5.0),
        child: couponList == null && _loading == false
            ? Center(
                child: Text("Coupon_code results will display here"),
              )
            : _loading
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).accentColor),
                    ),
                  )
                : ListView(
                    children: <Widget>[
                      SizedBox(height: 5.0),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: !coupon_valid ? Text(
                        "*" + errorText,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ):Container(),
                      ),
                      
                      Padding(
                        padding: EdgeInsets.all(5),
                        child:Text("Available Coupons",
                      style: TextStyle(
                            color: Colors.black,
                            fontFamily: "openSans",
                            fontSize: 18
                      )) ,
                      ),
                      SizedBox(height: 5.0),
                      Divider(
                              color: Colors.black.withOpacity(0.5),
                            ),
                      Container(
                        padding: EdgeInsets.all(5.0),
                        child: ListView.separated(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: couponList == null ? 0 : couponList.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                              color: Colors.black.withOpacity(0.5),
                            );
                          },
                          itemBuilder: (BuildContext context, int index) {
                            if(couponList[index]['email_restrictions'].isEmpty){
                              return InkWell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                               decoration:
                                                                  BoxDecoration(
                                                                     color: Theme.of(context).accentColor.withOpacity(0.2),// 
                                                                border:
                                                                    Border.all(
                                                                  width: 1,
                                                                  
                                                                  color: Theme.of(context).accentColor,//      <--- border width here
                                                                ),
                                                              ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(5),
                                                  child: Text(
                                              "${couponList[index]['code']}",
                                              style: TextStyle(
                                                fontSize: 17.0,
                                                fontWeight: FontWeight.bold,
                                               
                                              ),
                                            ),
                                                )
                                            ),
                                            InkWell(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 0.0),
                                      child: Text(
                                        "APPLY",
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Theme.of(context).accentColor,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                    onTap: () async {
                                      print("${couponList[index]['code']}");
                                      controller.text =
                                          couponList[index]['code'];
                                      await validateCoupons(couponList[index]);
                                      if (!minPriceValidated) {
                                        setState(() {
                                          errorText =
                                              "Min price ₹${couponList[index]['minimum_amount']} is required. ";
                                              coupon_valid = false;
                                        }); 
                                      }else if(!maxPriceValidate){
                                        setState(() {
                                          errorText =
                                              "Max price ₹${couponList[index]['maximum_amount']} is required. ";
                                              coupon_valid = false;
                                        }); 
                                      } else if (!expiryDateValidated) {
                                        setState(() {
                                          errorText = "Code Expired.";
                                              coupon_valid = false;
                                        });
                                      } else if (!productsValidated) {
                                        setState(() {
                                          errorText =
                                              "Not valid on Selected products.";
                                              coupon_valid = false;
                                        });
                                      } else if(!usageLimitValidate){
                                        setState(() {
                                          errorText =
                                              "Applicable only once per user.";
                                              coupon_valid = false;
                                        });
                                      }else {
                                        
                                        coupon_valid = true;
                                        Navigator.pop(
                                            context, couponList[index]);
                                      }
                                      // if(validateCoupons(couponList[index])){
                                      //   _validate = false;
                                      //   print("object");

                                      // }
                                      // else{
                                      //   _validate = true;
                                      // }
                                    },
                                  )
                                            
                                          ],
                                        ),
                                        
                                        SizedBox(height: 10.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            InkWell(
                                              child: Text(
                                                "${couponList[index]['description']}",
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontFamily: "openSans",
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    flex: 3,
                                  ),
                                ],
                              ),
                            );
                         
                            }else{
                              if(user != null && couponList[index]['email_restrictions'].contains(user.email)){
                                 return InkWell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                               decoration:
                                                                  BoxDecoration(
                                                                     color: Theme.of(context).accentColor.withOpacity(0.2),// 
                                                                border:
                                                                    Border.all(
                                                                  width: 1,
                                                                  
                                                                  color: Theme.of(context).accentColor,//      <--- border width here
                                                                ),
                                                              ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(5),
                                                  child: Text(
                                              "${couponList[index]['code']}",
                                              style: TextStyle(
                                                fontSize: 17.0,
                                                fontWeight: FontWeight.bold,
                                               
                                              ),
                                            ),
                                                )
                                            ),
                                            InkWell(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 0.0),
                                      child: Text(
                                        "APPLY",
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Theme.of(context).accentColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    onTap: () async {
                                      print("${couponList[index]['code']}");
                                      controller.text =
                                          couponList[index]['code'];
                                      await validateCoupons(couponList[index]);
                                      if (!minPriceValidated) {
                                        setState(() {
                                          errorText =
                                              "Min price ₹${couponList[index]['minimum_amount']} is required ";
                                        });
                                      } else if (!expiryDateValidated) {
                                        setState(() {
                                          errorText = "Code Expired";
                                        });
                                      } else if (!productsValidated) {
                                        setState(() {
                                          errorText =
                                              "Not valid on Selected products";
                                        });
                                      } else {
                                        Navigator.pop(
                                            context, couponList[index]);
                                      }
                                      // if(validateCoupons(couponList[index])){
                                      //   _validate = false;
                                      //   print("object");

                                      // }
                                      // else{
                                      //   _validate = true;
                                      // }
                                    },
                                  )
                                            
                                          ],
                                        ),
                                        
                                        SizedBox(height: 10.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            InkWell(
                                              child: Text(
                                                "${couponList[index]['description']}",
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontFamily: "openSans",
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    flex: 3,
                                  ),
                                  
                                ],
                              ),
                            );
                         
                            
                              }else{
                                return null;
                              }
                            }
                            
                             },
                        ),
                      ),
                   
                      Divider(
                              color: Colors.black.withOpacity(0.5),
                            ),
                   
                    ],
                  ),
      ),
    );
  }
}
