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
import 'package:f_groceries/screens/write_review.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ReviewScreen extends StatefulWidget {


  final int id;


  const ReviewScreen({Key key, this.id, }) : super(key: key);

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
  State<StatefulWidget> createState() => reviewScreen();
}

class reviewScreen extends State<ReviewScreen> {

  ProgressDialog _loading_info;
  final TextEditingController _emailControl = new TextEditingController();
  List reviewList;
  bool reviews_loading;

  WooCommerceAPI wc_api = WooCommerceAPI("${Constants.baseURL}",
      "${Constants.consumerKey}", "${Constants.consumerSecret}");






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

  getReviews() async {
        setState(() {
      reviews_loading = true;
    });
    print("products/reviews?product=${widget.id}");
    var res = await wc_api
        .getAsync("products/reviews?product=${widget.id}");
    var decodedJson = jsonDecode(res.body);
    print("Feat GETRAW ${res.body}");
    print("Feat GET$decodedJson");

    if (res.statusCode == 200 && decodedJson != null) {
      if (mounted) {
        setState(() {
          reviewList = decodedJson;
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReviews();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: new AppBar(
          title: Text('Reviews', style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
                actions: <Widget>[
          // IconButton(
          //   tooltip: 'review',
          //   icon: const Icon(Icons.rate_review,color: Colors.black,),
          //   onPressed: () async {
          //     await  Navigator.push(context, MaterialPageRoute(builder: (context)=>WriteReview(key: UniqueKey() ,id: widget.id)));
          //     getReviews();

          //   },
          // ),
          ],
        ),
        body: reviews_loading
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).accentColor),
                ),
              )
            : reviewList.length == 0?
            Center(
              child: Text("No reviews yet!")
            ): ListView.builder(
                itemCount: reviewList.length,
                itemBuilder: (BuildContext cont, int index) {
                  return  new ListView(
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
                      reviewList[index]['reviewer_avatar_urls']['96'],
                    ),
                        ),

  
                        Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(
                              reviewList[index]['reviewer'],
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
                      // onRatingChanged: (v) {
                      //   setState(() {
                      //     rating[index] = v;
                      //   });
                      // },
                      starCount: 5,
                      rating: double.parse(reviewList[index]['rating'].toString()) ,
                      size: 25.0,
                      color: Theme.of(context).accentColor,
                      borderColor: Constants.bG,
                      spacing: 0.0,
                    ),
                                      ],
                                    ),

                                    Row(
                                      children: <Widget>[

                                        SizedBox(
                                          width: MediaQuery.of(context).size.width/7
                                        ),
                                        Flexible(
                                          child: Html(
                                        data: "${reviewList[index]['review']}",
                                      ) ,
                                        )
                                      
                                      
                                      
                      
                     
                                      ],
                                    )
                                      
                                  

                                  ]
                              ),
                                   //login,
                    )),
                        )   ,    //login,
                    

              ],
            )
          ;
          }
        )
        );
        
                } 
  
  



  }
