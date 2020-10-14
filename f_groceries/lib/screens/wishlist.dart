
import 'package:cached_network_image/cached_network_image.dart';
import 'package:f_groceries/Objects/badge_cart.dart';
import 'package:f_groceries/Utils/constants.dart';
import 'package:f_groceries/Utils/woocommerce_api.dart';
import 'package:f_groceries/database/cart/cart.dart' as cart_db;
import 'package:f_groceries/database/cart/db_helper.dart';
import 'package:f_groceries/database/wishlist/db_helper.dart';
import 'package:f_groceries/database/wishlist/wishlist.dart';
import 'package:f_groceries/screens/Cart_Screen.dart';
import 'package:f_groceries/screens/item_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({Key key}) : super(key: key);
  @override
  _WishListPageState createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  var db_wishlist = WishlistHelper();
  var db_cart = CartHelper();
  List bookmarkList;
  bool _loading;
  bool inCart = false;
  List incart_list;
  var unescape = new HtmlUnescape();

  WooCommerceAPI wc_api = WooCommerceAPI("${Constants.baseURL}",
      "${Constants.consumerKey}", "${Constants.consumerSecret}");

deleteItem(int id, int pos) async {
    int del = await db_wishlist.deleteBookmark(id);
    setState(() {
      bookmarkList.removeAt(pos);
    });
    getBookmarks();
  }

  //Get saved bookmarks from database
getBookmarks() async {
    incart_list = [];
    setState(() {
      _loading = true;
    });
    if (mounted) {
      List b = await db_wishlist.getBookmarks();
      if (mounted) {
        setState(() {
          if (b.length == 0) {
            _loading = false;
          } else {
            bookmarkList = b;
            _loading = false;
            for (var i = 0; i < bookmarkList.length; i++) {
              incart_list.add(false);
              checkCart(bookmarkList[i]['id'], i);
            }
          }
        });
      }
    }
  }

  addCart(Wishlist wishlist, int index) async {
    int check = await db_cart.checkCart(wishlist.id);
    if (check == 1) {
      int cart = await db_cart.saveCart(cart_db.Cart(
          wishlist.id,
          wishlist.name,
          wishlist.img,
          wishlist.regularPrice,
          wishlist.price,
          1,
          wishlist.rating,
          wishlist.desc,
          wishlist.link,
          wishlist.rateAmount,
          wishlist.cat,
          wishlist.serve_quantity
          ));

      print(cart);

      if (cart != 0) {
        //SnackBar() => _snackAction;

        checkCart(wishlist.id, index);
        return true;
      } else {
        _showAlert(context, "Error", "Something went wrong");
        checkCart(wishlist.id, index);
        return false;
      }
    } else {
      cart_db.Cart cart = await db_cart.getProductWithProductId(wishlist.id);
      print(cart.name);
      int del = await db_cart.deleteCart(cart.id);
      print(del);
      if (del == 1) {
        checkCart(wishlist.id, index);
      } else {
        checkCart(wishlist.id, index);
      }
      return false;
    }
  }

  checkCart(int id, int index) async {
    int check = await db_cart.checkCart(id);
    if (check == 1) {
      setState(() {
        incart_list[index] = false;
      });
    } else {
      if (mounted) {
        setState(() {
          incart_list[index] = true;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // elevation: 0.0,
        leading: IconButton(
        icon: Icon(Icons.arrow_back,color: Colors.black,),
        alignment: Alignment.centerLeft,
        tooltip: 'Back',
        onPressed: () {
          Navigator.pop(context);
        },
      ),
        
        backgroundColor: Colors.white,
        title: Text("Wishlist", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),

              actions: <Widget>[
          IconButton(
                      icon: IconBadge_cart(
                  icon: Icons.shopping_cart,
                  size: 25.0,
                ),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart_screen()));
                        }),
         
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: _loading
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).accentColor),
                ),
              )
            : Container(
                padding: EdgeInsets.all(5.0),
                child: bookmarkList == null
                    ? Center(
                        child: Text("No items in Wishlist!"),
                      )
                    : Container(
                        child: ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount:
                              bookmarkList == null ? 0 : bookmarkList.length,
                          itemBuilder: (BuildContext context, int index) {
                            Wishlist wishlist =
                                Wishlist.fromMap(bookmarkList[index]);
                            int _currentValue = wishlist.quantity;
                            return InkWell(
                              onTap: () {
                                          Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return Item_Details(
                id: wishlist.id,
                image: wishlist.img,
                name: wishlist.name,
                regularPrice: wishlist.regularPrice.toString(),
                price: wishlist.price.toString(),
                rating: wishlist.rating,
                desc: unescape.convert(wishlist.desc),
                link: wishlist.link,
                rateAmount: wishlist.rateAmount,
                cat: wishlist.cat,
                serve_quantity: wishlist.serve_quantity,
              );
            },
          ),
        );
                              },
                              child: Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: Material(
                                      elevation: 3.0,
                                      child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              20.0,
                                          height: 80.0,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              SizedBox(width: 2.0),
                                              Container(
                                                child: CachedNetworkImage(
                                                  height: 65.0,
                                                  width: 65.0,
                                                  imageUrl: "${wishlist.img}",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              SizedBox(width: 4.0),
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    10.0, 5.0, 0.0, 0.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: <Widget>[
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  2.4,
                                                              color: Colors
                                                                  .transparent,
                                                              child:
                                                                 Text(
                                                                wishlist.name,
                                                                maxLines: 1,
                                                                style: new TextStyle(
                                                                    color: Colors.black,
                                                                    fontSize:
                                                                        15.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        "openSans"),
                                                              ),
                                                            ),
                                                            
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width: 15,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    if (!incart_list[
                                                                        index]) {
                                                                      if (await addCart(
                                                                          wishlist,
                                                                          index)) {
                                                                        print(
                                                                            'object');

                                                                        // Scaffold.of(context)
                                                                        //     .showSnackBar(
                                                                        //   SnackBar(
                                                                        //     duration:
                                                                        //         const Duration(seconds: 4),
                                                                        //     behavior:
                                                                        //         SnackBarBehavior.floating,
                                                                        //     content:
                                                                        //         Row(
                                                                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        //       children: <Widget>[
                                                                        //         Text(
                                                                        //           "Item added to Cart !",
                                                                        //           style: TextStyle(
                                                                        //             color: Colors.white,
                                                                        //             fontSize: 15,
                                                                        //           ),
                                                                        //           textAlign: TextAlign.center,
                                                                        //         ),
                                                                        //         InkWell(
                                                                        //           child: Row(
                                                                        //             mainAxisAlignment: MainAxisAlignment.start,
                                                                        //             children: <Widget>[
                                                                        //               Text(
                                                                        //                 "GO TO CART",
                                                                        //                 style: new TextStyle(color: Theme.of(context).accentColor, fontWeight: FontWeight.bold, fontSize: 16.0),
                                                                        //               ),
                                                                        //             ],
                                                                        //           ),
                                                                        //           onTap: () {
                                                                        //             Navigator.of(context).push(
                                                                        //               MaterialPageRoute(
                                                                        //                 builder: (BuildContext context) {
                                                                        //                   return Cart_screen();
                                                                        //                 },
                                                                        //               ),
                                                                        //             );
                                                                        //           },
                                                                        //         )
                                                                        //       ],
                                                                        //     ),
                                                                        //     backgroundColor:
                                                                        //         const Color(0xff282828),
                                                                        //   ),
                                                                        // );
                                                                      }
                                                                    }
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    color: incart_list[
                                                                            index]
                                                                        ? Colors
                                                                            .green
                                                                        : Colors.grey,
                                                                    width: 40,
                                                                    height: 40,
                                                                    child: Icon(
                                                                        Icons
                                                                            .add_shopping_cart),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    await deleteItem(
                                                                        wishlist
                                                                            .id,
                                                                        index);

                                                                    Scaffold.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                      SnackBar(
                                                                        duration:
                                                                            const Duration(seconds: 4),
                                                                        behavior:
                                                                            SnackBarBehavior.floating,
                                                                        content:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: <
                                                                              Widget>[
                                                                            Text(
                                                                              "Item deleted from Wishlist !",
                                                                              style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 15,
                                                                              ),
                                                                              textAlign: TextAlign.center,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        backgroundColor:
                                                                            const Color(0xff282828),
                                                                      ),
                                                                    );
                                                                  },
                                                                  child: Container(
                                                                      color: Colors
                                                                          .red,
                                                                      width: 40,
                                                                      height:
                                                                          40,
                                                                      child: Icon(
                                                                          Icons
                                                                              .delete)),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )))),
                            );
                          },
//              physics: NeverScrollableScrollPhysics(),
                        ),
                      ),
              ),
      ),
    );
  }

  void _showAlert(BuildContext context, String title, String message) {
    var alert = new AlertDialog(
      title: Text("$title"),
      content: Text("$message"),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("OK"),
        )
      ],
    );

    showDialog(context: context, builder: (context) => alert);
  }
}
