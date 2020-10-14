import 'dart:convert';
import 'dart:io';

import 'package:f_groceries/Utils/constants.dart';
import 'package:f_groceries/Utils/woocommerce_api.dart';
import 'package:f_groceries/Widgets/smooth_star_rating.dart';
import 'package:f_groceries/database/user/db_helper.dart';
import 'package:f_groceries/database/user/user.dart';
import 'package:f_groceries/screens/HomeScreen.dart';
import 'package:f_groceries/screens/logind_signup.dart';
import 'package:f_groceries/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class WriteReview extends StatefulWidget {


  final int id;


  const WriteReview({Key key, this.id, }) : super(key: key);

  ThemeData buildTheme() {
    final ThemeData base = ThemeData();
    return base.copyWith(
      hintColor: Colors.red,
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
            color: Colors.yellow,
            fontSize: 24.0
        ),
      ),
    );
  }
  @override
  State<StatefulWidget> createState() => writeReview();
}

class writeReview extends State<WriteReview> {

  ProgressDialog _loading_info;
  final TextEditingController _emailControl = new TextEditingController();
  List review;
  bool reviews_loading = false;
  TextEditingController _commentsController;

  WooCommerceAPI wc_api = WooCommerceAPI("${Constants.baseURL}",
      "${Constants.consumerKey}", "${Constants.consumerSecret}");
  
  User user;
  var user_list;
  var userdb = UserHelper();
  double rating;
  bool edit = false;
  bool new_review = true;
  int review_id;
  

  Future<http.Response> getAsync(int id, String email) async {
  String email = _emailControl.text;
var url = "https://imperialinfosys.com/grocery-app/wp-json/wc/v3/products/reviews?product=${widget.id}&reviewer_email=${user.email}&consumer_key=ck_742e8cb6f82ad59628fb8a2a9dde0fbb9ddba5c0&consumer_secret=cs_64994bcbf7e73ff726788de1d0ddfbc523dc0c4a";

  final response = await http.get(url);

  return response;
}


  void _showNotif(BuildContext context, String title, String body){
    showDialog(
      context: context,
      builder: (context)=>AlertDialog(
        title: Text(title),
        content: Html(
          data: body,
          onLinkTap: (url) {
            // _launchURL(url);
          },
        ),

        actions: <Widget>[

          FlatButton(
            onPressed: (){
              if(title == "Email sent!"){
                 Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context){
            return Login_Screen();
          },
        ),
      );
              }else{
                Navigator.of(context).pop();
              }
                  
              },
            child: Text("OK"),
          )
        ],
      ),
    );
  }

  checkReview() async {
    
    user = await userdb.getUser(1); 

    setState(() {
      reviews_loading = true;
    });

    var res = await wc_api
    .getAsync("customers/${user.userId}");

    var decodedJson = jsonDecode(res.body);
    setState(() {
      user_list = decodedJson;
    });

    res = await getAsync(widget.id, user.email);

    decodedJson = jsonDecode(res.body);
    print("Feat GETRAW ${res.body}");
    print("Feat GET$decodedJson");

    if (res.statusCode == 200 && decodedJson != null) {
      if (mounted) {
        setState(() {
          review = decodedJson;
          print(review.length);
          if(review.length == 0){
            rating = 0;
            edit = true;
            new_review = true;
          }else{
            print(review[0]['rating']);
            rating = double.parse(review[0]['rating'].toString()) ;
            review_id = review[0]['id'];
            // _commentsController.text =  review[0]['review'];
            edit = false;
            new_review = false;
          }
          reviews_loading = false;
        });
      }
    } else {
      print("Something went wrong");
      if (mounted) {
        setState(() {
          reviews_loading = false;
        });
      }
    }
  }

  submitReview() async {

    print("here");
    reviews_loading = true;

   var data = {
    "product_id": widget.id,
    "review": _commentsController.text,
    "reviewer": user_list['first_name'] + " " + user_list['last_name'],
    "reviewer_email": user_list['email'],
    "rating": rating,
};


    var res = await wc_api.postAsync(
        "products/reviews", 
        data
      );
    print(res.body);
      if (res.statusCode == 200) {
    checkReview();
  }else{
    setState(() {
      reviews_loading = false;
    });
    
  }
  }

  updateReview() async {
    print("here");
    setState(() {
        reviews_loading = true;
    });
    

   var data = {
    "review": _commentsController.text,
    "rating": rating,
};


    var res = await wc_api.putAsync(
        "products/reviews/$review_id", 
        data
      );
    print(res.body);
    print(res.statusCode);
      if (res.statusCode == 200) {
    checkReview();
  }else{
    setState(() {
      // edit = false;
       reviews_loading = false;
    });
   
  }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _commentsController = new TextEditingController();
    checkReview();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: new AppBar(
          title: Text('Write Review',style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
                
        ),
        body: reviews_loading
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).accentColor),
                ),
              )
            : 
            new ListView(
              shrinkWrap: true,
              children: <Widget>[
                Divider(),

                   Card(
                        elevation: 5.0,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: new SafeArea(

                    top: false,
                    bottom: false,
                    child:  Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        CircleAvatar(
                    // backgroundImage: NetworkImage(profile == null?
                    //     "https://www.fakenamegenerator.com/images/sil-female.png":profile.avatarUrl)
                    backgroundImage: NetworkImage(
                      user_list['avatar_url'],
                    ),
                        ),

  
                        Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(
                              user_list['first_name']+" "+user_list['last_name'],
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                            ),
                          ),



                                      ],
                                    ),

                                    Row(
                                      children: <Widget>[

                                        SizedBox(
                                          width: MediaQuery.of(context).size.width/7
                                        ),
                                        SmoothStarRating(
                      allowHalfRating: false,
                      onRatingChanged: (v) {
                        edit?
                        setState(() {
                          rating = v;
                        }): null;
                      },
                      starCount: 5,
                      rating: rating,
                      size: 25.0,
                      color: Theme.of(context).accentColor,
                      borderColor: Theme.of(context).accentColor,
                      spacing: 0.0,
                    ),
                                      ],
                                    ),

                                    Padding(
                                    padding: EdgeInsets.only(
                                      right: 15.0,
                                      left: 15.0,
                                      top: 3.0,
                                      bottom: 3.0,
                                    ),
                                    child:edit ? Container(
                                          height: 100,
                                          color: Colors.grey.withOpacity(0.5),
                                          padding: EdgeInsets.all(10.0),
                                          child: new ConstrainedBox(
                                            constraints: BoxConstraints(
                                              maxHeight: 80.0,
                                              maxWidth: MediaQuery.of(context).size.width / 1.2,
                                            ),
                                            child: new SingleChildScrollView(
                                              scrollDirection: Axis.vertical,
                                              reverse: true,
                                              child: SizedBox(
                                                height: 100.0,
                                                child: new TextField(
                                                  style: TextStyle(color: Colors.black),
                                                  controller: _commentsController,
                                                  maxLines: 100,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ): Row(
                                                              children: <Widget>[

                                                                SizedBox(
                                                                  width: MediaQuery.of(context).size.width/7
                                                                ),
                                                                Flexible(
                                                                  child: Html(
                                                                data: "${review[0]['review']}",
                                                              ) ,
                                                                )
                                                              ],
                                                            )
                                  ),

                                 
          Padding(
              padding: EdgeInsets.only(
                right: 15.0,
                left: 15.0,
                top: 3.0,
                bottom: 3.0,
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                        color: Theme.of(context).accentColor,
                        child: Text(
                         edit?"Submit Review":"Edit Review",
                          style: TextStyle(fontFamily: "openSans", color: Colors.white),
                        ),
                        onPressed: () async {
                          setState(() {
                              if(edit){
                                if(new_review){
                                  submitReview();
                                }else{
                                  updateReview();
                                }
                              }else{
                                edit = true;
                              }
                          // edit? submitReview():
                          
                          });
                          
                        }),
                  ]))
                                  ]
                              ),
                                   //login,
                    )),
                        )   ,    //login,
                    

              ],
            )
        
        );
        
                } 
  
  



  }
