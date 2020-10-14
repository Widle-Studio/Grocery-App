import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_groceries/Objects/profile.dart' as profile;
import 'package:f_groceries/Objects/profile.dart';
import 'package:f_groceries/Objects/profile.dart';
import 'package:f_groceries/Utils/constants.dart';
import 'package:f_groceries/Utils/woocommerce_api.dart';
import 'package:f_groceries/database/user/db_helper.dart';
import 'package:f_groceries/database/user/user.dart';
import 'package:f_groceries/screens/logind_signup.dart';
import 'package:f_groceries/screens/pop_up_menu.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:f_groceries/model/Address_model.dart';
import 'package:f_groceries/services/address_services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show TargetPlatform;
import 'dart:io' as file;


class Account_Screen extends StatefulWidget {
  final Profile profile;

  Account_Screen({
    Key key,
    @required this.profile,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => account();
}

enum AppState {
  free,
  picked,
  cropped,
}

class account extends State<Account_Screen> {
  WooCommerceAPI wc_api = WooCommerceAPI("${Constants.baseURL}",
      "${Constants.consumerKey}", "${Constants.consumerSecret}");

  bool _loadingAccount = false;
  var userdb = UserHelper();
  User user;

  bool address_set = false;
  bool _loading_addresses = false;
  Profile profile;
  String login_method;
  bool _loadingPassword = false;
  bool password_validate = true;
  bool _loading_photo = false;
  String errorText = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final databaseReference = Firestore.instance;
  List addresses = List();

  String first_name;
  String last_name;
  String email;
  String phone;
  bool _loading_profile = false;
  String avatar_url ;

  AppState state;
  file.File imageFile;
  StorageReference storageReference = FirebaseStorage.instance.ref().child("images");


  final TextEditingController _firstnameControl = new TextEditingController();
  final TextEditingController _lastnameControl = new TextEditingController();
  final TextEditingController _address1Control = new TextEditingController();
  final TextEditingController _address2Control = new TextEditingController();
  final TextEditingController _cityControl = new TextEditingController();
  final TextEditingController _pincodeControl = new TextEditingController();
  final TextEditingController _phoneControl = new TextEditingController();
  final TextEditingController _currentControl = new TextEditingController();
  final TextEditingController _newControl = new TextEditingController();
  final TextEditingController _newConfirmControl = new TextEditingController();
  final TextEditingController _firstnameControl_edit = new TextEditingController();
  final TextEditingController _lastnameControl_edit = new TextEditingController();
  final TextEditingController _emailControl_edit = new TextEditingController();
  final TextEditingController _phoneControl_edit = new TextEditingController();

  deactivateAccount() async {
    print("here");
    setState(() {
      _loadingAccount = true;
    });
    var data = {"force": true};
    var res = await wc_api.delete("customers/${widget.profile.id}", data);
    if (res.statusCode == 200) {
      setState(() {
        _loadingAccount = false;
      });

      int del = await userdb.deleteUser(1);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setBool("login", false);

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return Login_Screen();
          },
        ),
      );
    } else {
      setState(() {
        _loadingAccount = false;
      });
    }
  }

deleteOrderHistory() async {
    // setState(() {
    //   _loadingOrder = true;
    // });
    // var data = {"force": true};
    // var res = await wc_api.delete("customers/${widget.profile.id}", data);
    // if (res.statusCode == 200) {
    //   setState(() {
    //     _loadingOrder = false;
    //   });

    //   int del = await userdb.deleteUser(1);
    //   SharedPreferences preferences = await SharedPreferences.getInstance();
    //   preferences.setBool("login", false);

    //   Navigator.of(context).push(
    //     MaterialPageRoute(
    //       builder: (BuildContext context) {
    //         return Login_Screen();
    //       },
    //     ),
    //   );
    // } else {
    //   setState(() {
    //     _loadingOrder = false;
    //   });
    // }
  }

  void confirmDeactivation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        // backgroundColor:  Theme.of(context).backgroundColor,
        title: new Text('Are you sure?'),
        content: new Text('Do you want to delete the account'),
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
            onPressed: () => deactivateAccount(),
            child: new Text('Yes'),
          ),
        ],
      ),
    );
  }

    void confirmHistoryDeletion(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        // backgroundColor:  Theme.of(context).backgroundColor,
        title: new Text('Are you sure?'),
        content: new Text('Do you want to delete the order history?'),
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
            onPressed: () => deleteOrderHistory(),
            child: new Text('Yes'),
          ),
        ],
      ),
    );
  }


Future<http.Response> getAsync() async {
  String current = _currentControl.text;
   String newP = _newControl.text;
  


var url = "https://imperialinfosys.com/grocery-app/api/change_password.php?user_id=${widget.profile.id}&password=$current&new_password=$newP&consumer_key=ck_742e8cb6f82ad59628fb8a2a9dde0fbb9ddba5c0&consumer_secret=cs_64994bcbf7e73ff726788de1d0ddfbc523dc0c4a";

  final response = await http.get(url);

  return response;
}

resetPassword(StateSetter setState) async {

  setState(() {
    _loadingPassword = true;
  });
  if(_newConfirmControl.text == _newControl.text){
    
        setState(() {
          password_validate = true;
      
    });
    http.Response res = await getAsync();
    var decodedJson = jsonDecode(res.body);
    print("Feat GETRAW ${res.body}");
    print("Feat GET$decodedJson");

    print(decodedJson['code'].runtimeType);
    if(decodedJson['code'] == 200){

      setState(() {
      _loadingPassword = false;
      errorText = "";
    });
     return true;
    }else{
      setState(() {
      _loadingPassword = false;
      errorText = decodedJson['msg'];
    });
    return false;
    }
  }else{
    print("here");
    setState(() {
      _loadingPassword = false;
      password_validate = false;
      
    });
    return false;
  }
  }

updateAddress(int index) async {

  int i = 0;
  String document_id;

  setState(() {
    _loading_addresses = true;
  });  

  
  if(index == 0){
      await databaseReference
      .collection("users")
      .document(user.email)
      .collection("addresses")
      .add(
        
        {
              "first_name": _firstnameControl.text,
              "last_name": _lastnameControl.text,
              "address_1": _address1Control.text,

              "address_2": _address2Control.text,
              "city": _cityControl.text,
              "state": "",
              "phone": _phoneControl.text,
              "postcode": _pincodeControl.text,
              "country": ""
        }
        
        ).then((_) {
      print("success!");
    });
  }else{
      await databaseReference
      .collection("users")
      .document(user.email)
      .collection("addresses")
      .getDocuments()
      .then((QuerySnapshot snapshot) {
    snapshot.documents.forEach((f)
    {
     print('${f.data}}');
     addresses.add(f);

     if(i==index){
       document_id = f.documentID;
     }
     i++;
    }

     );
    
  });

  await databaseReference
      .collection("users")
      .document(user.email)
      .collection("addresses")
      .document(document_id)
      .updateData(
        
        {
              "first_name": _firstnameControl.text,
              "last_name": _lastnameControl.text,
              "address_1": _address1Control.text,

              "address_2": _address2Control.text,
              "city": _cityControl.text,
              "state": "",
              "phone": _phoneControl.text,
              "postcode": _pincodeControl.text,
              "country": ""
        }
        
        ).then((_) {
      print("success!");
    });
  }



    setState(() {
    _loading_addresses = false;
    getPreviousAddress();
  });  

  }

  addAddress() async {


  setState(() {
    _loading_addresses = true;
  });  
  
        await databaseReference
      .collection("users")
      .document(user.email)
      .collection("addresses")
      .add(
        
        {
              "first_name": _firstnameControl.text,
              "last_name": _lastnameControl.text,
              "address_1": _address1Control.text,

              "address_2": _address2Control.text,
              "city": _cityControl.text,
              "state": "",
              "phone": _phoneControl.text,
              "postcode": _pincodeControl.text,
              "country": ""
        }
        
        ).then((_) {
          setState(() {
    _loading_addresses = false;
    getPreviousAddress();
  });  
    });


  }

  deleteAddress(int index) async {

  int i = 0;
  String document_id;

  setState(() {
    _loading_addresses = true;
  });  
  await databaseReference
      .collection("users")
      .document(user.email)
      .collection("addresses")
      .getDocuments()
      .then((QuerySnapshot snapshot) {
    snapshot.documents.forEach((f)
    {
     print('${f.data}}');
     addresses.add(f);

     if(i==index){
       document_id = f.documentID;
     }
     i++;
    }

     );
    
  });

  databaseReference
      .collection("users")
      .document(user.email)
      .collection("addresses")
      .document(document_id)
      ..delete().then((_) {
    print("success!");
  });


    setState(() {
    _loading_addresses = false;
    getPreviousAddress();
  });  

  }

  

  getUserLocationFromCoordinates() async {
    //call this async method from whereever you need

    GeolocationStatus geolocationStatus =
        await Geolocator().checkGeolocationPermissionStatus();

    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);

    setState(() {
      _cityControl.text = addresses.first.locality;
      _pincodeControl.text = addresses.first.postalCode;
      _address1Control.text = addresses.first.featureName;
      _address2Control.text = addresses.first.subLocality;
    });
    // print(addresses);
    // print(addresses.first.locality);
    //  print(addresses.first.subLocality);
    //   print(addresses.first.addressLine);
    //    print(addresses.first.countryName);
    //     print(addresses.first.featureName);
    //      print(addresses.first.adminArea);
    //       print(addresses.first.postalCode);
    //       print(addresses.first.subAdminArea);
  }

  _showChangePassword(BuildContext context) {
    showDialog(
      context: context,
      builder: (context){ return AlertDialog(
        title: Text(
          "Change Password",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        content:StatefulBuilder(  // You need this, notice the parameters below:
        builder: (BuildContext context, StateSetter setState) {
          return  Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              TextFormField(
                controller: _currentControl,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black87, style: BorderStyle.solid),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black87, style: BorderStyle.solid),
                    ),
                    labelText: 'CURRENT PASSWORD',
                    errorText: errorText==""?null:errorText,
                    labelStyle: TextStyle(color: Colors.black54)),
                
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
              ),
              TextFormField(
                controller: _newControl,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black87, style: BorderStyle.solid),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black87, style: BorderStyle.solid),
                    ),
                    labelText: 'NEW PASSWORD',
                    labelStyle: TextStyle(color: Colors.black54)),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
              ),
              TextFormField(
                controller: _newConfirmControl,
                decoration:InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black87, style: BorderStyle.solid),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black87, style: BorderStyle.solid),
                    ),
                    labelText: 'CONFIRM NEW PASSWORD',
                    errorText: password_validate == false?  "Password does not match!":null,
                    labelStyle: TextStyle(color: Colors.black54)),

                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  
                  
                  new FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: new Text(
                      'CANCEL',
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          
                          fontSize: 15),
                    ),
                  ),

                    _loadingPassword? Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                                Color>(
                                                            Theme.of(context)
                                                                .accentColor),
                                                  ),
                                                ):
                    new FlatButton(
                    onPressed: () async {

                    bool value = await  resetPassword(setState);
                    
                    if(value){
                      Navigator.of(context).pop();
                       _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text('Password reset Successful.')
                            ));
                      }
                    },
                    child: new Text(
                      'SUBMIT',
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
        },
        ),
        actions: <Widget>[],
      );
  }
    );
  }

  // getPreviousAddress() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool login =
  //       prefs.getBool("login") == null ? false : prefs.getBool("login");
  //   login_method = prefs.getString("login_method") == null
  //       ? ""
  //       : prefs.getString("login_method");

  //   if (widget.profile.firstName != "") {
  //     setState(() {
  //       _firstnameControl.text = widget.profile.firstName;
  //       _lastnameControl.text = widget.profile.lastName;
  //       _address1Control.text = widget.profile.billing.address1;
  //       _address2Control.text = widget.profile.billing.address2;
  //       _cityControl.text = widget.profile.billing.city;
  //       _pincodeControl.text = widget.profile.billing.postcode;
  //       _phoneControl.text = widget.profile.billing.phone;
  //       _loading_addresses = false;
  //       address_set = true;
  //     });
  //   }
  // }

  getPreviousAddress() async {
    _loading_addresses = true;
    user = await userdb.getUser(1);
    setState(() {
      user = user;
    });

    // if (user == null) {
    //   //_showAlert(context, "Sign In !", "You are not signed in");
    // } else {
    //   setState(() {});
    //   var res = await wc_api.getAsync("customers/${user.userId}");
    //   var decodedJson = jsonDecode(res.body);

    //   if (res.statusCode == 200 && decodedJson != null) {
    //     if (mounted) {
    //       setState(() {
    //         profile = Profile.fromJson(decodedJson);
    //         if(profile.firstName!=""){
    //                       _firstnameControl.text = profile.firstName;
    //                       _lastnameControl.text = profile.lastName;
    //                       _address1Control.text = profile.billing.address1;
    //                       _address2Control.text = profile.billing.address2;
    //                       _cityControl.text = profile.billing.city;
    //                       _pincodeControl.text = profile.billing.postcode;
    //                       _phoneControl.text = profile.billing.phone;
    //                       _loading_addresses = false;
    //                       address_set = true;
    //         }

    //       });
    //     }
    //   } else {
    //     if (mounted) {
    //       setState(() {
    //         _loading_addresses = false;
    //       });
    //     }
    //   }
    // }

    
     addresses = [];
     await databaseReference
      .collection("users")
      .document(user.email)
      .collection("addresses")
      .getDocuments()
      .then((QuerySnapshot snapshot) {
    snapshot.documents.forEach((f)
    {
     print('${f.data}}');
     addresses.add(f);
    }

     );
    
  });
    setState(() {
      _loading_addresses = false;
    });

  }

  openAddressForm(BuildContext context, int index) {
    var alert = new AlertDialog(
        content: ListView(
          shrinkWrap: true,
          // physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: OutlineButton(
                  borderSide: BorderSide(color: Theme.of(context).accentColor),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(
                          Icons.gps_fixed,
                          color: Theme.of(context).accentColor,
                        ),
                        Text(
                          "Use My Current Location",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  textColor: Theme.of(context).accentColor,
                  onPressed: () {
                    getUserLocationFromCoordinates();
                  },
                  shape: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  )),
            ),
            TextFormField(
              textCapitalization: TextCapitalization.words,
              controller: _firstnameControl,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black87, style: BorderStyle.solid),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black87, style: BorderStyle.solid),
                  ),
                  hintText: 'First name',
                  labelStyle: TextStyle(color: Colors.black54)),
              keyboardType: TextInputType.text,
            ),
            TextFormField(
              textCapitalization: TextCapitalization.words,
              controller: _lastnameControl,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black87, style: BorderStyle.solid),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black87, style: BorderStyle.solid),
                  ),
                  hintText: 'Last name',
                  labelStyle: TextStyle(color: Colors.black54)),
              keyboardType: TextInputType.text,
            ),
            TextFormField(
              textCapitalization: TextCapitalization.sentences,
              controller: _address1Control,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black87, style: BorderStyle.solid),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black87, style: BorderStyle.solid),
                  ),
                  hintText: 'Address Line 1',
                  labelStyle: TextStyle(color: Colors.black54)),
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
                textCapitalization: TextCapitalization.sentences,
                controller: _address2Control,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black87, style: BorderStyle.solid),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black87, style: BorderStyle.solid),
                    ),
                    hintText: 'Address Line 2',
                    labelStyle: TextStyle(color: Colors.black54)),
                keyboardType: TextInputType.text),
            TextFormField(
              textCapitalization: TextCapitalization.words,
              controller: _cityControl,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black87, style: BorderStyle.solid),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black87, style: BorderStyle.solid),
                  ),
                  hintText: 'City',
                  labelStyle: TextStyle(color: Colors.black54)),
            ),
            TextFormField(
              controller: _pincodeControl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black87, style: BorderStyle.solid),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black87, style: BorderStyle.solid),
                  ),
                  hintText: 'Pincode',
                  labelStyle: TextStyle(color: Colors.black54)),
            ),
            TextFormField(
              controller: _phoneControl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black87, style: BorderStyle.solid),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black87, style: BorderStyle.solid),
                  ),
                  hintText: 'Phone number',
                  labelStyle: TextStyle(color: Colors.black54)),
            ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              // if (_firstnameControl.text.isEmpty ||
              //     _lastnameControl.text.isEmpty) {
              // } else {
                
              // }

              if(index == 0){
                addAddress();
              }else{
                updateAddress(index);
              }
              
              Navigator.pop(context);
            },
            child: Text("OK"),
          )
        ]);

    showDialog(
        context: context,
        builder: (context) => Center(
              // Aligns the container to center
              child: alert,
            ));
  }

  showProfileEditForm(BuildContext context) {

      showDialog(
      context: context,
      builder: (context){ return AlertDialog(
        title: Text(
          "Update Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        content:StatefulBuilder(  // You need this, notice the parameters below:
        builder: (BuildContext context, StateSetter setState) {
          return  Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              TextFormField(
                controller: _firstnameControl_edit,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black87, style: BorderStyle.solid),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black87, style: BorderStyle.solid),
                    ),
                    labelText: 'FIRST NAME',
                    errorText: errorText==""?null:errorText,
                    labelStyle: TextStyle(color: Colors.black54)),
                
                keyboardType: TextInputType.visiblePassword,
              ),
              TextFormField(
                controller: _lastnameControl_edit,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black87, style: BorderStyle.solid),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black87, style: BorderStyle.solid),
                    ),
                    labelText: 'LAST NAME',
                    labelStyle: TextStyle(color: Colors.black54)),
                keyboardType: TextInputType.visiblePassword,
              ),
             

              TextFormField(
              controller: _emailControl_edit,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black87, style: BorderStyle.solid),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black87, style: BorderStyle.solid),
                  ),
                  hintText: 'EMAIL',
                  labelStyle: TextStyle(color: Colors.black54)),
              keyboardType: TextInputType.emailAddress,
            ),
           
            TextFormField(
              controller: _phoneControl_edit,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black87, style: BorderStyle.solid),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black87, style: BorderStyle.solid),
                  ),
                  hintText: 'PHONE NUMBER',
                  labelStyle: TextStyle(color: Colors.black54)),
            ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  
                  
                  new FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: new Text(
                      'CANCEL',
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          
                          fontSize: 15),
                    ),
                  ),

                    _loading_profile? Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                                Color>(
                                                            Theme.of(context)
                                                                .accentColor),
                                                  ),
                                                ):
                    new FlatButton(
                    onPressed: () async {

                      bool value = false;
                                    if (_firstnameControl_edit.text.isEmpty ||
                  _lastnameControl_edit.text.isEmpty) {

                     
              } else {
              value = await updateProfile(setState,_firstnameControl_edit.text, _lastnameControl_edit.text, _phoneControl_edit.text, _emailControl_edit.text);
              }

                    
                    if(value){
                      Navigator.of(context).pop();
                       _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text('Profile Update Successful.')
                            ));
                      }
                    },
                    child: new Text(
                      'SUBMIT',
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
        },
        ),
        actions: <Widget>[],
      );
  }
    );
  }

  updateProfile(StateSetter setState,String first_name_local, String last_name_local, String phone_local, String email_local) async {
       setState(() {
         _loading_profile = true;
       });

  var  data = {
    "first_name": first_name_local,
    "last_name": last_name_local,
    "email": email_local,
    
    "billing": {
        "first_name": first_name_local,
        "last_name": last_name_local,
        "phone": phone_local
    }
};


          var res = await wc_api.postAsync(
          "customers/${widget.profile.id}",
          data
        );

      print(res.statusCode);
      if (res.statusCode == 200) {
        setState(() {
          
          _loading_profile = false;
        });
        this.setState(() {
          first_name = first_name_local;
          last_name = last_name_local;
          email = email_local;
          phone = phone_local;
        });
        return true;
      }else{
        setState(() {
          _loading_profile = false;
        });
        return false;
      }

       
  }
    void showMenuSelection(String value) {
    print(value);
  }



  edit_address(BuildContext context, int index){

    setState(() {
      
        _firstnameControl.text = addresses[index]['first_name'];
        _lastnameControl.text =  addresses[index]['last_name'];
        _address1Control.text =  addresses[index]['address_1'];
        _address2Control.text =  addresses[index]['address_2'];
        _cityControl.text =  addresses[index]['city'];
        _pincodeControl.text = addresses[index]['postcode'];
        _phoneControl.text =  addresses[index]['phone'];
    });
    openAddressForm(context,index);
  }

    Widget _buildButtonIcon() {
    if (state == AppState.free)
      return Icon(Icons.add);
    else if (state == AppState.picked)
      return Icon(Icons.crop);
    else if (state == AppState.cropped)
      return Icon(Icons.clear);
    else
      return Container();
  }

    Future<Null> _pickImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = file.File(pickedFile.path);
        state = AppState.picked;
      });

      _cropImage();
    }
  }

  Future<Null> _cropImage() async {
    file.File croppedFile = (await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: Theme.of(context).platform == TargetPlatform.android
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ))) as file.File;
    if (croppedFile != null) {
      imageFile = croppedFile;

      setState(() {
        state = AppState.cropped;
        _loading_photo = true;
         });

        _clearImage();
     
      setState(() {
        _loading_photo = false;
        updateAvatar(croppedFile);
      });
    }
  }

  void _clearImage() {
    imageFile = null;
    setState(() {
      state = AppState.free;
    });
  }

  updateAvatar(file.File file) async {

    print("here");
setState(() {
          _loading_photo = true;
        });

                  var resid = await http.post(
            "${Constants.mediaURL}",
            body: {},
            headers: {
              "authorization": "${"Bearer "+ user.token}"
            }
          );

print(widget.profile.id);
          var res = await wc_api.postAsync(
          "customers/${widget.profile.id}",
          {
              // "avatar_url": url
          }
        );

      print(res.statusCode);
      if (res.statusCode == 200) {
        setState(() {
          // avatar_url = url;
           _loading_photo = false;
        });
        return true;
      }else{
        setState(() {
          _loading_photo = false;
        });
        return false;
      }

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPreviousAddress();
    first_name = widget.profile.firstName;
    last_name = widget.profile.lastName;
    email = widget.profile.email;
    phone = widget.profile.billing.phone;
    avatar_url = widget.profile.avatarUrl;
    state = AppState.free;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Icon ofericon = new Icon(
      Icons.edit,
      color: Colors.black38,
    );
    Icon keyloch = new Icon(
      Icons.vpn_key,
      color: Colors.black38,
    );
    Icon clear = new Icon(
      Icons.history,
      color: Colors.black38,
    );
    Icon logout = new Icon(
      Icons.do_not_disturb_on,
      color: Colors.black38,
    );

    Icon menu = new Icon(
      Icons.more_vert,
      color: Colors.black38,
    );
    bool checkboxValueA = true;
    bool checkboxValueB = false;
    bool checkboxValueC = false;

    //List<address> addresLst = loadAddress() as List<address> ;
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title:
            Text('My Account', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: new Container(
          color: Colors.orange.withOpacity(0.07),
          child:  ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // textDirection: TextDirection.ltr,
            // shrinkWrap: true,
            children: <Widget>[
              new Container(
                margin: EdgeInsets.all(15.0),
                alignment: Alignment.topCenter,
                child: new Card(
                  elevation: 3.0,
                  child: Column(
                    children: <Widget>[
                      new Container(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: 100.0,
                            height: 100.0,
                            margin: const EdgeInsets.all(10.0),
                            // padding: const EdgeInsets.all(3.0),
                            child: ClipOval(
                              child: Image.network(avatar_url)
                            ),
                          )),

          //       login_method == "google"
          //         ? Container()
          //         : _loading_photo? Center(
          //         child: CircularProgressIndicator(
          //           valueColor: AlwaysStoppedAnimation<Color>(
          //               Theme.of(context).accentColor),
          //         ),
          //       ):  new FlatButton(
          //               onPressed: (){
          //                 print(state);
          //                               if (state == AppState.free)
          //   _pickImage();
          // else if (state == AppState.picked)
          //   _cropImage();
          // else if (state == AppState.cropped) _clearImage();
          //               },
          //               child: Text(
          //                 'Change',
          //                 style:
          //                     TextStyle(fontSize: 13.0, color: Colors.blueAccent),
          //               ),
          //               shape: RoundedRectangleBorder(
          //                   borderRadius: new BorderRadius.circular(30.0),
          //                   side: BorderSide(color: Colors.blueAccent)),
          //             ),

                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        
                        children: <Widget>[
                          new Container(
                            margin: EdgeInsets.only(
                                left: 10.0, top: 20.0, right: 5.0, bottom: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                new Text(
                                  first_name +
                                      " " +
                                      last_name,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                phone == ""
                                    ? Container()
                                    : _verticalDivider(),
                                phone == ""
                                    ? Container()
                                    : new Text(
                                        phone,
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5),
                                      ),
                                _verticalDivider(),
                                new Text(
                                  email,
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5),
                                ),
                                _verticalDivider(),
                              ],
                            ),
                          ),
                          

                          new Container(
                            width: MediaQuery.of(context).size.width/5,
                            
                            alignment: Alignment.center,
                            child: IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Theme.of(context).accentColor,
                                ),
                                onPressed: (){
                                  setState(() {
                                    _firstnameControl_edit.text = first_name;
                                    _lastnameControl_edit.text = last_name;
                                    _emailControl_edit.text = email;
                                    _phoneControl_edit.text = phone;
                                  });
                                  showProfileEditForm(context);
                                }),
                          
                          )
                          
                        ],
                      ),
                      // VerticalDivider(),
                    ],
                  ),
                ),
              ),
              new Container(
                padding: EdgeInsets.only(
                    left: 20.0, top: 5.0, right: 0.0, bottom: 5.0),
                child: new Text(
                  'Delivery Address',
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
              ),

              
           new Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
              height: MediaQuery.of(context).size.height/4,
              child: _loading_addresses?
              Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).accentColor),
                  ),
                ): ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
  itemCount:addresses.length+1,
  itemBuilder: (context, i) {
          if(i==0){
              return  Container(
                    height: MediaQuery.of(context).size.height/4,
                    width: !address_set?100.0 : 200.0,
                    child: GestureDetector(

                      onTap: () {

                            setState(() {
      
        _firstnameControl.text = "";
        _lastnameControl.text =  "";
        _address1Control.text =  "";
        _address2Control.text =  "";
        _cityControl.text =  "";
        _pincodeControl.text = "";
        _phoneControl.text =  "";
    });
                                        openAddressForm(context,i);
                      },
                      child: Card(
                      elevation: 3.0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _loading_addresses?
                          Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).accentColor),
                  ),
                ):

                          new Container(
                              alignment: Alignment.center,
                              child: IconButton(
                                  icon: Icon(Icons.add), onPressed: null))

                           
                           
                        ],
                      ),
                    ),
               
                    )    );
    }else{
      return Container(
                    height: 165.0,
                    width: 200.0,
                    // margin: EdgeInsets.all(7.0),
                    child:  
                    
                         
               Card(
                      elevation: 3.0,
                      child: Stack(
                        children: <Widget>[
                          Align(alignment: Alignment.topRight,
                          child:
                          Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: PopupMenuButton<String>(
      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
      icon: Icon(Icons.more_vert),
      onSelected: showMenuSelection,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
             PopupMenuItem<String>(
                value: 'Edit',
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context, "Edit");
                    edit_address(context,i-1);
                  },
                  child: ListTile(
                    title: Text('Edit')),
                ) ),
             PopupMenuItem<String>(
                value: 'Delete',
                child: GestureDetector(
                  onTap: () {
                    deleteAddress(i-1);
                    Navigator.pop(context, "Delete");
                  },
                  child: ListTile(
                    title: Text('Delete')),
                ))
          ],
    ),), 
                          ) ,

                          
                            Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Column(
                            children: <Widget>[
                              
                              new Container(
                                margin: EdgeInsets.only(
                                    left: 12.0,
                                    top: 5.0,
                                    right: 0.0,
                                    bottom: 0.0),
                                child:  
                          Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Text(
                                      addresses[i-1]['first_name']
                                      + " " + addresses[i-1]['last_name']
                                      ,style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    // _verticalDivider(),
                                    new Text(
                                      addresses[i-1]['address_1'],
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 13.0,
                                          letterSpacing: 0.5),
                                    ),
                                    // _verticalDivider(),
                                    new Text(
                                      addresses[i-1]['address_2'],
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 13.0,
                                          letterSpacing: 0.5),
                                    ),
                                    // _verticalDivider(),
                                    new Text(
                                      addresses[i-1]['city'],
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 13.0,
                                          letterSpacing: 0.5),
                                    ),
                                    // _verticalDivider(),
                                    new Text(
                                      addresses[i-1]['postcode'],
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 13.0,
                                          letterSpacing: 0.5),
                                    ),
                                    // _verticalDivider(),
                                    new Text(
                                      addresses[i-1]['phone'],
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 13.0,
                                          letterSpacing: 0.5),
                                    ),
                                    
                                  ],
                                ),
                        
                            

                          ),

                        ],
                      ),
                        ]
                      ) ])
                    ),
                       
                  );

    }
    
    
   },
),),
                
           

              login_method == "google"
                  ? Container()
                  : Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: new Container(
                          margin: EdgeInsets.fromLTRB(7, 0, 0, 0),
                          child: GestureDetector(
                            onTap: () {
                                _showChangePassword(context);
                            },
                            child: Card(
                              elevation: 1.0,
                              child: Row(
                                children: <Widget>[
                                  new IconButton(
                                      icon: keyloch, onPressed: null),
                                  _verticalD(),
                                  new Text(
                                    'Change Password',
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.black87),
                                  )
                                ],
                              ),
                            ),
                          )),
                    ),
              // Padding(
              //     padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              //     child: Container(
              //         margin: EdgeInsets.fromLTRB(7, 0, 0, 0),
              //         child: GestureDetector(
              //           onTap: () {
              //           confirmHistoryDeletion(context);
              //           },
              //           child: Card(
              //             elevation: 1.0,
              //             child: Row(
              //               children: <Widget>[
              //                 new IconButton(icon: clear, onPressed: null),
              //                 _verticalD(),
              //                 new Text(
              //                   'Clear History',
              //                   style: TextStyle(
              //                     fontSize: 15.0,
              //                     color: Colors.black87,
              //                   ),
              //                 )
              //               ],
              //             ),
              //           ),
              //         ))),
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Container(
                      margin: EdgeInsets.fromLTRB(7, 0, 0, 0),
                      child: GestureDetector(
                        onTap: () {
                          confirmDeactivation(context);
                        },
                        child: Card(
                          elevation: 1.0,
                          child: Row(
                            children: <Widget>[
                              new IconButton(icon: logout, onPressed: null),
                              _verticalD(),
                              new Text(
                                'Deactivate Account',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.redAccent,
                                ),
                              )
                            ],
                          ),
                        ),
                      )))
            ],
          )),
    );
  }

  _verticalDivider() => Container(
        padding: EdgeInsets.only(top: 10),
      );

  _verticalD() => Container(
        margin: EdgeInsets.only(left: 3.0, right: 0.0, top: 0.0, bottom: 0.0),
      );
}
