import 'dart:convert';
import 'dart:io';

import 'package:f_groceries/Utils/constants.dart';
import 'package:f_groceries/Utils/woocommerce_api.dart';
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

class ForgotPassword extends StatefulWidget {


  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;


  const ForgotPassword({Key key, this.fieldKey, this.hintText, this.labelText, this.helperText, this.onSaved, this.validator, this.onFieldSubmitted}) : super(key: key);

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
  State<StatefulWidget> createState() => forgotPassword();
}

class forgotPassword extends State<ForgotPassword> {

  ProgressDialog _loading_info;
  final TextEditingController _emailControl = new TextEditingController();

  WooCommerceAPI wc_api = WooCommerceAPI("${Constants.baseURL}",
      "${Constants.consumerKey}", "${Constants.consumerSecret}");





  Future<http.Response> getAsync() async {
    String email = _emailControl.text;
  var url = "https://imperialinfosys.com/grocery-app/api/forgot_password.php?login=$email";

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

  sendEmail(BuildContext context) async {
    _loading_info.show();
    http.Response res = await getAsync();
    var decodedJson = jsonDecode(res.body);
    print("Feat GETRAW ${res.body}");
    print("Feat GET$decodedJson");

    print(decodedJson['code'].runtimeType);
    if(decodedJson['code'] == "200"){
      _loading_info.hide();
      _showNotif(context, "Email sent!", decodedJson['msg']);
    }else{
      _loading_info.hide();
      _showNotif(context, "Error", decodedJson['msg']);
    }
    
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    _loading_info = new ProgressDialog(context,type: ProgressDialogType.Normal);
    _loading_info.style(
          message: 'Loading...',
          // borderRadius: 10.0,
          backgroundColor: Colors.white,
          progressWidget:  Container(
            padding: EdgeInsets.all(15.0),
                     height: 40,width: 40, child: CircularProgressIndicator()),
          
           insetAnimCurve: Curves.bounceIn,
          // messageTextStyle: TextStyle(
          //     color: Colors.white.withOpacity(0.6), fontSize: 16.0,),
        );
    bool _obscureText = true;
    return new Scaffold(
        appBar: new AppBar(
          title: Text('Reset Password', style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
        ),
        body:  Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 50),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Text("Enter your registered Email below, we will send you RESET link via Email.",style: TextStyle(color: Color(0xff0303a1), fontSize: 15),),
             
              TextFormField(
                                      controller: _emailControl,
                                      decoration: const InputDecoration(
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                          ),
                                          focusedBorder:  UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                          ),
                                          labelText: 'E-mail',
                                          labelStyle: TextStyle(color: Colors.black54)
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (val) =>
                                      !val.contains('@') ? 'Not a valid email.' : null,
                                    ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                     
            new FlatButton(
              //onPressed: () => Navigator.of(context).pop(true),
              onPressed: () {
                sendEmail(context);
              },
              child: new Text('SUBMIT', style: TextStyle(color:Theme.of(context).accentColor, fontWeight: FontWeight.bold, fontSize: 20),),
            ),
              ],)
            ],
          ),
        ),);
  }



  }
