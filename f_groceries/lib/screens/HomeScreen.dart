import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_groceries/Objects/badge_cart.dart';
import 'package:f_groceries/Objects/badge_notification.dart';
import 'package:f_groceries/Objects/product.dart';
import 'package:f_groceries/Objects/profile.dart';
import 'package:f_groceries/Objects/tag.dart';
import 'package:f_groceries/Utils/constants.dart';
import 'package:f_groceries/Utils/woocommerce_api.dart';
import 'package:f_groceries/Objects/category.dart';
import 'package:f_groceries/Widgets/featProductCard.dart';
import 'package:f_groceries/Widgets/product_card.dart';
import 'package:f_groceries/database/user/db_helper.dart';
import 'package:f_groceries/database/user/user.dart';
import 'package:f_groceries/model/notification_model.dart';
import 'package:f_groceries/screens/Cart_Screen.dart';
import 'package:f_groceries/screens/help_screen.dart';
import 'package:f_groceries/screens/item_details.dart';
import 'package:f_groceries/screens/item_screen_category.dart';
import 'package:f_groceries/screens/item_screen_tag.dart';
import 'package:f_groceries/screens/logind_signup.dart';
import 'package:f_groceries/screens/all_item_listing.dart';
import 'package:f_groceries/screens/notification_user.dart';
import 'package:f_groceries/screens/offer_screen.dart';
import 'package:f_groceries/screens/orderhistory_screen.dart';
import 'package:f_groceries/screens/search.dart';
import 'package:f_groceries/screens/setting_screen.dart';
import 'package:f_groceries/screens/top_seller.dart';
import 'package:f_groceries/screens/wishlist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loader_search_bar/loader_search_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Account_screen.dart';

const String _kGalleryAssetsPackage = 'flutter_gallery_assets';

class Home_screen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new home();
// TODO: implement createState

}


class home extends State<Home_screen> {
  List list = ['12', '11'];
  List catsList = [];
  List featCatsList = [];
  List featProductsList = [];
  List temp;
  bool catsLoading = true;
  var userdb = UserHelper();
  static const double height = 366.0;
  String name ='My Wishlist';
  User user;
  Profile profile;
  Map data;
  bool featProductsLoading = true;
  bool tagsLoading = true;
  List tagList;
  bool fullPageLoading = true;

  WooCommerceAPI wc_api = WooCommerceAPI("${Constants.baseURL}",
      "${Constants.consumerKey}", "${Constants.consumerSecret}");

  final globalKey = GlobalKey<ScaffoldState>();

  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  List<NotificationModel> notificationList;
  List<NotificationModel> notificationList1 = new List<NotificationModel>();

      
  getCats() async {
    setState(() {
      fullPageLoading = true;
    });


    var res = await wc_api.getAsync("products/categories");

    var decodedJson = jsonDecode(res.body);

    if (res.statusCode == 200 && decodedJson != null) {
      if (mounted) {
        setState(() {
          temp = decodedJson;
          for (var i = 0; i < temp.length; i++) {
            if (temp[i]['id'] == 16 || temp[i]['id'] == 17 || temp[i]['id'] == 20 || temp[i]['id'] == 21){
              catsList.add(temp[i]);
            }
            else if (temp[i]['id'] == 15) {
              
            }
            else{
              featCatsList.add(temp[i]);
            }
          }
          catsLoading = false;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          catsLoading = false;
          fullPageLoading = false;
        });
      }
    }
  }

  getFeatProducts() async {
        setState(() {
      featProductsLoading = true;
      fullPageLoading = true;
    });


    var res = await wc_api.getAsync("products?featured=true");

    var decodedJson = jsonDecode(res.body);
    if (res.statusCode == 200 && decodedJson != null) {
      if (mounted) {
        setState(() {
          featProductsList = decodedJson;
          featProductsLoading = false;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          featProductsLoading = false;
          fullPageLoading = false;
        });
      }
    }
  }

  getTags() async {
            setState(() {
      tagsLoading = true;
      fullPageLoading = true;
    });


    var res = await wc_api.getAsync("products/tags");

    var decodedJson = jsonDecode(res.body);
    if (res.statusCode == 200 && decodedJson != null) {
      if (mounted) {
        setState(() {
          tagList = decodedJson;
          tagsLoading = false;
          fullPageLoading = false;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          tagsLoading = false;
          fullPageLoading = false;
        });
      }
    }
  }



  logout() async{
    int del = await userdb.deleteUser(1);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("login", false);
    if(preferences.getString("login_method") == "google"){
          await FirebaseAuth.instance.signOut().then((value) async {
           await GoogleSignIn().signOut();
                Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context){
          return Login_Screen();
        },
      ),
    );
          }
          );
    }

       Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context){
          return Login_Screen();
        },
      ),
    );
    

  }


  getProfile() async {

    user = await userdb.getUser(1);
    setState(() {
      user = user;
    });

    if (user == null) {
      //_showAlert(context, "Sign In !", "You are not signed in");
    } else {
      var res = await wc_api.getAsync("customers/${user.userId}");
      var decodedJson = jsonDecode(res.body);

      if (res.statusCode == 200 && decodedJson != null) {
        if (mounted) {
          setState(() {
            profile = Profile.fromJson(decodedJson);
            data = decodedJson;
          });
        }
      }
      }
    }
  
  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            // backgroundColor:  Theme.of(context).backgroundColor,
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit the App'),
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
                onPressed: () =>
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
                child: new Text('Yes', style: TextStyle(color: Theme.of(context).accentColor,),),
              ),
            ],
          ),
        ) ??
        false;
  }

  getNotification() async{
    user = await userdb.getUser(1);

      Firestore.instance
      .collection("users")
      .document(user.email)
      .collection("notifications")
      .orderBy("date", descending: true).
      snapshots().listen((data){
       if(notificationList != null)
              {
                notificationList.clear(); 
              }
       data.documents.forEach((doc) async {   
         if(this.mounted){
            setState(() {
              
             notificationList1.add(NotificationModel(
                          doc['notification_id'],
                          doc['date'],
                          doc['message'],
                          doc['order_id'].toString(),            
                          doc['title'],
                          doc['time'],     
                          doc['icon'],
                          doc['on_tap_screen'],
                          doc['user_id']                                            
                            ));  


          });
         } 
           
      });

        setState(() {

              this.notificationList = notificationList1;              
              print("notificationList : ${this.notificationList}");    
        });

    },
     onDone: () {
                // setState(() {
                // _isInAsyncCall = false;
                // });
                print("Task Done");
            }, onError: (error) {   
              //   setState(() {
              //   _isInAsyncCall = false;
              // });   
                print("Some Error");
            }
          ); 

      setState(() {
      // _isInAsyncCall = false;
    });
  }


  String getTime(){
      String time_string = "";
      TimeOfDay time = TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
      if (time.period == DayPeriod.pm){
        time_string = (int.parse(DateTime.now().hour.toString())-12).toString()+":"+DateTime.now().minute.toString()+ " " + "PM";
      }else{
        time_string = DateTime.now().hour.toString()+":"+DateTime.now().minute.toString()+ " " + "AM";
      }
      return time_string;
  }

    @override
  void initState() {
    super.initState();

          _fcm.configure(
        onMessage: (Map<String, dynamic> message) async {
            print("onMessage: $message");
            // showDialog(
            //     context: context,
            //     builder: (context) => AlertDialog(
            //             content: ListTile(
            //             title: Text(message['notification']['title']),
            //             subtitle: Text(message['notification']['body']),
            //             ),
            //             actions: <Widget>[
            //             FlatButton(
            //                 child: Text('Ok onMessage'),
            //                 onPressed: () => Navigator.of(context).pop(),
            //             ),
            //         ],
            //     ),
            // );

      String date = DateTime.now().day.toString() +"/"+ DateTime.now().month.toString() + "/"+ DateTime.now().year.toString(); 

      await _db.collection("users").document(user.email).collection("notifications")
      .add({
      "date": date,
      "time": getTime(),
      "order_id": null,
      "title": "Offers Unveiled",
      "message": "Tap to know more",
      "icon": "https://webcomicms.net/sites/default/files/clipart/175966/special-offer-png-transparent-images-175966-5714353.png",
      "user_id": user.email,
      "on_tap_screen": "offer_screen"
    });

    await _db.collection("notifications")
      .add({
      "date": date,
      "time": getTime(),
      "order_id": null,
      "title": "Offers Unveiled",
      "message": "Tap to know more",
      "icon": "https://webcomicms.net/sites/default/files/clipart/175966/special-offer-png-transparent-images-175966-5714353.png",
      "user_id": user.email,
      "on_tap_screen": "offer_screen"
    });


        },
        onLaunch: (Map<String, dynamic> message) async {
          print("onMessage: $message");

            Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {

          switch(message['data']['on_tap_screen']){
                case "order_screen":
                      
                      return Order_History(toolbarname: ' Order History',);
                      
                     
                case "offer_screen": 
                      return OfferScreen(
                      );
          }


        },
      ),
    );
        },
        onResume: (Map<String, dynamic> message) async {

          print("onMessage: $message");
                        Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {

          switch(message['data']['on_tap_screen']){
                case "order_screen":
                      
                      return Order_History(toolbarname: ' Order History',);
                      
                     
                case "offer_screen": 
                      return OfferScreen(
                      );
          }


        },
      ),
    );
        },
      );


    _saveDeviceToken();
    getCats();
    getProfile();
    getFeatProducts();
    getTags();
    getNotification();


    
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final Orientation orientation = MediaQuery.of(context).orientation;
  
    final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle =
        theme.textTheme.headline.copyWith(color: Colors.black54);
    final TextStyle descriptionStyle = theme.textTheme.subhead;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Builder(builder: (context)=> Scaffold(
        key: globalKey,
      appBar:  new AppBar(
        title: Text("Grocery store",style: TextStyle(fontWeight: FontWeight.bold),),
        actions: <Widget>[
          IconButton(
            tooltip: 'Search',
            icon: const Icon(Icons.search,color: Colors.black,),
            onPressed: () async {
            await Navigator.push(context, MaterialPageRoute(builder: (context)=>Search(key:UniqueKey() ,id: 0,name: "",)));
              
            },
          ),
          IconButton(
            tooltip: 'Notification',
            icon: IconBadge_notification(counter: notificationList == null ? 0:notificationList.length,
                ),
            onPressed: () async {
            await Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationPage(notificationList:notificationList)));
              
            },
          ),
          IconButton(
                      icon: IconBadge_cart(
                  icon: Icons.shopping_cart,
                  size: 25.0,
                ),
                        onPressed: () async {
                         await Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart_screen()));
                         setState(() {
                           
                         });
                        }),
        
        ],
      
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () => globalKey.currentState.openDrawer(),
        ),
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new Card(
              child: UserAccountsDrawerHeader(
                accountName: new Text(profile == null?"":profile.firstName+" "+profile.lastName),
                accountEmail: new Text(profile == null?"":profile.email),
                onDetailsPressed: () async {
                await  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Account_Screen(profile: profile,)));
                getProfile();
                },
                decoration: new BoxDecoration(
                  backgroundBlendMode: BlendMode.difference,
                  color: Colors.grey,

                //    image: new DecorationImage(
                // image: new ExactAssetImage('images/brand_f.jpg'),
                //   fit: BoxFit.cover,
                // ),
                ),
                currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(profile == null?
                        "https://www.fakenamegenerator.com/images/sil-female.png":profile.avatarUrl)),
              ),
            ),
            new Card(
              elevation: 4.0,
              child: new Column(
                children: <Widget>[
                  new ListTile(
                      leading: Icon(Icons.favorite),
                      title: new Text("My Wishlist"),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> WishListPage()));
                      }),
                  new Divider(),
                  new ListTile(
                      leading: Icon(Icons.history),
                      title: new Text("Order History "),


                      onTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context)=> Order_History(toolbarname: ' Order History',)));

                      }),
                ],
              ),
            ),
            new Card(
              elevation: 4.0,
              child: new Column(
                children: <Widget>[
                  new ListTile(
                      leading: Icon(Icons.settings),
                      title: new Text("Setting"),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Setting_Screen(toolbarname: 'Setting',)));
                      }),
                  new Divider(),
                  new ListTile(
                      leading: Icon(Icons.help),
                      title: new Text("Help"),
                      onTap: () {

                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Help_Screen(toolbarname: 'Help',)));

                      }),
                ],
              ),
            ),
            new Card(
              elevation: 4.0,
              child: new ListTile(
                  leading: Icon(Icons.power_settings_new),
                  title: new Text(
                    "Logout",
                    style:
                        new TextStyle(color: Colors.redAccent, fontSize: 17.0),
                  ),
                  onTap: () {
                    logout();
                  }),
            )
          ],
        ),
      ),
      body:  fullPageLoading ?  Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).accentColor),
                  ),
                ): new ListView(shrinkWrap: true, children: <Widget>[
            // new Row(
            //     mainAxisSize: MainAxisSize.max,
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: <Widget>[
            //       _verticalD(),
            //       new GestureDetector(
            //         onTap: () {
            //           // Navigator.push(context, MaterialPageRoute(builder: (context)=> Item_Screen(toolbarname: 'Fruits & Vegetables',)));
            //         },
            //         child: new Text(
            //           'Best value',
            //           style: TextStyle(
            //               fontSize: 20.0,
            //               color: Colors.black87,
            //               fontWeight: FontWeight.bold),
            //         ),
            //       ),
            //       _verticalD(),
            //       new GestureDetector(
            //         onTap: () {
            //           Navigator.push(context, MaterialPageRoute(builder: (context)=> TopSeller()));
            //         },
            //         child: new Text(
            //           'Top sellers',
            //           style: TextStyle(
            //               fontSize: 20.0,
            //               color: Colors.black26,
            //               fontWeight: FontWeight.bold),
            //         ),
            //       ),
            //       _verticalD(),
            //       new GestureDetector(
            //         onTap: () {
            //           Navigator.push(context, MaterialPageRoute(builder: (context)=> AllProducts()));
            //         },
            //         child: new Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //         children: <Widget>[
            //           new Text(
            //               'All',
            //               style: TextStyle(
            //                   fontSize: 20.0,
            //                   color: Colors.black26,
            //                   fontWeight: FontWeight.bold),
            //             ),
                      
            //           _verticalD(),
            //           IconButton(
            //             icon: keyloch,
            //             color: Colors.black26,
            //           )
            //         ],
            //       ),
            //       )
                  
            //     ]),
            
            new Container(
              height: 188.0,
              margin: EdgeInsets.only(left: 5.0,top: 5,bottom: 5,right: 5),
              child: catsLoading?  Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).accentColor),
                  ),
                ):


    Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: MediaQuery.of(context).size.width / 1,
                        child: InkWell(
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            child: Stack(children: <Widget>[
                              CachedNetworkImage(
                                imageUrl: featCatsList[index]["image"] == null
                                    ? ""
                                    : featCatsList[index]["image"]['src'],
                                fit: BoxFit.fill,
                                width: MediaQuery.of(context).size.width / 1,
                              ),
                            ]),
                          ),
                          onTap: () {
                                     Category cat = Category.fromJson(featCatsList[index]);

                            // check if the category is front banner
                            
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return CategoryProducts(
                                      img: cat.image == null
                                          ? ""
                                          : cat.image.src,
                                      name: cat.name,
                                      id: cat.id,
                                      products: cat.count <= 1
                                          ? "${cat.count} Product"
                                          : "${cat.count} Products",
                                    );
                                  },
                                ),
                              );
                          },
                        ),
                      );
                    },
                    itemCount: featCatsList.length,
                    viewportFraction: 0.9,
                    scale: 0.95,
                    loop: true,
                    autoplay: true,
                    
                    pagination:
                        new SwiperPagination(alignment: Alignment.bottomCenter, builder: SwiperPagination.dots),
                  ),
            ),
                  
            Container(
              height: MediaQuery.of(context).size.height/2.4,
              // color: Theme.of(context).accentColor.withOpacity(0.8),
              child: Padding(padding: 
              EdgeInsets.only(left: 10),
              child: 
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                 Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                 child: new Text(
                        'DEALS OF THE DAY',
                        style: TextStyle(
                            fontSize: 20.0,
                            // color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),) ,
                  Container(
                    
                    height : MediaQuery.of(context).size.height/3,
                    child: ListView.builder(
                itemCount: featProductsList.length,
                
                scrollDirection: Axis.horizontal,
    itemBuilder: (BuildContext ctxt, int index) {
      Product product = Product.fromJson(featProductsList[index]);
                      print(product.id);
                      return Container(
                        width: MediaQuery.of(context).size.width/1.75,
                        child: FeatProduct_Card(
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
                        images: featProductsList[index]['images'],
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
                        serve_quantity:product.attributes != null &&
                                    product.attributes.length >= 1
                                ? product.attributes[0].options[0].toString()
                                : "",
                        stock_status: product.stockStatus,
                      ),
                      ); 

                    
     
     }
              )
                  )
                ],
              ) 
              )

            ),


            new Container(
              height: 150,
              margin: EdgeInsets.only(left: 5.0,top: 5,bottom: 5,right: 5),
              child: tagsLoading? Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).accentColor),
                  ),
                ):


    Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: MediaQuery.of(context).size.width / 1,
                        child: InkWell(
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            child: Stack(children: <Widget>[
                              CachedNetworkImage(
                                imageUrl: tagList[index]["description"] == null
                                    ? ""
                                    : tagList[index]["description"] ,
                                fit: BoxFit.fill,
                                width: MediaQuery.of(context).size.width / 1,
                              ),
                            ]),
                          ),
                          onTap: () async {
                                  Tag tag = Tag.fromJson(tagList[index]);
        
                            print(tag.count);
                            await  Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return TagProducts(
                                      key: UniqueKey(),
                                      img: tag.description==null
                                          ? ""
                                          : tag.description,
                                      name: tag.name,
                                      id: tag.id,
                                      products: tag.count <= 1
                                          ? "${tag.count} Product"
                                          : "${tag.count} Products",
                                    );
                                  },
                                ),
                              );
                            setState(() {
                              
                            });

                          },
                        ),
                      );
                    },
                    itemCount: tagList.length,
                    viewportFraction: 0.9,
                    scale: 0.95,
                    loop: true,
                    autoplay: true,
                    
                    // pagination:
                    //     new SwiperPagination(alignment: Alignment.bottomCenter, builder: SwiperPagination.dots),
                  ),
            ),
            new Container(
              margin: EdgeInsets.only(top: 7.0),
              child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _verticalD(),
                    new GestureDetector(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=> Item_Details()));
                      },
                      child: new Text(
                        'Categories',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    _verticalD(),
                    new GestureDetector(
                      onTap: () async {
                      await  Navigator.push(context, MaterialPageRoute(builder: (context)=>TopSeller(key: UniqueKey(),)));
                      setState(() {
                        
                      });
                      },
                      child: new Text(
                        'Popular',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black26,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    _verticalD(),
                    new Row(
                      children: <Widget>[
                  new GestureDetector(
                    onTap: () async {
                    await  Navigator.push(context, MaterialPageRoute(builder: (context)=> AllProducts(key: UniqueKey(),)));
                    setState(() {
                      
                    });
                    },
                    child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                          'All',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black26,
                              fontWeight: FontWeight.bold),
                        ),
                      
                      _verticalD(),
                      IconButton(
                        icon: keyloch,
                        color: Colors.black26,
                      )
                    ],
                  ),
                  )
                      ],
                    )
                  ]),
            ),
            catsLoading
            ? Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).accentColor),
                  ),
                ):
            GridView.builder(
                  shrinkWrap: true,
                  itemCount: catsList.length,
                  primary: false,
                  physics: NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(10.0),
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                  childAspectRatio: MediaQuery.of(context).size.width /
                           (MediaQuery.of(context).size.height/3),),
                  itemBuilder: (BuildContext context, int index) {
                    return new GestureDetector(
                      onTap: () async {

                            Category cat = Category.fromJson(catsList[index]);

                            // check if the category is front banner
                            
                            await  Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return CategoryProducts(
                                      key: UniqueKey(),
                                      img: cat.image == null
                                          ? ""
                                          : cat.image.src,
                                      name: cat.name,
                                      id: cat.id,
                                      products: cat.count <= 1
                                          ? "${cat.count} Product"
                                          : "${cat.count} Products",
                                    );
                                  },
                                ),
                              );
                              setState(() {
                                
                              });
                      },
                        child:  new Card(
                                shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15.0),
  ),
                              elevation: 3.0,
                              child: Stack(
                                        children: <Widget>[
                                    //       Positioned.fill(
                                    //           child: Image.asset(
                                    //         catsList[index]["image"] == null
                                    // ? ""
                                    // : catsList[index]["image"]['src'],
                                    //         fit: BoxFit.cover,
                                    //       )),

                                    CachedNetworkImage(
                                imageUrl: catsList[index]["image"] == null
                                    ? ""
                                    : catsList[index]["image"]['src'],
                                fit: BoxFit.fill,
                                width: MediaQuery.of(context).size.width / 1,
                                height: MediaQuery.of(context).size.height
                              ),
                                          Container(
                                            color: Colors.black.withOpacity(0.2),
                                          ),
                                          
                                          Align(
                alignment: Alignment.bottomLeft,
                
                child:Padding(
                  padding: EdgeInsets.fromLTRB(5, 0, 0, 5),
                  child: Text(
                                    catsList[index]['name'],
                                    style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                  ),
                ),
                
              ),

                                        ],
                                      ),
                             
                            )
                        

                    );
                  }),
            
         
         
            // Center(
            //   child: Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Container(
            //             alignment: Alignment.center,
            //             child: OutlineButton(
            //                 borderSide:
            //                     BorderSide(color: Colors.amber.shade500),
            //                 child: const Text('EXPLORE ALL ITEMS'),
            //                 textColor: Colors.amber.shade500,
            //                 onPressed: () async {
            //                   await Navigator.push(context, MaterialPageRoute(builder: (context)=> AllProducts()));
                            
            //                 },
            //                 shape: new OutlineInputBorder(
            //                   borderRadius: BorderRadius.circular(30.0),
            //                 )),
            //           ),
            //         ),
            // )
          ]),
      
    ),
    )
     ) ;
  }

/*
  new Container(
  alignment: Alignment.topCenter,
  child: GridView.count(
  primary: true,
  crossAxisCount: 2,
  childAspectRatio: 0.80,
  children: List.generate(photos.length, (index) {
  return getStructuredGridCell(photos[index]);
  }),
  ))*/
  Icon keyloch = new Icon(
    Icons.arrow_forward,
    color: Colors.black26,
  );

  _verticalD() => Container(
        margin: EdgeInsets.only(left: 5.0, right: 0.0, top: 5.0, bottom: 0.0),
      );


    _saveDeviceToken() async {
    // FirebaseUser user = await _auth.currentUser();

    // Get the token for this device
    user = await userdb.getUser(1);
    String fcmToken = await _fcm.getToken();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    

    // Save it to Firestore
    if (fcmToken != null) {
      var tokens = _db
          .collection('users')
          .document(user.email)
          .collection('tokens')
          .document(fcmToken);

      await tokens.setData({
        'token': fcmToken,
        'createdAt': FieldValue.serverTimestamp(),
        'notification': preferences.getBool("notification")
      });

      var tokens_new = _db
          .collection('fcmTokens')
          .document(fcmToken).setData({
        'token': fcmToken,
        'createdAt': FieldValue.serverTimestamp(),
        'notification': preferences.getBool("notification")
      });


    }
  }
}
