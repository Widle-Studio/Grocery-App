import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_groceries/database/cart/db_helper.dart';
import 'package:f_groceries/screens/checkout_screen.dart';
import 'package:f_groceries/screens/item_details.dart';
import 'package:flutter/material.dart';

import 'package:f_groceries/database/cart/cart.dart' as cart_db;

enum DialogDemoAction {
  cancel,
  discard,
  disagree,
  agree,
}
class Cart_screen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Cart();
}

class Item {
  final String itemImage;
  final String itemName;
  final String itemQun;
  final String itemPrice;

  Item({this.itemImage, this.itemName, this.itemQun, this.itemPrice});
}

class Cart extends State<Cart_screen> {

  String toolbarname = 'My Cart';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final databaseReference = Firestore.instance;

  IconData _backIcon() {
    switch (Theme
        .of(context)
        .platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return Icons.arrow_back;
      case TargetPlatform.iOS:
        return Icons.arrow_back_ios;
    }
    assert(false);
    return null;
  }

  String pincode;
  var db = CartHelper();
  bool _loading = false;
  List cartList;
  double totalPrice = 0.00;

  getItems() async {
  List res = await db.getCarts();
  setState(() {
    if (res.length == 0) {
      _loading = false;
      totalPrice = 0.00;
    } else {
      cartList = res;
      totalPrice = 0.00;
      for (var i = 0; i < cartList.length; i++) {
        totalPrice =
            totalPrice + cartList[i]['price'] * cartList[i]['quantity'];
      }
      _loading = false;
      setState(() {
        totalPrice = totalPrice;
      });
    }
  });
}

  deleteItem(int id, int pos) async {
    int del = await db.deleteCart(id);
    setState(() {
      cartList.removeAt(pos);
    });
    getItems();
  }




  @override
  void initState() {
    super.initState();
    getItems();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    IconData _add_icon() {
      switch (Theme.of(context).platform) {
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
          return Icons.add_circle;
        case TargetPlatform.iOS:
          return Icons.add_circle;
      }
      assert(false);
      return null;
    }
    IconData _sub_icon() {
      switch (Theme.of(context).platform) {
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
          return Icons.remove_circle;
        case TargetPlatform.iOS:
          return Icons.remove_circle;
      }
      assert(false);
      return null;
    }
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;

    double dd = width * 0.77;
    double hh = height - 215.0;
    final ThemeData theme = Theme.of(context);
    final TextStyle dialogTextStyle = theme.textTheme.subhead.copyWith(
        color: theme.textTheme.caption.color);

    return new Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(_backIcon(),color: Colors.black,),
          alignment: Alignment.centerLeft,
          tooltip: 'Back',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(toolbarname,style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
        
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Container(
          //     margin: EdgeInsets.only(left: 0.0, right: 0.0, bottom: 10.0),
          //     child: Card(
          //         child: Container(
          //             padding:
          //             const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          //             child: GestureDetector(
          //                 child: Row(
          //                   mainAxisSize: MainAxisSize.max,
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   children: <Widget>[
          //                     // three line description
          //                     Row(
          //                       children: <Widget>[
          //                         Text(
          //                           'Pincode : ',
          //                           style: TextStyle(
          //                             fontSize: 17.0,
          //                             fontStyle: FontStyle.normal,
          //                             color: Colors.black54,
          //                           ),
          //                         ),
          //                         Container(
          //                           margin: EdgeInsets.only(right: 2.0),
          //                         ),
          //                         GestureDetector(
          //                           child: Text(
          //                             '383310',
          //                             style: TextStyle(
          //                                 fontSize: 18.0,
          //                                 fontWeight: FontWeight.bold,
          //                                 decoration: TextDecoration.underline,
          //                                 color: Colors.black),
          //                           ),
          //                           onTap: () {
          //                             showDemoDialog<DialogDemoAction>(
          //                                 context: context,
          //                                 child: AlertDialog(
          //                                     title: const Text(
          //                                         'Location/Area Pincode'),
          //                                     content:SizedBox(
          //                                       height: 24.0,
          //                                     child: TextFormField(
          //                                         keyboardType: TextInputType.emailAddress, // Use email input type for emails.
          //                                         decoration: new InputDecoration(
          //                                             hintText: '******',
          //                                             labelText: 'Pincode'
          //                                         ),
          //                                       //  validator: this._validateEmail,
          //                                         onSaved: (String value) {
          //                                           this.pincode = value;
          //                                         }
          //                                     ),),

          //                                     actions: <Widget>[
          //                                       FlatButton(
          //                                           child: const Text(
          //                                               'CANCEL'),
          //                                           onPressed: () {
          //                                             Navigator.pop(context,
          //                                                 DialogDemoAction
          //                                                     .disagree);
          //                                           }
          //                                       ),
          //                                       FlatButton(
          //                                           child: const Text('SAVE'),
          //                                           onPressed: () {
          //                                             Navigator.pop(context,
          //                                                 DialogDemoAction
          //                                                     .agree);
          //                                           }
          //                                       )
          //                                     ]
          //                                 )
          //                             );
          //                           },
          //                         )

          //                       ],
          //                     ),
          //                   ],
          //                 ))))),
          cartList != null?
            cartList.length !=0?
          Container(
              margin: EdgeInsets.only(
                  left: 12.0, top: 5.0, right: 12.0, bottom: 10.0),
              height: hh,
              child: ListView.builder(
                  itemCount: cartList == null?0:cartList.length,
                  itemBuilder: (BuildContext cont, int index) {
                    cart_db.Cart cart = cart_db.Cart.fromMap(cartList[index]);
                    int _currentValue = cart.quantity;
                    return SafeArea(
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: <Widget>[
                              Container(

                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    children: <Widget>[
                                      Container(

                                        height: 120.0,
                                        width: dd,
                                        child: Card(
                                               color: Color(0xffe7e6ed),
                                          child: Row(
                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Card(
                                           
                                                child: SizedBox(
                                                height: 110.0,
                                                width: 110.0,
                                                child: CachedNetworkImage(
                                              imageUrl: "${cart.img}",
                                              fit: BoxFit.cover,
                                              width: MediaQuery.of(context).size.width,
                                            ),),
                                              ),

                                              SizedBox(
                                                width: 10,                                                
                                              ),
                                            
                                              SizedBox(
                                                  height: 110.0,
                                                  child: Container(
                                                    alignment: Alignment
                                                        .topLeft,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        _verticalD(),
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                          children: <Widget>[
                                                            Text(
                                                              cart.name,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize: 18.0,
                                                                  color:
                                                                  Colors.black),
                                                            ),
                                                          ],
                                                        ),
                                                        _verticalD(),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          // mainAxisSize: MainAxisSize.max,
                                                          // crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: <Widget>[
                                                            Text(
                                                              "₹${(cart.price).toInt()}",
                                                              style: TextStyle(
                                                                  fontSize: 17.0,
                                                                  color:
                                                                  Colors
                                                                      .black54),
                                                            ),
                                                          ],
                                                        ),
                                                         Container(
        margin: EdgeInsets.only(left: 0.0, right: 0.0, top: 05.0, bottom: 0),
      ),

                                                        Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () async {
                                           {
                                                                        
                                                                        if (_currentValue !=
                                                                            1) {
                                                                          setState(
                                                                              () {
                                                                            _currentValue--;
                                                                          });
                                                                        } else{
                                                                          deleteItem(
                    cart.id,
                    index);
                                                                        }
                                                                        cart_db.Cart
                                                                            cartUpdate =
                                                                            cart_db.Cart.fromMap({
                                                                          "id":
                                                                              cart.id,
                                                                          "productId":
                                                                              cart.productId,
                                                                          "name":
                                                                              cart.name,
                                                                          "img":
                                                                              cart.img,
                                                                          "regularPrice":
                                                                              cart.regularPrice,
                                                                          "price":
                                                                              cart.price,
                                                                          "quantity":
                                                                              _currentValue,
                                                                          "rating":
                                                                              cart.rating,
                                                                          "desc":
                                                                              cart.desc,
                                                                          "link":
                                                                              cart.link,
                                                                          "rateAmount":
                                                                              cart.rateAmount,
                                                                          "cat":
                                                                              cart.cat,
                                                                         
                                                                        });

                                                                        int d = await db.updateWallet(cartUpdate);

                                                                        getItems();
                                                                      }
                                        },     
                                        child:  Container(
                                          // padding: const EdgeInsets.all(3.0),
                                          
                                          height: MediaQuery.of(context).size.height/25,
                                          width: MediaQuery.of(context).size.width/10,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).accentColor.withOpacity(0.3),
                                                borderRadius: BorderRadius.all(
                                              Radius.circular(10.0) //                 <--- border radius here
                                          ),
                                          ),
                                          child: Center(
                                            child:
                                      Icon(Icons.remove, color: Theme.of(context).accentColor,),
                                        ),
                                      ),                                   
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 15.0),
                                      ),
                                      Text(
                                        
                                        _currentValue.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                        
                                        // style: descriptionStyle.copyWith(
                                        //     fontSize: 20.0,
                                        //     color: Colors.black87),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 15.0),
                                      ),

                                      GestureDetector(
                                        onTap: () async {
                                            setState(
                                                                            () {
                                                                          _currentValue++;
                                                                        });

                                                                        cart_db.Cart
                                                                            cartUpdate =
                                                                            cart_db.Cart.fromMap({
                                                                          "id":
                                                                              cart.id,
                                                                          "productId":
                                                                              cart.productId,
                                                                          "name":
                                                                              cart.name,
                                                                          "img":
                                                                              cart.img,
                                                                          "regularPrice":
                                                                              cart.regularPrice,
                                                                          "price":
                                                                              cart.price,
                                                                          "quantity":
                                                                              _currentValue,
                                                                          "rating":
                                                                              cart.rating,
                                                                          "desc":
                                                                              cart.desc,
                                                                          "link":
                                                                              cart.link,
                                                                          "rateAmount":
                                                                              cart.rateAmount,
                                                                          "cat":
                                                                              cart.cat,
                                                                          
                                                                        });

                                                                        int d = await db.updateWallet(cartUpdate);
                                                                        getItems();
                                                                        
                                                                        
                                        },     
                                        child:  Container(
                                          // padding: const EdgeInsets.all(3.0),
                                          
                                          height: MediaQuery.of(context).size.height/25,
                                          width: MediaQuery.of(context).size.width/10,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).accentColor.withOpacity(0.3),
                                                borderRadius: BorderRadius.all(
                                              Radius.circular(10.0) //                 <--- border radius here
                                          ),
                                          ),
                                          child: Center(
                                            child:
                                      Icon(Icons.add, color: Theme.of(context).accentColor,),
                                        ),
                                      ),                                   
                                      ),
                                     
                                    ],
                                  ),
                                                      
                                                      ],
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),


                                      SizedBox(
                                        width: 5,
                                      ),
                                      SizedBox(
                                          height: 110.0,
                                          width: 50.0,
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "₹${(cart.price).toInt() * _currentValue}",
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          )

                                      ),

                                    ],
                                  )),

                            ],
                          ),
                        ));
                  })): Center(
                    child: Text("Cart is Empty!"),
                  ): Center(child: Text("Cart is Empty!"),),
          ],
      ),

bottomNavigationBar: Builder(
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            child:  Container(
              alignment: Alignment.bottomLeft,
              height: 60.0,
              child: Card(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // IconButton(icon: Icon(Icons.info), onPressed: null),
                    Row(
                      children: <Widget>[
                        SizedBox(
                        width: 20,
                    ),
                    Text(
                      'Total :',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                        width: 10,
                    ),
                    Text(
                      "₹" + (totalPrice.toInt()).toString(),
                      style: TextStyle(fontSize: 17.0, color: Colors.black54),
                    ),
                      ],
                    ),
                   
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                       child: FlatButton(
            color: Theme.of(context).accentColor,
            shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15.0),
    
  ),
            onPressed: (){
                         if(cartList == null){
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text('Please select at least one item')
                            ));
                                }
                                else if(cartList.length == 0){
                                   _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text('Please select at least one item')
                            ));
                                }

                                else{
                                   Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Checkout()));
                                }            
            },
            child: Text('CHECKOUT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          ),
                      
                      ),
                    ),
                  ],
                ),
              )),
         );
        },
      ),
    );

  }

  verticalDivider() =>
      Container(
        padding: EdgeInsets.all(2.0),
      );

  _verticalD() =>
      Container(
        margin: EdgeInsets.only(left: 3.0, right: 0.0, top: 07.0, bottom: 0.0),
      );

  void showDemoDialog<T>({ BuildContext context, Widget child }) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    )
        .then<void>((T value) { // The value passed to Navigator.pop() or null.
      if (value != null) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('You selected: $value')
        ));
      }
    });
  }
}