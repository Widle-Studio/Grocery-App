import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:f_groceries/Objects/product.dart';
import 'package:f_groceries/Utils/constants.dart';
import 'package:f_groceries/Utils/woocommerce_api.dart';
import 'package:f_groceries/Widgets/product_card.dart';
import 'package:f_groceries/screens/item_details.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {

    final int id;
    final String name;


  Search({
    Key key,
    @required this.id,
    @required this.name,
  }) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController controller = new TextEditingController();
  List searchList;
  bool _loading = false;
  StreamSubscription dataSub;

  WooCommerceAPI wc_api = WooCommerceAPI("${Constants.baseURL}",
      "${Constants.consumerKey}", "${Constants.consumerSecret}");

  getRes(String query) async {
     var res;
    if(widget.id!=0){
      res = await wc_api.getAsync("products?status=publish&search=$query&stock_status=instock&category=$widget.id");
    }else{
      res = await wc_api.getAsync("products?status=publish&search=$query&stock_status=instock");
    }
   
    return res;
  }

  getSearch(String query) async {
    if (controller.text.isNotEmpty) {
      setState(() {
        _loading = true;
      });

      dataSub = getRes(query).asStream().listen((var data) {
        var decodedJson = jsonDecode(data.body);
        print("Feat GETRAW ${data.body}");
        print("Feat GET$decodedJson");

        if (data.statusCode == 200 && decodedJson != null) {
          if (mounted) {
            setState(() {
              searchList = decodedJson;
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
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Constants.bG,
    
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(color: Colors.black,),
        title: TextField(
                  controller: controller,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: widget.id == 0? 'Search...': 'Search in ${widget.name}...',
                    border: InputBorder.none,
                  ),
                  onChanged: (text) {
                    if (text.isEmpty) {
                      print("object");
                      setState(() {
                        searchList = null;
                        _loading = false;
                      });
                      dataSub.cancel();
                    } else {
                      if (dataSub != null) {
                        dataSub.cancel();
                      }
                      getSearch(text);
                    }
                  },
                  ),
        actions:<Widget>[
          IconButton(
          icon: const Icon(Icons.clear, color: Colors.black,),
          onPressed: () {
            
           controller.clear();
          },
        ),
        ] 
      ),
      body: 
      
      // Padding(
      //   padding: EdgeInsets.all(5.0),
      //   child: searchList == null && _loading == false
      //       ? Container()
      //       : _loading
      //           ? Center(
      //               child: CircularProgressIndicator(
      //                 valueColor: AlwaysStoppedAnimation<Color>(
      //                     Theme.of(context).accentColor),
      //               ),
      //             )
      //           : ListView(
      //               children: <Widget>[
      //                 SizedBox(height: 5.0),
      //                 Container(
      //                   padding: EdgeInsets.all(5.0),
      //                   child: ListView.separated(
      //                     shrinkWrap: true,
      //                     primary: false,
      //                     itemCount: searchList == null ? 0 : searchList.length,
      //                     separatorBuilder: (BuildContext context, int index) {
      //                       return Divider();
      //                     },
      //                     itemBuilder: (BuildContext context, int index) {
      //                       Product product =
      //                           Product.fromJson(searchList[index]);

      //                       return InkWell(
      //                         onTap: () {
      //                           Navigator.of(context).push(
      //                             MaterialPageRoute(
      //                               builder: (BuildContext context) {
      //                                 return Item_Details(
      //           id: product.id,
      //           image: searchList[index]['images'][0]['src'],
      //           name: product.name,
      //           regularPrice: product.regularPrice,
      //           price: product.price,
      //           rating: product.averageRating == null
      //                       ? "0.0"
      //                       : product.averageRating,
      //           desc: product.description,
      //           link: product.permalink,
      //           rateAmount: product.ratingCount,
      //           cat: product.categories == null
      //                       ? 1
      //                       : product.categories[0].id,
      //           quantity: 1,
      //         );
      //                               },
      //                             ),
      //                           );
      //                         },
      //                         child: Padding(
      //                             padding: EdgeInsets.all(2.0),
      //                             child: Material(
      //                                 elevation: 3.0,
      //                                 child: Container(
      //                                     width: MediaQuery.of(context)
      //                                             .size
      //                                             .width -
      //                                         20.0,
      //                                     height: 80.0,
      //                                     decoration: BoxDecoration(
      //                                       color: Colors.white,
      //                                     ),
      //                                     child: Row(
      //                                       children: <Widget>[
      //                                         SizedBox(width: 2.0),
      //                                         Container(
      //                                           child: CachedNetworkImage(
      //                                             height: 65.0,
      //                                             width: 65.0,
      //                                             imageUrl: product.images ==
      //                                                     null
      //                                                 ? ""
      //                                                 : product.images[0].src,
      //                                             fit: BoxFit.cover,
      //                                           ),
      //                                         ),
      //                                         SizedBox(width: 4.0),
      //                                         Container(
      //                                           margin: EdgeInsets.fromLTRB(
      //                                               10.0, 5.0, 0.0, 0.0),
      //                                           child: Column(
      //                                             mainAxisAlignment:
      //                                                 MainAxisAlignment.center,
      //                                             crossAxisAlignment:
      //                                                 CrossAxisAlignment.start,
      //                                             children: <Widget>[
      //                                               Row(
      //                                                 mainAxisAlignment:
      //                                                     MainAxisAlignment
      //                                                         .spaceBetween,
      //                                                 children: <Widget>[
      //                                                   Container(
      //                                                     width: MediaQuery.of(
      //                                                                 context)
      //                                                             .size
      //                                                             .width /
      //                                                         1.8,
      //                                                     color: Colors
      //                                                         .transparent,
      //                                                     child: Text(
      //                                                       product.name,
      //                                                       style: new TextStyle(
      //                                                           color: Colors.black,
      //                                                           fontSize: 15.0,
      //                                                           fontWeight:
      //                                                               FontWeight
      //                                                                   .bold),
      //                                                     ),
      //                                                   ),
      //                                                   Container(
      //                                                     child: Text(
      //                                                       "₹${product.price}",
      //                                                       style: new TextStyle(
      //                                                           color: Colors
      //                                                               .black,
      //                                                           fontSize: 15.0),
      //                                                     ),
      //                                                   ),
      //                                                 ],
      //                                               ),
                                                    
                                                    
      //                                             ],
      //                                           ),
      //                                         ),
      //                                       ],
      //                                     )))),
      //                       );
      //                     },
      //                   ),
      //                 ),
      //               ],
      //             ),
      // ),


      Stack(
        children: <Widget>[
          searchList == null && _loading == false
            ? Container()
            :
          _loading
              ? 
              Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).accentColor),
                  ),
                )

              :  ListView(
        children: <Widget>[
          // Divider(),
          
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
                    itemCount: searchList.length,
                    itemBuilder: (BuildContext context, int index) {
                      Product product = Product.fromJson(searchList[index]);
                      print(product.id);
                      return Product_Card(
                        id: product.id,
                        img:
                            product.images == null ? "" : product.images[0].src,
                        rating: product.averageRating == null
                            ? "0.0"
                            : product.averageRating,
                        sales: product.totalSales == 0
                            ? "No Sales yet"
                            : "${product.totalSales} Sales",
                        images: searchList[index]['images'],
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
                        serve_quantity: product.attributes[0].options[0],
                        stock_status: product.stockStatus,
                      );

                    
                    },
                  ),
                ),
        ],
      ),
         ],
      )
    );
  }
}
