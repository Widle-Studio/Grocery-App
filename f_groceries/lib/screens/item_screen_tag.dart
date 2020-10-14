import 'dart:convert';

import 'package:f_groceries/Objects/badge_cart.dart';
import 'package:f_groceries/Objects/product.dart';
import 'package:f_groceries/Utils/constants.dart';
import 'package:f_groceries/Utils/woocommerce_api.dart';
import 'package:f_groceries/Widgets/product_card.dart';
import 'package:f_groceries/screens/Cart_Screen.dart';
import 'package:f_groceries/screens/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TagProducts extends StatefulWidget {
  final int id;
  final String img;
  final String name;
  final String products;

  TagProducts({
    Key key,
    @required this.id,
    @required this.img,
    @required this.name,
    @required this.products,
  }) : super(key: key);
  @override
  _TagProductsState createState() => _TagProductsState();
}

class _TagProductsState extends State<TagProducts> {
  List productsList;
  bool productsLoadig;
  List original_list;
  bool filters_showing = false;
  List sort_list = [false,false,false,false];
  List discount_list = [false,false,false,false,false];
  // var unescape = new HtmlUnescape();

  WooCommerceAPI wc_api = WooCommerceAPI("${Constants.baseURL}",
      "${Constants.consumerKey}", "${Constants.consumerSecret}");

  getProducts() async {
    setState(() {
      productsLoadig = true;
    });
    var res = await wc_api
        .getAsync("products?status=publish&tag=${widget.id}&per_page=100");
    var decodedJson = jsonDecode(res.body);
    print("Feat GETRAW ${res.body}");
    print("Feat GET$decodedJson");

    print(res.body);
    if (res.statusCode == 200 && decodedJson != null) {
      if (mounted) {
        setState(() {
          original_list = decodedJson;
          productsList = original_list;
          productsLoadig = false;
        });
      }
    } else {
      print("Something went wrong");
      if (mounted) {
        setState(() {
          productsLoadig = false;
        });
      }
    }
  }

sort_products(){
  if(discount_list.contains(true)){
      int index = discount_list.indexOf(true);
      int percentage_value = (index+1)*10;
      productsList = [];
   for(int i=0;i<original_list.length;i++){
     if((double.parse(original_list[i]["regular_price"])-double.parse(original_list[i]["price"]))/double.parse(original_list[i]["regular_price"]) >= percentage_value/100){
       productsList.add(original_list[i]);
     }
   }
    }else{
      productsList = original_list;
    }

    if(sort_list[0]){
       productsList.sort((a, b) => a["price"].compareTo(b["price"]));
      
    }else if(sort_list[1]){
      productsList.sort((a, b) => a["price"].compareTo(b["price"]));
      productsList = productsList.reversed.toList();
    
    }else if(sort_list[2]){
      productsList.sort((a, b) => a["total_sales"].compareTo(b["total_sales"]));
      productsList = productsList.reversed.toList();
     

    }else if(sort_list[3]){
      productsList.sort((a, b) => a["date_created"].compareTo(b["date_created"]));
      productsList = productsList.reversed.toList();
      
    }

    setState(() {
      productsList = productsList;
    });
  }
  
  
  @override
  void initState() {
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Constants.bG,
      appBar: AppBar(
        backgroundColor: Constants.bG,
        leading: IconButton(
        icon: Icon(Icons.arrow_back,color: Colors.black,),
        alignment: Alignment.centerLeft,
        tooltip: 'Back',
        onPressed: () {
          Navigator.pop(context);
        },
      ),

      actions: <Widget>[
          IconButton(
            tooltip: 'Search',
            icon: const Icon(Icons.search,color: Colors.black,),
            onPressed: () async {
              await  Navigator.push(context, MaterialPageRoute(builder: (context)=>Search(id: widget.id,name: widget.name,)));
              setState(() {
              });

            },
          ),

          IconButton(
            tooltip: 'filter',
            icon: const Icon(Icons.filter_list,color: Colors.black,),
            onPressed: () async {
               setState(() {
                 filters_showing = true;
               });

            },
          ),

          IconButton(
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
        title: Text(
          widget.name,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body:Stack(
        children: <Widget>[
          productsLoadig
              ? 
              Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).accentColor),
                  ),
                )

              : productsList.length == 0?
              Center(
               child: Text("Nothing to show!"),
              )  :ListView(
        children: <Widget>[
          Divider(),
          
              // Container(
              //   child: Text("something"),
              // )
              Container(
                  padding: EdgeInsets.all(5.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: MediaQuery.of(context).size.width /
                           (MediaQuery.of(context).size.height/1.15),
                    ),
                    itemCount: productsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      Product product = Product.fromJson(productsList[index]);
                      print(product.id);
                      return Product_Card(
                        key: UniqueKey(),
                        id: product.id,
                        img:
                            product.images == null ? "" : product.images[0].src,
                        rating: product.averageRating == null
                            ? "0.0"
                            : product.averageRating,
                        sales: product.totalSales == 0
                            ? "No Sales yet"
                            : "${product.totalSales} Sales",
                        images: productsList[index]['images'],
                        name: product.name,
                        regularPrice: product.regularPrice,
                        price: product.price,
                        desc: product.description,
                        link: product.permalink,
                        rateAmount: product.ratingCount,
                        status: product.status,
                        cat: product.categories == null
                            ? 1
                            : product.categories[0].id,
                        serve_quantity: product.attributes != null &&
                                    product.attributes.length >= 1
                                ? product.attributes[0].options[0].toString()
                                : "",
                        stock_status: product.stockStatus,
                      );

                    
                    },
                  ),
                ),
        ],
      ),
       
       
          filters_showing? Container(
            color: Theme.of(context).backgroundColor.withOpacity(0.95),
            child:ListView(
              // shrinkWrap: true,
              children: <Widget>[
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[

                    IconButton(
          icon: const Icon(Icons.clear, color: Colors.black,),
          onPressed: () {
            
          //  controller.clear();
          setState(() {
            filters_showing = false;
          });
          },
        ),
                    Container(
                  alignment: Alignment.center,
                  child: OutlineButton(
                      borderSide: BorderSide(color: Colors.amber.shade500),
                      child: Text("CLEAR"),
                      color: Colors.white,
                      textColor: Colors.amber.shade500,
                      onPressed: () {
                        setState(() {
                          sort_list = [false,false,false,false];
                          discount_list = [false,false,false,false,false];
                          productsList = original_list;
                        });
                      },
                      shape: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      )),
                ),

                Container(
                  alignment: Alignment.center,
                  child: OutlineButton(
                      borderSide: BorderSide(color: Colors.amber.shade500),
                      child: Text("APPLY"),
                      color: Colors.white,
                      textColor: Colors.amber.shade500,
                      onPressed: () {
                        sort_products();
                        setState(() {
                          print("here");
                          filters_showing = false;
                        });
                      },
                      shape: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      )),
                ),
                  ],
                ),
              
                Divider(),
                Container(
            alignment: Alignment.topLeft,
            margin:
                EdgeInsets.only(left: 12.0, top: 5.0, right: 0.0, bottom: 5.0),
            child: new Text(
              'Sort',
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
          ),
              
                Container(
                  height : MediaQuery.of(context).size.height/5,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    // shrinkWrap: true,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          if(sort_list[0]){
                            setState(() {
                              sort_list[0] = false;
                            });
                          }else{
                            setState(() {
                              sort_list[0] = true;
                              sort_list[1] = false;
                              sort_list[2] = false;
                              sort_list[3] = false;
                            });
                          }
                        },
                        child: Card(
                      elevation: 3.0,
                      color: sort_list[0]?Theme.of(context).accentColor:Theme.of(context).backgroundColor,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Column(
                            children: <Widget>[
                              new Container(
                                margin: EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Text(
                                      "LOWEST",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "PRICE",
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 16.0,
                                          letterSpacing: 0.5),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "FIRST",
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 16.0,
                                          letterSpacing: 0.5),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                      ),
                      

                      GestureDetector(
                       onTap: () {
                        if(sort_list[1]){
                            setState(() {
                              sort_list[1] = false;
                            });
                          }else{
                            setState(() {
                              sort_list[0] = false;
                              sort_list[1] = true;
                              sort_list[2] = false;
                              sort_list[3] = false;
                            });
                          }
                       }, 
                       child:  Card(
                         color: sort_list[1]?Theme.of(context).accentColor:Theme.of(context).backgroundColor,
                      elevation: 3.0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Column(
                            children: <Widget>[
                              new Container(
                                margin: EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Text(
                                      "HIGHEST",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "PRICE",
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 16.0,
                                          letterSpacing: 0.5),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "FIRST",
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 16.0,
                                          letterSpacing: 0.5),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                      ),
                      GestureDetector(
                      onTap: () {
                        if(sort_list[2]){
                            setState(() {
                              sort_list[2] = false;
                            });
                          }else{
                            setState(() {
                              sort_list[0] = false;
                              sort_list[1] = false;
                              sort_list[2] = true;
                              sort_list[3] = false;
                            });
                          }

                      },
                      child: Card(
                      elevation: 3.0,
                      color: sort_list[2]?Theme.of(context).accentColor:Theme.of(context).backgroundColor,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Column(
                            children: <Widget>[
                              new Container(
                                margin: EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Text(
                                      "MOST",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "POPULAR",
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 16.0,
                                          letterSpacing: 0.5),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "FIRST",
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 16.0,
                                          letterSpacing: 0.5),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                      ),
                    
                    GestureDetector(
                      onTap: () {
                        if(sort_list[3]){
                            setState(() {
                              sort_list[3] = false;
                            });
                          }else{
                            setState(() {
                              sort_list[0] = false;
                              sort_list[1] = false;
                              sort_list[2] = false;
                              sort_list[3] = true;
                            });
                          }
                        
                      },
                      child: Card(
                      elevation: 3.0,
                      color: sort_list[3]?Theme.of(context).accentColor:Theme.of(context).backgroundColor,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Column(
                            children: <Widget>[
                              new Container(
                                margin: EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Text(
                                      "NEWEST",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "ARRIVAL",
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 16.0,
                                          letterSpacing: 0.5),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "FIRST",
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 16.0,
                                          letterSpacing: 0.5),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    )

                    
            
                    ],
                  ),
                
             
                ),
                 Divider(),
                 Container(
            alignment: Alignment.topLeft,
            margin:
                EdgeInsets.only(left: 12.0, top: 5.0, right: 0.0, bottom: 5.0),
            child: new Text(
              'Discount',
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
          ),

         
              
                Container(
                  height : MediaQuery.of(context).size.height/7,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    // shrinkWrap: true,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          if(discount_list[0]){
                            setState(() {
                              discount_list[0] = false;
                            });
                          }else{
                            setState(() {
                              discount_list[0] = true;
                              discount_list[1] = false;
                              discount_list[2] = false;
                              discount_list[3] = false;
                              discount_list[4] = false;
                            });
                          }
                        },
                        child:Card(
                      elevation: 3.0,
                      color: discount_list[0]?Theme.of(context).accentColor:Theme.of(context).backgroundColor,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Column(
                            children: <Widget>[
                              new Container(
                                margin: EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    new Text(
                                      "10%",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "OR MORE",
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 16.0,
                                          letterSpacing: 0.5),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ) ,
                      ),

                       GestureDetector(
                        onTap: () {
                          if(discount_list[1]){
                            setState(() {
                              discount_list[1] = false;
                            });
                          }else{
                            setState(() {
                              discount_list[0] = false;
                              discount_list[1] = true;
                              discount_list[2] = false;
                              discount_list[3] = false;
                              discount_list[4] = false;
                            });
                          }
                        },
                        child:Card(
                       color: discount_list[1]?Theme.of(context).accentColor:Theme.of(context).backgroundColor,

                      elevation: 3.0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Column(
                            children: <Widget>[
                              new Container(
                                margin: EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    new Text(
                                      "20%",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "OR MORE",
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 16.0,
                                          letterSpacing: 0.5),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ) ,
                      ),

                       GestureDetector(
                        onTap: () {
                          if(discount_list[2]){
                            setState(() {
                              discount_list[2] = false;
                            });
                          }else{
                            setState(() {
                              discount_list[0] = false;
                              discount_list[1] = false;
                              discount_list[2] = true;
                              discount_list[3] = false;
                              discount_list[4] = false;
                            });
                          }
                        },
                        child:Card(
                      elevation: 3.0,
                      color: discount_list[2]?Theme.of(context).accentColor:Theme.of(context).backgroundColor,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Column(
                            children: <Widget>[
                              new Container(
                                margin: EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    new Text(
                                      "30%",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "OR MORE",
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 16.0,
                                          letterSpacing: 0.5),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ) ,
                      ),

                       GestureDetector(
                        onTap: () {
                          if(discount_list[3]){
                            setState(() {
                              discount_list[3] = false;
                            });
                          }else{
                            setState(() {
                              discount_list[0] = false;
                              discount_list[1] = false;
                              discount_list[2] = false;
                              discount_list[3] = true;
                              discount_list[4] = false;
                            });
                          }
                        },
                        child:Card(
                      elevation: 3.0,
                      color: discount_list[3]?Theme.of(context).accentColor:Theme.of(context).backgroundColor,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Column(
                            children: <Widget>[
                              new Container(
                                margin: EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    new Text(
                                      "40%",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "OR MORE",
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 16.0,
                                          letterSpacing: 0.5),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ) ,
                      ),

                       GestureDetector(
                        onTap: () {
                          if(discount_list[4]){
                            setState(() {
                              discount_list[4] = false;
                            });
                          }else{
                            setState(() {
                              discount_list[0] = false;
                              discount_list[1] = false;
                              discount_list[2] = false;
                              discount_list[3] = false;
                              discount_list[4] = true;
                            });
                          }
                        },
                        child:Card(
                      elevation: 3.0,
                      color: discount_list[4]?Theme.of(context).accentColor:Theme.of(context).backgroundColor,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Column(
                            children: <Widget>[
                              new Container(
                                margin: EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    new Text(
                                      "50%",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "OR MORE",
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 16.0,
                                          letterSpacing: 0.5),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ) ,
                      ),

                    ],
                  ),
                
             
                )
               
                ],
            ),
          ): Container()
        ],
      )); 
   
  }
}
