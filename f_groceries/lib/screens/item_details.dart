import 'package:cached_network_image/cached_network_image.dart';
import 'package:f_groceries/Objects/badge_cart.dart';
import 'package:f_groceries/screens/Cart_Screen.dart';
import 'package:f_groceries/screens/checkout_screen.dart';
import 'package:f_groceries/database/cart/db_helper.dart';
import 'package:f_groceries/database/cart/cart.dart' as cart_db;
import 'package:f_groceries/screens/review_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_html/flutter_html.dart';

class Item_Details extends StatefulWidget {
  final int id;
  final String image;
  final String name;
  final String regularPrice;
  final String price;
  final String rating;
  final String desc;
  final String link;
  final int rateAmount;
  final int cat;
  final String serve_quantity;

  Item_Details({
    Key key,
    @required this.id,
    @required this.image,
    @required this.name,
    @required this.regularPrice,
    @required this.price,
    @required this.rating,
    @required this.desc,
    @required this.link,
    @required this.rateAmount,
    @required this.cat,
    @required this.serve_quantity,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => item_details();
}

class item_details extends State<Item_Details> {
  String toolbarname = 'Fruiys & Vegetables';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List list = ['12', '11'];
  bool inCart = false;
  var db = CartHelper();
    int discount = 0;

  int current_value = 0;

  checkCart() async {
    int check = await db.checkCart(widget.id);
    if (check == 1) {
      setState(() {
        inCart = false;
      });
    } else {
      if (mounted) {
        setState(() {
          inCart = true;
          
        });
      }
    }

    getCurrentQuantityValue();
  }

  addCart() async {
    int check = await db.checkCart(widget.id);
    if (check == 1) {
      int cart = await db.saveCart(cart_db.Cart(
        widget.id,
        widget.name,
        widget.image,
        double.parse(widget.regularPrice),
        double.parse(widget.price),
        current_value,
        widget.rating,
        widget.desc,
        widget.link,
        widget.rateAmount,
        widget.cat,
        widget.serve_quantity,
      ));

      if (cart != 0) {
        //SnackBar() => _snackAction;

        checkCart();
        return true;
      } else {
        // _showAlert(context, "Error", "Something went wrong");
        checkCart();
        return false;
      }
    } else {
      cart_db.Cart cart = await db.getProductWithProductId(widget.id);
      int del = await db.deleteCart(cart.id);
      if (del == 1) {
        // checkCart();
        addCart();
      } else {
        checkCart();
      }

      return true;
    }
  }

  getCurrentQuantityValue() async {
  if (inCart) {
    cart_db.Cart cart = await db.getProductWithProductId(widget.id);
    setState(() {
      current_value = cart.quantity;
    });
  }else{
    current_value = 0;
  }
}
  
  @override
  void initState() {
    super.initState();
    checkCart();

    discount =
    (((double.parse(widget.regularPrice) - double.parse(widget.price)) /
                double.parse(widget.regularPrice)) *
            100)
        .round();
    
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle =
        theme.textTheme.headline.copyWith(color: Colors.white);
    final TextStyle descriptionStyle = theme.textTheme.subhead;
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
          title: Text(widget.name, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
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
                  child: Stack(
                    children: <Widget>[
                      new IconButton(
                      icon: IconBadge_cart(
                  icon: Icons.shopping_cart,
                  size: 25.0,
                ),
                        onPressed: () async {
                         await  Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart_screen()));
                         setState(() {
                           
                         });
                        }),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        body: Container(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
              Card(
                elevation: 4.0,
                child: Stack(
                  children: <Widget>[
                    Container(
                  color: Colors.white,

                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // photo and title
                        SizedBox(
                          height: MediaQuery.of(context).size.height/2.5,
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              new Container(

                                child: CachedNetworkImage(
                                  imageUrl:  widget.image,
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                ),
                              )
                            ],
                          ),
                        ),
                      ]),
                ),

            

                  ],
                ) 
              ),
              Container(
                  padding: const EdgeInsets.fromLTRB(10.0, 16.0, 16.0, 0.0),
                  child: DefaultTextStyle(
                      style: descriptionStyle,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // three line description
                          Container(
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                             Text(
                              widget.name,
                              style: descriptionStyle.copyWith(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                            ),
                          
                        Text(
                          widget.serve_quantity, style: TextStyle(
                          color: Colors.black54,fontSize: 15
                        ),),
                            ],
                          ) 
                        ),
                          
                          double.parse(widget.rating.toString()).toStringAsFixed(1) == "0.0"?Container(): GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ReviewScreen(id: widget.id,)));

                  },
                  child: Container(
                          // width: 50,
                          // height: 25,
                          // color: Colors.green,
                          child:Column(
                            children: <Widget>[
                              Row(
                          
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                          Icons.star,
                          color: Colors.green,
                          size: 18,
                        ),
                        
                          Text(double.parse(widget.rating.toString()).toStringAsFixed(1),style: TextStyle( color: Colors.green, fontSize: 19)),
                          
                        ],),
                        Text(
                          widget.rateAmount == 0?"": widget.rateAmount == 1? "${widget.rateAmount} review":"${widget.rateAmount} reviews", style: TextStyle(
                          color: Colors.black45,fontSize: 12
                        ),),
                            ],
                          ) 
                        ),
                        
                ) ,
                
                          
                       
                        ],
                      ))),
              Container(
                  margin: EdgeInsets.only(top:10.0),
                  child: Card(
                    color: Color(0xffe7e6ed),
                      child: Container(
                          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                          child: DefaultTextStyle(
                              style: descriptionStyle,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  // three line description
                                  
                                  
                                    Row(children: <Widget>[
                            Padding(
                            padding:  EdgeInsets.only(bottom: 0.0),
                            child: Text(
                              "₹"+ widget.price,
                              style: descriptionStyle.copyWith(
                                  color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),

                          widget.price != widget.regularPrice
                          ? Padding(
                                        padding:const EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          "₹${widget.regularPrice}",
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.grey,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                      )
                                    : Container(),
                          SizedBox( width: 5,),
                          widget.price != widget.regularPrice
                              ? Container(
                                  width: 60,
                                  height: 25,
                                  color: Colors.green,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(discount.toString() + "% " + "OFF",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12)),
                                    ],
                                  ),
                                )
                              : Container(),
                          ],),
                                  
                                  
                                  // Row(
                                  //   // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  //   children: <Widget>[
                                  //     GestureDetector(
                                  //       onTap: () async {
                                  //           if (current_value <= 1) {
                                  //           cart_db.Cart cart = await db
                                  //               .getProductWithProductId(
                                  //                   widget.id);
                                  //           int del =
                                  //               await db.deleteCart(cart.id);
                                  //           if (del == 1) {
                                  //             checkCart();
                                  //           } else {
                                  //             checkCart();
                                  //           }
                                  //         } else {
                                  //           setState(() {
                                  //             current_value = current_value - 1;
                                  //             addCart();
                                  //           });
                                  //         }
                                  //       },     
                                  //       child:  Container(
                                  //         // padding: const EdgeInsets.all(3.0),
                                          
                                  //         height: MediaQuery.of(context).size.height/25,
                                  //         width: MediaQuery.of(context).size.width/10,
                                  //         alignment: Alignment.center,
                                  //         decoration: BoxDecoration(
                                  //           color: Theme.of(context).accentColor.withOpacity(0.3),
                                  //               borderRadius: BorderRadius.all(
                                  //             Radius.circular(10.0) //                 <--- border radius here
                                  //         ),
                                  //         ),
                                  //         child: Center(
                                  //           child:
                                  //     Icon(Icons.remove, color: Theme.of(context).accentColor,),
                                  //       ),
                                  //     ),                                   
                                  //     ),
                                  //     Container(
                                  //       margin: EdgeInsets.only(left: 15.0),
                                  //     ),
                                  //     Text(
                                  //       item.toString(),
                                  //       style: descriptionStyle.copyWith(
                                  //           fontSize: 20.0,
                                  //           color: Colors.black87),
                                  //     ),
                                  //     Container(
                                  //       margin: EdgeInsets.only(right: 15.0),
                                  //     ),

                                  //     GestureDetector(
                                  //       onTap: () {
                                  //          setState(() {
                                  //           current_value = current_value + 1;
                                  //           addCart();
                                  //         });
                                  //       },     
                                  //       child:  Container(
                                  //         // padding: const EdgeInsets.all(3.0),
                                          
                                  //         height: MediaQuery.of(context).size.height/25,
                                  //         width: MediaQuery.of(context).size.width/10,
                                  //         alignment: Alignment.center,
                                  //         decoration: BoxDecoration(
                                  //           color: Theme.of(context).accentColor.withOpacity(0.3),
                                  //               borderRadius: BorderRadius.all(
                                  //             Radius.circular(10.0) //                 <--- border radius here
                                  //         ),
                                  //         ),
                                  //         child: Center(
                                  //           child:
                                  //     Icon(Icons.add, color: Theme.of(context).accentColor,),
                                  //       ),
                                  //     ),                                   
                                  //     ),
                                     
                                  //   ],
                                  // ),

                                  Container(
                            alignment: Alignment.center,
                            child:  inCart
                        ? Padding(padding: EdgeInsets.only(top:10, bottom: 10), child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () async {
                                  if (current_value <= 1) {
                                    cart_db.Cart cart = await db
                                        .getProductWithProductId(widget.id);

                                            print(cart.id);
                                    int del =
                                        await db.deleteCart(cart.id);
                                    if (del == 1) {
                                      checkCart();
                                    } else {
                                      checkCart();
                                    }
                                  } else {
                                    setState(() {
                                      current_value = current_value - 1;
                                      addCart();
                                    });
                                  }
                                },
                                child: Container(
                                  // padding: const EdgeInsets.all(3.0),

                                  height:
                                      MediaQuery.of(context).size.height / 25,
                                  width: MediaQuery.of(context).size.width / 10,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.3),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            10.0) //                 <--- border radius here
                                        ),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.remove,
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 15.0),
                              ),
                              Text(
                                current_value.toString(),
                                style: descriptionStyle.copyWith(
                                    fontSize: 20.0, color: Colors.black87),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 15.0),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    current_value = current_value + 1;
                                    addCart();
                                  });
                                },
                                child: Container(
                                  // padding: const EdgeInsets.all(3.0),

                                  height:
                                      MediaQuery.of(context).size.height / 25,
                                  width: MediaQuery.of(context).size.width / 10,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.3),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            10.0) //                 <--- border radius here
                                        ),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.add,
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ) ,)
                        :  FlatButton(
                              color: Theme.of(context).accentColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              onPressed: () {
                                setState(() {
                                  current_value++;
                                });
                                addCart();
                                checkCart();
                              },
                              child: Text( 'Add',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
  //                                 Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: Container(
  //                       alignment: Alignment.center,
  //                      child: FlatButton(
  //           color: Theme.of(context).accentColor,
  //           shape: RoundedRectangleBorder(
  //   borderRadius: BorderRadius.circular(15.0),
    
  // ),
  //           onPressed: () async{
  //                         if (!inCart) {
  //                                             setState(() {
  //                                               if(current_value == 0){
  //                                                  current_value = 1;
  //                                               }
                                               
  //                                             });
  //                                             if (await addCart()) {
  //                                               print('added to cart');
  //                                             }
  //                                           }           
  //           },
  //           child: Text(inCart? "Added to Cart": "Add", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
  //         ),
                      
  //                     ),
  //                   ),
                                 
                                ],
                              ))))),
              Container(
                  padding: const EdgeInsets.fromLTRB(10.0, 16.0, 16.0, 0.0),
                  child: DefaultTextStyle(
                      style: descriptionStyle,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // three line description
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              'Description',
                              style: descriptionStyle.copyWith(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                            ),
                          ),
                        ],
                      ))),
              Container(
                  child:                                      Html(
                                        data: "${widget.desc}",
                                      ),
                                      
                                      
                                      
                      //                  Text(widget.desc,
                      // maxLines: 10,
                      // style: TextStyle(fontSize: 13.0, color: Colors.black38))
                      
                      ),
            ]))));
  }
}
