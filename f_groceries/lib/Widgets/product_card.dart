import 'package:cached_network_image/cached_network_image.dart';
import 'package:f_groceries/database/cart/cart.dart';
import 'package:f_groceries/database/cart/db_helper.dart';
import 'package:f_groceries/database/wishlist/db_helper.dart';
import 'package:f_groceries/database/wishlist/wishlist.dart';
import 'package:f_groceries/screens/item_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:f_groceries/database/cart/cart.dart' as cart_db;

class Product_Card extends StatefulWidget {
  final int id;
  var img;
  var name;
  var price;
  var rating;
  var sales;
  var images;
  final String desc;
  final String link;
  final String regularPrice;
  final int rateAmount;
  final int cat;
  final String serve_quantity;
  final String status;
  final String stock_status;

  Product_Card({
    Key key,
    @required this.id,
    @required this.img,
    @required this.name,
    @required this.price,
    @required this.rating,
    this.sales,
    @required this.images,
    @required this.desc,
    @required this.link,
    @required this.regularPrice,
    @required this.rateAmount,
    @required this.cat,
    @required this.serve_quantity,
    @required this.status,
    @required this.stock_status,
  }) : super(key: key);

  @override
  _Product_CardState createState() => _Product_CardState();
}

class _Product_CardState extends State<Product_Card> {
  var unescape = new HtmlUnescape();
  bool inCart = false;
  var db = CartHelper();
  var wdb = WishlistHelper();
  int current_value = 0;

  int discount = 0;
  Icon bIcon = Icon(
    Icons.favorite,
    size: 25.0,
    color: Colors.grey,
  );


  @override
   void setState(fn) {
    if(mounted){
      super.setState(fn);
    }
  }
  void bookmark(
    int id,
    String imagesList,
    String name,
    String regularPrice,
    String price,
    String rating,
    String desc,
    String link,
    int rateAmount,
    int cat,
  ) async {
    //Check if a bookmark exists before attempt to save
    int check = await wdb.checkBookmark(id);
    if (check == 1) {
      int bookmark = await wdb.saveBookmark(Wishlist(
        widget.id,
        widget.name,
        widget.images[0]['src'],
        // widget.images,
        double.parse(widget.regularPrice),
        double.parse(widget.price),
        current_value,
        widget.rating,
        widget.desc,
        widget.link,
        widget.rateAmount,
        widget.cat,
        widget.serve_quantity
      ));

      print(bookmark);
      if (bookmark != 0) {
        checkBookmark();
      } else {
        // _showAlert(context, "Error", "Something went wrong");
        checkBookmark();
      }
    } else {
      Wishlist bookmark = await wdb.getBookmarkWithPostId(widget.id);
      print(bookmark.name);
      int del = await wdb.deleteBookmark(bookmark.id);
      print(del);
      if (del == 1) {
        checkBookmark();
      } else {
        checkBookmark();
      }
    }
  }

  checkBookmark() async {
    int check = await wdb.checkBookmark(widget.id);
    if (check == 1) {
      setState(() {
        bIcon = Icon(
          Icons.favorite_border,
          size: 25.0,
        );
      });
    } else {
      if (mounted) {
        setState(() {
          bIcon = Icon(
            Icons.favorite,
            size: 25.0,
            color: Colors.red,
          );
        });
      }
    }
  }

  getCurrentQuantityValue() async {
    if (inCart) {
      cart_db.Cart cart = await db.getProductWithProductId(widget.id);
      setState(() {
        current_value = cart.quantity;
      });
    } else {
      current_value = 0;
    }
  }

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
        widget.img,
        double.parse(widget.regularPrice),
        double.parse(widget.price),
        current_value,
        widget.rating,
        widget.desc,
        widget.link,
        widget.rateAmount,
        widget.cat,
        widget.serve_quantity
      ));

      print(cart);

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
      print(cart.name);
      int del = await db.deleteCart(cart.id);
      print(del);
      if (del == 1) {
        // checkCart();
        addCart();
      } else {
        checkCart();
      }

      return true;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkCart();
    checkBookmark();
    // getCurrentQuantityValue();
    discount =
        (((double.parse(widget.regularPrice) - double.parse(widget.price)) /
                    double.parse(widget.regularPrice)) *
                100)
            .round();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle =
        theme.textTheme.headline.copyWith(color: Colors.white);
    final TextStyle descriptionStyle = theme.textTheme.subhead;

    return Container(
        child: GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return Item_Details(
                      id: widget.id,
                      image: widget.images[0]["src"],
                      name: widget.name,
                      regularPrice: widget.regularPrice,
                      price: widget.price,
                      rating: widget.rating,
                      desc: unescape.convert(widget.desc),
                      link: widget.link,
                      rateAmount: widget.rateAmount,
                      cat: widget.cat,
                      serve_quantity: widget.serve_quantity,
                    );
                  },
                ),
              );

              checkCart();
            },
            child: new Container(
              // height: MediaQuery.of(context).size.height/3,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // photo and title
                    Stack(
                      children: <Widget>[
                        CachedNetworkImage(
                          height: MediaQuery.of(context).size.height / 4.1,
                          imageUrl: widget.img,
                          fit: BoxFit.fill,
                          alignment: Alignment.topCenter,
                          width: MediaQuery.of(context).size.width,
                        ),
                        Container(
                            alignment: Alignment.topLeft,
                            // padding: EdgeInsets.all(5.0),
                            child: IconButton(
                              icon: bIcon,
                              padding: EdgeInsets.all(0),
                              onPressed: () async {
                                bookmark(
                                    widget.id,
                                    widget.images[0]['src'],
                                    widget.name,
                                    widget.regularPrice,
                                    widget.price,
                                    widget.rating,
                                    widget.desc,
                                    widget.link,
                                    widget.rateAmount,
                                    widget.cat);
                              },
                              tooltip: "Wishlist",
                            )),
                        Align(
                          alignment: Alignment.topRight,
                          child: widget.price != widget.regularPrice
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
                        ),
                      ],
                    ),

                    // description and share/explore buttons
                    Divider(
                      color: Colors.black,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // three line description
                          Padding(
                            padding: const EdgeInsets.only(bottom: 0.0),
                            child: Text(
                              widget.name,
                              style: descriptionStyle.copyWith(
                                  color: Colors.black87),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 0.0),
                                child: Text(
                                  "₹" + widget.price,
                                  style: descriptionStyle.copyWith(
                                      color: Colors.black54),
                                ),
                              ),
                            ],
                          )

                          // Text(destination.description[1]),
                          // Text(destination.description[2]),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                        double.parse(widget.rating.toString()).toStringAsFixed(1) == "0.0"?Container():  Container(
                            // width: 45,
                            // height: 20,
                            // color: Colors.green,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  color: Colors.green,
                                  size: 17,
                                ),
                                Text(
                                    double.parse(widget.rating.toString())
                                        .toStringAsFixed(1),
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 17)),
                                
                              ],
                            ),
                          ),
                          widget.price != widget.regularPrice
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 7.0),
                                  child: Text(
                                    "₹${widget.regularPrice}",
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),

                   Container(
                            alignment: Alignment.center,
                            child:  inCart
                        ? Padding(padding: EdgeInsets.only(top:10), child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () async {
                                  if (current_value <= 1) {
                                    cart_db.Cart cart = await db
                                        .getProductWithProductId(
                                            widget.id);
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
                  ],
                ),
              ),
            )));
  }
}
