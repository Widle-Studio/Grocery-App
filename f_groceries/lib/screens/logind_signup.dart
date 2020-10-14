import 'dart:convert';

import 'package:f_groceries/Utils/constants.dart';
import 'package:f_groceries/Utils/woocommerce_api.dart';
import 'package:f_groceries/database/user/db_helper.dart';
import 'package:f_groceries/database/user/user.dart';
import 'package:f_groceries/screens/HomeScreen.dart';
import 'package:f_groceries/screens/forgot_password.dart';
import 'package:f_groceries/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Login_Screen extends StatefulWidget {


  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;


  const Login_Screen({Key key, this.fieldKey, this.hintText, this.labelText, this.helperText, this.onSaved, this.validator, this.onFieldSubmitted}) : super(key: key);

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
  State<StatefulWidget> createState() => login();
}

class login extends State<Login_Screen> {

  ShapeBorder shape;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _autovalidate = false;
  bool _formWasEdited = false;
  bool _loading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  final TextEditingController _emailControl = new TextEditingController();
  final TextEditingController _passwordControl = new TextEditingController();
  ProgressDialog _loading_info;

  
  WooCommerceAPI wc_api = WooCommerceAPI("${Constants.baseURL}",
      "${Constants.consumerKey}", "${Constants.consumerSecret}");

  var db = UserHelper();

  void storeUser(String username, String email, String password, String token, int userId, String login_method) async{
    int saveUser = await db.saveUser(
        User(
            username,
            email,
            password,
            token,
          userId,
        )
    );
    if(saveUser == 1){
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setBool("login",true);
      preferences.setString("login_method",login_method);
      preferences.setBool("notification",true);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context){
            return Home_screen();
          },
        ),
      );
    }else{
      print("something happened");
    }
  }

_submit() async{

    setState((){
      _loading = true;
    });
    if(_emailControl.text.isNotEmpty && _passwordControl.text.isNotEmpty){

      var res = await http.post(
          "${Constants.loginURL}",
          body: {
            "username": "${_emailControl.text}",
            "password": "${_passwordControl.text}"
          }
      );
      var decodedJson = jsonDecode(res.body);
      print(decodedJson);

      if(res.statusCode == 200 && decodedJson != null) {
        if (mounted) {

          var resid = await http.post(
            "${Constants.getIDURL}",
            body: {},
            headers: {
              "authorization": "${"Bearer "+decodedJson['token']}"
            }
          );

          int id = int.parse(resid.body);
          print("USERID $id");

          if(resid.statusCode == 200){
            storeUser(
              decodedJson['user_nicename'],
              decodedJson['user_email'],
              decodedJson['user_display_name'],
              decodedJson['token'],
              id,
              "email",
            );

            setState(() {
              _loading = false;
            });
          }else{

            print("COULDNT GET ID");
            setState(() {
              _loading = false;
            });
          }


          
          

        }
      }else{
        _showNotif(context, "Error",
            "${decodedJson['message']}");
        setState(() {
          _loading = false;
        });
      }

    }else{
      _showNotif(context, "Error", "Fill all fields");
    }


  }

  void _showNotif(BuildContext context, String title, String body){
    showDialog(
      context: context,
      builder: (context)=>
      
      AlertDialog(
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0))),
        title: Text(title),
        content: Html(
          data: body,
        ),

        actions: <Widget>[

          FlatButton(
            onPressed: (){
              setState(() {
                   _loading = false;
                });
              Navigator.of(context).pop();
              },
            child: Text("OK"),
          )
        ],
      ),
      
    );
  }


    bool _showForgotPassword(BuildContext context){
    showDialog(
      context: context,
      builder: (context)=>AlertDialog(
        title: Text("Forgot Password?", style: TextStyle(fontWeight: FontWeight.bold ),),
         shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0))),
        content: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Text("Enter your registered Email below, we will send you RESET link via Email.",style: TextStyle(color: Color(0xff0303a1)),),
             
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
            ],
          ),
        ),

        actions: <Widget>[
               
         
        ],
      ),
    );
  }

  
  Future<http.Response> getAsync() async {
    String email = _emailControl.text;
  var url = "https://imperialinfosys.com/grocery-app/api/forgot_password.php?login=$email";

    final response = await http.get(url);

    return response;
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

  String _validateName(String value) {
    _formWasEdited = true;
    if (value.isEmpty)
      return 'Name is required.';
    final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value))
      return 'Please enter only alphabetical characters.';
    return null;
  }

  checkIfDataExist(String email) async {
    
    int index = email.indexOf("@");
    email = email.substring(0, index);
    print("customers?search=$email");
    var res = await wc_api.getAsync("customers?search=$email");
    var decodedJson = jsonDecode(res.body);
    print(decodedJson.isEmpty);
    print(res.statusCode);
    print(decodedJson);
    if (res.statusCode == 200 && !decodedJson.isEmpty) {
      if (mounted) {
        print("here1");

        if (decodedJson[0]['email'] != null) {
          print("here2");
          print(decodedJson[0]);
          
          return decodedJson[0];
        }
      }
    } else {
      return null;
    }

  }

Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  _loading_info.show();
  if (user != null) {
          var customer = await checkIfDataExist(user.email);
          print(customer);
          if (customer == null) {
          int index = user.displayName.indexOf(" ");
          String first_name = user.displayName.substring(0,index);
          String last_name = user.displayName.substring(index+1, user.displayName.length);

          var res;
          if(user.phoneNumber!=null){
            res = await wc_api.postAsync(
            "customers",
              {
                "username": user.email,
                "email": user.email,
                "password": user.email,
                "first_name": first_name,
                "last_name": last_name,
                "billing": {"phone":user.phoneNumber},
              }
          );
          }else{
            res = await wc_api.postAsync(
            "customers",
              {
                "username": user.email,
                "email": user.email,
                "password": user.email,
                "first_name": first_name,
                "last_name": last_name,
              }
          );
          }
          customer = await checkIfDataExist(user.email);
          
  }else{
    _showNotif(context, "Error", "Please try again");
  }



        if (customer['email'] != null) {
        storeUser(
          customer['username'],
          customer['email'],
          customer['email'],
          googleSignInAuthentication.idToken,
          customer['id'],
          "google",
        );
      }

  _loading_info.hide();
  return 'signInWithGoogle succeeded: $user';
}else{
  _loading_info.hide();
  return null;
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
        key: scaffoldKey,
        appBar: new AppBar(
          title: Text('Login', style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: new SingleChildScrollView(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Container(
                  height: 50.0,
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 7.0),
                  child: new Row(
                    children: <Widget>[
                      _verticalD(),
                      new GestureDetector(
                        onTap: () {
                          /* Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => login_screen()));*/
                        },
                        child: new Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      _verticalD(),
                      new GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Signup_Screen()));
                        },
                        child: new Text(
                          'Signup',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black26,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                new SafeArea(

                    top: false,
                    bottom: false,
                    child: Card(
                        elevation: 5.0,
                        child: Form(
                            key: formKey,
                            autovalidate: _autovalidate,
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    const SizedBox(height: 24.0),
                                    TextFormField(
                                      controller: _emailControl,
                                      decoration: const InputDecoration(
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                          ),
                                          focusedBorder:  UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                          ),
                                          icon: Icon(Icons.email,color: Colors.black38,),
                                          hintText: 'Your email address',
                                          labelText: 'E-mail',
                                          labelStyle: TextStyle(color: Colors.black54)
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (val) =>
                                      !val.contains('@') ? 'Not a valid email.' : null,
                                      onSaved: (val) => _email = val,
                                    ),

                                    const SizedBox(height: 24.0),
                                    TextFormField(
                                      controller: _passwordControl,
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                          ),
                                          focusedBorder:  UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                          ),
                                          icon: Icon(Icons.lock,color: Colors.black38,),
                                          hintText: 'Your password',
                                          labelText: 'Password',
                                          labelStyle: TextStyle(color: Colors.black54)
                                      ),

                                      validator: (val) =>
                                      val.length < 6 ? 'Password too short.' : null,
                                      onSaved: (val) => _password = val,
                                    ),

                                    SizedBox(height: 35.0,),
                                    new Container(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[

                                          new Container(
                                            alignment: Alignment.bottomLeft,
                                            margin: EdgeInsets.only(left: 10.0),
                                            child: new GestureDetector(
                                              onTap: (){
                                                      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return ForgotPassword();
          },
        ),
      );
     
                                              },
                                              child: Text('FORGOT PASSWORD?',style: TextStyle(
                                                  color: Colors.blueAccent,fontSize: 13.0
                                              ),),
                                            ),
                                          ),
                                          new Container(
                                            alignment: Alignment.bottomRight,
                                            child: _loading?Center(
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
                                        ),
                                      ): new GestureDetector(
                                              onTap: () async {
                                                  _submit();
                                                // await FirebaseAuth.instance.signOut();

                                              },
                                              child: Text('LOGIN',style: TextStyle(
                                                  color: Colors.orange,fontSize: 20.0,fontWeight: FontWeight.bold
                                              ),),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    /*   const SizedBox(height:24.0),

                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[

                                new GestureDetector(
                                  onTap: (){

                                  },
                                  child: Text('FORGOT PASSWORD?',style: TextStyle(
                                    color: Colors.blueAccent,fontSize: 13.0
                                  ),),
                                ),

                                new GestureDetector(
                                  onTap: (){

                                  },
                                  child: Text('LOGIN',style: TextStyle(
                                      color: Colors.orange,fontSize: 15.0
                                  ),),
                                ),

                              ],
                            )


*/
                                  ]
                              ),
                            )

                        )        //login,
                    )),
                  Divider(),
                  Center(
                    child: Text("OR"),
                  ),
                  Divider(),
                    OutlineButton(
      splashColor: Colors.grey,
      onPressed: () async {
            signInWithGoogle().whenComplete(() async {
      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (context) {
      //       return FirstScreen();
      //     },
      //   ),
      // );
      print("done");

    });

          
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("images/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    ),
              ],
            ),
          )
        ));
  }



  void showInSnackBar(String value) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(value)
    ));
  }


  _verticalD() => Container(
        margin: EdgeInsets.only(left: 10.0, right: 0.0, top: 0.0, bottom: 0.0),
      );

  }
