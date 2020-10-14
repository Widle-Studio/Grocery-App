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
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class WriteReview extends StatefulWidget {
  final List<dynamic> productList;
  final List<dynamic> metadata;
 

  const WriteReview({Key key, this.productList,this.metadata}) : super(key: key);

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

  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  AnimationController expandController;
  Animation<double> animation; 
  
  User user;
  var user_list;
  var userdb = UserHelper();
  List rating = [];
  List view_comment_editor = [];
  List comment_controller = [];
  bool edit = false;
  bool new_review = true;
  int review_id;
  bool _reviewed = false;
  List rated = [];
  List product_id_list = [];

  List<FocusNode> nodeOne = List<FocusNode>();
  

//   Future<http.Response> getAsync(int id, String email) async {
//   String email = _emailControl.text;
// var url = "https://imperialinfosys.com/grocery-app/wp-json/wc/v3/products/reviews?product=${widget.id}&reviewer_email=${user.email}&consumer_key=ck_742e8cb6f82ad59628fb8a2a9dde0fbb9ddba5c0&consumer_secret=cs_64994bcbf7e73ff726788de1d0ddfbc523dc0c4a";

//   final response = await http.get(url);

//   return response;
// }


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

  checkReviews() async {
      print(widget.productList);

      for(var i=0;i<widget.metadata.length;i++){
        if(widget.metadata[i].key == "Review"){
          _reviewed = true;
          break;
        } 
      }
  }

    Future<http.Response> getAsync(String email) async {
  String email = _emailControl.text;
var url = "https://imperialinfosys.com/grocery-app/wp-json/wc/v3/products/reviews?reviewer_email=${user.email}&consumer_key=ck_742e8cb6f82ad59628fb8a2a9dde0fbb9ddba5c0&consumer_secret=cs_64994bcbf7e73ff726788de1d0ddfbc523dc0c4a";

  final response = await http.get(url);

  return response;
}

    checkReview() async {
     setState(() {
      reviews_loading = true;
    });

    user = await userdb.getUser(1); 
    var res = await wc_api
    .getAsync("customers/${user.userId}");

    var decodedJson = jsonDecode(res.body);
    setState(() {
      user_list = decodedJson;
    });


    res = await getAsync(user.email);
    decodedJson = jsonDecode(res.body);
    print("Feat GETRAW ${res.body}");
    print("Feat GET$decodedJson");

    if (res.statusCode == 200 && decodedJson != null) {
      if (mounted) {
        setState(() {
          review = decodedJson;
          print(review.length);



        rated = [];
        rating = [];
        comment_controller = [];
        view_comment_editor = [];
        product_id_list = [];
        nodeOne = [];

        for(var i=0;i<widget.productList.length;i++){
          rating.add(0.0);
          view_comment_editor.add(false);
          comment_controller.add(new TextEditingController());
          rated.add(false);
          product_id_list.add(widget.productList[i]['product_id']);
          nodeOne.add(new FocusNode());
        }

        for(var i=0;i<review.length;i++){
          print(product_id_list);
          if(product_id_list.contains(review[i]['product_id'])){
            int index =  product_id_list.indexOf(review[i]['product_id']);
            print(index);
            rated[index] = true;
            rating[index] = review[i]['rating'].toDouble();
            comment_controller[index].text = _parseHtmlString(review[i]['review']) == "null\n"?"":_parseHtmlString(review[i]['review']);
            // view_comment_editor[index] = true;
          }
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
    setState(() {
      reviews_loading = true;
    });
    

    List review_list_new = [];
    List review_list_update = [];
    
      for(var i=0;i<review.length;i++){
      print(product_id_list);
      if(product_id_list.contains(review[i]['product_id'])){
        int index =  product_id_list.indexOf(review[i]['product_id']);
        print(comment_controller[index].text);
        String review_line = comment_controller[index].text.replaceAll("\n","");
        review_list_update.add(
          { "id": review[i]['id'], "rating": rating[index], "review": "$review_line"}
        );
      }
    }

    String name = user_list['first_name'] + " " + user_list['last_name'];
 

      for(var i=0;i<product_id_list.length;i++){
      String review_line = comment_controller[i].text == "" ? "null": comment_controller[i].text;
      if(!rated[i]){
        if(rating[i] != 0.0){
          review_list_new.add(
          {"product_id": product_id_list[i],"reviewer": '"$name"',"reviewer_email": "${user.email}", "review": "$review_line","rating": rating[i]}
        );
        }
        
      }
    }


  print(review_list_new);


  var data = {
    "create": review_list_new,
    "update": review_list_update,
   
};
print("${data.toString()}");
  var res = await wc_api.putAsync(
        "products/reviews/batch", 
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

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _commentsController = new TextEditingController();
    checkReview();
    // prepareAnimations();
   

      
      
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
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: widget.productList.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child:  Padding(
            padding: EdgeInsets.only(
              right: 10.0,
              left: 10.0,
              top: 10.0,
              bottom: 10.0,
            ),  child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Text(widget.productList[index]['name'],style: TextStyle(color: Colors.black.withOpacity(0.8), fontSize: 25),),
                    Divider(),
                    Center(
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                           SmoothStarRating(
                      allowHalfRating: false,
                      onRatingChanged: (v) {
                        print("here");
                        setState(() {
                          if(rated[index] && !view_comment_editor[index]){

                          }else{
                             rating[index] = v;
                          if(!view_comment_editor[index]){
                              view_comment_editor[index] = true;
                            }
                          }
                         
                        });
                      },
                      starCount: 5,
                      rating:  rating[index],
                      size: 35.0,
                      color: Colors.green,
                      borderColor: Colors.grey[400],
                      spacing: 20.0,
                    ) ,

                    !rated[index] || view_comment_editor[index]? Container():
                    IconButton(icon: Icon(
                      Icons.edit
                    ), onPressed: (){
                      setState(() {
                        // rated[index] = false;
                        view_comment_editor[index] = true;
                        comment_controller[index].text = _parseHtmlString(comment_controller[index].text);
                        FocusScope.of(context).requestFocus(nodeOne[index]);
                      });
                      
                    })
                    
                        ],
                      )
                      
                    ),
                    Divider(),
                       AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: !view_comment_editor[index]? 0.0 : 60.0,
                      curve: Curves.easeIn,
                      child: Container(
                                          // height: 100,
                                          // color: Colors.grey.withOpacity(0.5),
                                          padding: EdgeInsets.all(5.0),
                                          child: new ConstrainedBox(
                                            constraints: BoxConstraints(
                                              // maxHeight: 80.0,
                                              maxWidth: MediaQuery.of(context).size.width / 1.2,
                                            ),
                                            child: new SingleChildScrollView(
                                              scrollDirection: Axis.vertical,
                                              reverse: true,
                                              child:  new TextField(
                                                focusNode: nodeOne[index],
                                                  style: TextStyle(color: Colors.black),
                                                  controller: comment_controller[index],
                                                  
                                                  maxLines: null,
                                                  decoration: const InputDecoration(
                                            
                                            hintText: 'Your Comments(optional)',
                                        ),
                                                ),
                                              
                                            ),
                                          ),
                                        )
                     ),
                     
                     view_comment_editor[index]?Container()
                     : Container(
                  // padding: const EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0.0),
                  child:                                      Html(
                                        data: comment_controller[index].text,
                                      ),
                    ),

                          
                  ],
                ),
                
                )
                );
              },
//              physics: NeverScrollableScrollPhysics(),
            ),

            Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                       child: Stack( 
                         children: <Widget>[
                          FlatButton(
            color: !view_comment_editor.contains(true)?Theme.of(context).accentColor.withOpacity(0.5):Theme.of(context).accentColor,
            shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15.0),
    
  ),
            onPressed: (){
            !view_comment_editor.contains(true)?null: submitReview();
                       
            },
            child: Text('SUBMIT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          ),

          // !view_comment_editor.contains(true)
          //                       ? Container(
          //                           height: 100,
          //                           color: Colors.black.withOpacity(0.1),
          //                         )
          //                       : Container(),
                                
                                ]
                       )
                      
                      ),
                    ),
              ],
            )
             
          
         
        
        );
        
                } 

         
  
  //   void prepareAnimations() {
  //   expandController = AnimationController(
  //     vsync: Ticker,
  //     duration: Duration(milliseconds: 500)
  //   );
  //   animation = CurvedAnimation(
  //     parent: expandController,
  //     curve: Curves.fastOutSlowIn,
  //   );
  // }


  String _parseHtmlString(String htmlString) {

var document = parse(htmlString);

String parsedString = parse(document.body.text).documentElement.text;
parsedString.replaceAll("\n", "");
return parsedString;
}

  }
