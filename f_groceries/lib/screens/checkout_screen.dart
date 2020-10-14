import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_groceries/Objects/profile.dart';
import 'package:f_groceries/Utils/constants.dart';
import 'package:f_groceries/Utils/woocommerce_api.dart';
import 'package:f_groceries/database/cart/db_helper.dart';
import 'package:f_groceries/database/user/db_helper.dart';
import 'package:f_groceries/database/user/user.dart';
import 'package:f_groceries/screens/Payment_Screen.dart';
import 'package:f_groceries/screens/coupon_code.dart';
import 'package:flutter/material.dart';
import 'package:f_groceries/database/cart/cart.dart' as cart_db;
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';


class Checkout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => check_out();
}

class Item {
  final String itemName;
  final String itemQun;
  final String itemPrice;

  Item({this.itemName, this.itemQun, this.itemPrice});
}

class check_out extends State<Checkout> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool checkboxValueA = true;
  bool checkboxValueB = false;
  bool checkboxValueC = false;
  bool _loading = true;
  bool _loading_addresses = false;
  List cartList;
  double totalPrice = 0.00;
  bool address_set = false;
  TimeOfDay time_now,time;
  User user;
  var userdb = UserHelper();
  Profile profile;
  List addresses = List();
  List checkboxList = List();


  WooCommerceAPI wc_api = WooCommerceAPI("${Constants.baseURL}",
    "${Constants.consumerKey}", "${Constants.consumerSecret}");

  
  final TextEditingController _firstnameControl = new TextEditingController();
  final TextEditingController _lastnameControl = new TextEditingController();
  final TextEditingController _address1Control = new TextEditingController();
  final TextEditingController _address2Control = new TextEditingController();
  final TextEditingController _cityControl = new TextEditingController();
  final TextEditingController _pincodeControl = new TextEditingController();
  final TextEditingController _phoneControl = new TextEditingController();

  
  DateTime deliveryDate;
  final databaseReference = Firestore.instance;

  IconData _backIcon() {
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return Icons.arrow_back;
      case TargetPlatform.iOS:
        return Icons.arrow_back_ios;
    }
    assert(false);
    return null;
  }

  getItems() async {
  user = await userdb.getUser(1);
  var db = CartHelper();
  List res = await db.getCarts();
  setState(() {
    if (res.length == 0) {
      _loading = false;
    } else {
      cartList = res;
      totalPrice = 0.00;
      for (var i = 0; i < cartList.length; i++) {
        totalPrice =
            totalPrice + cartList[i]['price'] * cartList[i]['quantity'];
      }
      _loading = false;
      setState(() {
        totalPrice = totalPrice;
      });
    }
  });
}

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
     checkboxList = [];
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
     checkboxList.add(false);
    }

     );
    
  });
    checkboxList.add(false);
    if(checkboxList.length>1){
      checkboxList[1] = true;
    }
    


    setState(() {
      _loading_addresses = false;
    });

  }

getUserLocationFromCoordinates() async {
    //call this async method from whereever you need

GeolocationStatus geolocationStatus  = await Geolocator().checkGeolocationPermissionStatus();

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

  void showMenuSelection(String value) {
  print(value);
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
                      child: Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(Icons.gps_fixed, color:Theme.of(context).accentColor ,),
                          Text("Use My Current Location", style: TextStyle(fontWeight: FontWeight.bold),),
                        ],
                      ) ,
                      ) ,
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
                                              borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                            ),
                                            focusedBorder:  UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                            ),
                                            hintText: 'First name',
                                            labelStyle: TextStyle(color: Colors.black54)
                                        ),
                                        keyboardType: TextInputType.text,
                                      
                                      ),
                                      TextFormField(
                                        textCapitalization: TextCapitalization.words,
                                        controller: _lastnameControl,
                                        decoration: const InputDecoration(
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                            ),
                                            focusedBorder:  UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                            ),
                                            hintText: 'Last name',
                                            labelStyle: TextStyle(color: Colors.black54)
                                        ),
                                        keyboardType: TextInputType.text,
                                      ),
                                      TextFormField(
                                        textCapitalization: TextCapitalization.sentences,
                                        controller: _address1Control,
                                        decoration: const InputDecoration(
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                            ),
                                            focusedBorder:  UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                            ),
                                            hintText: 'Address Line 1',
                                            labelStyle: TextStyle(color: Colors.black54)
                                        ),
                                        keyboardType: TextInputType.emailAddress,
                                      ),

                                      TextFormField(
                                        textCapitalization: TextCapitalization.sentences,
                                        controller:_address2Control,
                                        decoration: const InputDecoration(
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                            ),
                                            focusedBorder:  UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                            ),
                                            hintText: 'Address Line 2',
                                            labelStyle: TextStyle(color: Colors.black54)
                                        ),
                                        keyboardType: TextInputType.text
                                       
                                      ),
                                      TextFormField(
                                        textCapitalization: TextCapitalization.words,
                                        controller: _cityControl,
                                        decoration: const InputDecoration(
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                            ),
                                            focusedBorder:  UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                            ),
                                            hintText: 'City',
                                            labelStyle: TextStyle(color: Colors.black54)
                                        ),

                                      ),
                                      TextFormField(
                                        controller: _pincodeControl,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                            ),
                                            focusedBorder:  UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                            ),
                                            hintText: 'Pincode',
                                            labelStyle: TextStyle(color: Colors.black54)
                                        ),

                                      ),
                                      TextFormField(
                                        controller: _phoneControl,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                            ),
                                            focusedBorder:  UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                            ),
                                            hintText: 'Phone number',
                                            
                                            labelStyle: TextStyle(color: Colors.black54)
                                        ),

                                      ),



                                     
        ],
      ),

      actions: <Widget>[

          FlatButton(
            onPressed: (){
              if(_firstnameControl.text.isEmpty || _lastnameControl.text.isEmpty){

              }else{
                // setState(() {
                //   address_set = true;
                //   checkboxList.fillRange(0, checkboxList.length, false);
                //   checkboxList[0] = true;
                // });

              print(index);
              if(index == 0){
                addAddress();
              }else{
                updateAddress(index-1);
              }
                
              }
              Navigator.pop(context);
              },
            child: Text("OK"),
          )
      ]
    );

    showDialog(
        context: context,
        builder: (context) => Center(
              // Aligns the container to center
              child: alert,
            ));
  }

    edit_address(BuildContext context, int index_actual, int index_virtual) async {

    await setState(() {
      
        _firstnameControl.text = addresses[index_actual]['first_name'];
        _lastnameControl.text =  addresses[index_actual]['last_name'];
        _address1Control.text =  addresses[index_actual]['address_1'];
        _address2Control.text =  addresses[index_actual]['address_2'];
        _cityControl.text =  addresses[index_actual]['city'];
        _pincodeControl.text = addresses[index_actual]['postcode'];
        _phoneControl.text =  addresses[index_actual]['phone'];
    });
    openAddressForm(context,index_virtual);
  }


  @override
  void initState() {
    super.initState();
    getItems();
    getPreviousAddress();
    time_now = TimeOfDay.now();
  }

  String toolbarname = 'CheckOut';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final double height = MediaQuery.of(context).size.height;

    AppBar appBar = AppBar(
      leading: IconButton(
        icon: Icon(_backIcon()),
        alignment: Alignment.centerLeft,
        tooltip: 'Back',
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(toolbarname, style: TextStyle(fontWeight: FontWeight.bold)),
      backgroundColor: Colors.white,
      actions: <Widget>[
        new Padding(
          padding: const EdgeInsets.all(10.0),
          child: new Container(
            height: 150.0,
            width: 30.0,
            child: new GestureDetector(
              onTap: () {
                /*Navigator.of(context).push(
                  new MaterialPageRoute(
                      builder:(BuildContext context) =>
                      new CartItemsScreen()
                  )
              );*/
              },
            ),
          ),
        )
      ],
    );

    return new Scaffold(
      key: _scaffoldKey,
      appBar: appBar,
      body: Container(
        color: Colors.orange.withOpacity(0.07),
        child:ListView(
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(5.0),
              child: Card(
                  child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // three line description
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 0.0),
                                child: Container(
                                    alignment: Alignment.center,
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          'Delivery',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        IconButton(
                                            icon: Icon(
                                              Icons.play_circle_outline,
                                              color: Colors.orange,
                                            ),
                                            onPressed: null)
                                      ],
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 0.0),
                                child: Container(
                                    alignment: Alignment.center,
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          'Payment',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black38),
                                        ),
                                        IconButton(
                                            icon: Icon(
                                              Icons.check_circle,
                                              color: Colors.black38,
                                            ),
                                            onPressed: null)
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        ],
                      )))),
          _verticalDivider(),
          new Container(
            alignment: Alignment.topLeft,
            margin:
                EdgeInsets.only(left: 12.0, top: 5.0, right: 0.0, bottom: 5.0),
            child: new Text(
              'Delivery Address',
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
          ),
          
         new Container(
              height: MediaQuery.of(context).size.height/4,
              child:    _loading_addresses?
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
                    width: 100.0,
                    child: GestureDetector(
                      onTap: () {
                                        openAddressForm(context, i);
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
                ): new Container(
                              alignment: Alignment.center,
                              child: IconButton(
                                  icon: Icon(Icons.add), onPressed: null))

                          //   new Container(
                          //       margin: EdgeInsets.only(
                          //           left: 12.0,
                          //           top: 5.0,
                          //           right: 0.0,
                          //           bottom: 0.0),
                          //       child: Column(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: <Widget>[
                          //           new Text(
                          //             _firstnameControl.text + " " + _lastnameControl.text
                          //             ,style: TextStyle(
                          //               color: Colors.black87,
                          //               fontSize: 15.0,
                          //               fontWeight: FontWeight.bold,
                          //               letterSpacing: 0.5,
                          //             ),
                          //           ),
                          //           // _verticalDivider(),
                          //           new Text(
                          //             _address1Control.text,
                          //             style: TextStyle(
                          //                 color: Colors.black45,
                          //                 fontSize: 13.0,
                          //                 letterSpacing: 0.5),
                          //           ),
                          //           // _verticalDivider(),
                          //           new Text(
                          //             _address2Control.text,
                          //             style: TextStyle(
                          //                 color: Colors.black45,
                          //                 fontSize: 13.0,
                          //                 letterSpacing: 0.5),
                          //           ),
                          //           // _verticalDivider(),
                          //           new Text(
                          //             _cityControl.text,
                          //             style: TextStyle(
                          //                 color: Colors.black45,
                          //                 fontSize: 13.0,
                          //                 letterSpacing: 0.5),
                          //           ),
                          //           // _verticalDivider(),
                          //           new Text(
                          //             _pincodeControl.text,
                          //             style: TextStyle(
                          //                 color: Colors.black45,
                          //                 fontSize: 13.0,
                          //                 letterSpacing: 0.5),
                          //           ),
                          //           // _verticalDivider(),
                          //           new Text(
                          //             _phoneControl.text,
                          //             style: TextStyle(
                          //                 color: Colors.black45,
                          //                 fontSize: 13.0,
                          //                 letterSpacing: 0.5),
                          //           ),
                          //           new Container(
                          //             margin: EdgeInsets.only(
                          //                 left: 00.0,
                          //                 top: 0.0,
                          //                 right: 0.0,
                          //                 bottom: 0.0),
                          //             child: Row(
                          //               crossAxisAlignment:
                          //                   CrossAxisAlignment.center,
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.start,
                          //               children: <Widget>[
                          //                 new Text(
                          //                   'Delivery Address',
                          //                   style: TextStyle(
                          //                     fontSize: 15.0,
                          //                     color: Colors.black26,
                          //                   ),
                          //                 ),
                          //                 _verticalD(),
                          //                 new Checkbox(
                          //                   value: checkboxList[i],
                          //                   onChanged: (bool value) {
                          //                     setState(() {
                          //                       checkboxList.fillRange(0, checkboxList.length, false);
                          //                       checkboxList[i] = value;
                          //                     });
                          //                   },
                          //                 ),
                          //               ],
                          //             ),
                          //           )
                          //         ],
                          //       ),
                          //     ),
                           
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
                      child: 
                      
                      Stack(
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
                    edit_address(context,i-1,i);
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Text(
                                      addresses[i-1]['first_name']
                                      //  + " " + addresses[i]['last_name']
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
                                    new Container(
                                      margin: EdgeInsets.only(
                                          left: 00.0,
                                          top: 0.0,
                                          right: 0.0,
                                          bottom: 0.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          new Text(
                                            'Delivery Address',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black26,
                                            ),
                                          ),
                                          _verticalD(),
                                          new Checkbox(
                                            value: checkboxList[i],
                                            onChanged: (bool value) {
                                              setState(() {
                                                checkboxList.fillRange(0, checkboxList.length, false);
                                                checkboxList[i] = value;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                        ]
                        ) 
                    ),
                  );
    }
    
   },
)
                
              //    ListView(
              //   scrollDirection: Axis.horizontal,
              //   children: <Widget>[

                  

                  
                  
              //      ],
              // )
               ),
          
           _verticalDivider(),
    //       new Container(
    //         alignment: Alignment.topLeft,
    //         margin:
    //             EdgeInsets.only(left: 12.0, top: 5.0, right: 0.0, bottom: 0.0),
    //         child: SafeArea(
    //                     child: Column(
    //                   children: <Widget>[
    //                     Container(
    //                       padding: EdgeInsets.all(5.0),
    //                       child: Row(

    //                               mainAxisSize: MainAxisSize.max,
    //                               // crossAxisAlignment: CrossAxisAlignment.start,
    //                               mainAxisAlignment:
    //                                   MainAxisAlignment.spaceBetween,
    //                               children: <Widget>[

    //                                 Text("Delivery Date",
    //                                     style: TextStyle(
    //                                         fontSize: 18.0,
    //                                         color: Colors.grey,
    //                                         fontWeight: FontWeight.bold)),

    //                                 GestureDetector(
    //                                   onTap:() async {
    //                                      final date = await showDatePicker(
    //                                             context: context,
    //                                             firstDate: DateTime.now()
    //                                                 .subtract(
    //                                                     new Duration(days: 1)),
    //                                             initialDate: DateTime.now(),
    //                                             lastDate: DateTime(2100));

    //                                         setState(() {
    //                                          deliveryDate = date;
    //                                         });
    //                                   },

    //                                 child: deliveryDate == null?
    //                                 Icon(Icons.calendar_today):Text(deliveryDate.day.toString()+"-"+deliveryDate.month.toString()+"-"+deliveryDate.year.toString())
    //                                 )
                                    
    //                               ],

    //                       ),
    //                     ),
    //                   ],
    //                 ))
    //       ),

    //         // _verticalDivider(),
    //       new Container(
    //         alignment: Alignment.topLeft,
    //         margin:
    //             EdgeInsets.only(left: 12.0, top: 0.0, right: 0.0, bottom: 5.0),
    //         child: SafeArea(
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: <Widget>[
    //                     Container(
    //                       padding: EdgeInsets.all(5.0),
    //                       child: Row(

    //                               mainAxisSize: MainAxisSize.max,
    //                               // crossAxisAlignment: CrossAxisAlignment.start,
    //                               mainAxisAlignment:
    //                                   MainAxisAlignment.spaceBetween,
    //                               children: <Widget>[
    //                                 Center(child:
    //                                      Text("Delivery Time",
    //                                     style: TextStyle(
    //                                         fontSize: 18.0,
    //                                         color: Colors.grey,
    //                                         fontWeight: FontWeight.bold)),
    //                                 ),

    //                                 GestureDetector(
    //                                   onTap:() async {
    //                                     TimeOfDay t = await showTimePicker(
    //   context: context,
    //   initialTime: time_now
    // );

    // setState(() {
      
    //   time = t;
    // });
    //                                   },
    //                                   child: time == null?
    //                                 Icon(Icons.timer):Text(time.hour.toString() + ":" + time.minute.toString())
                                    
    //                                 ),
                                    
    //                               ],

    //                       ),
    //                     ),
    //                   ],
    //                 ))
    //       ),

          _verticalDivider(),
          Row(children: <Widget>[
            new Container(
            alignment: Alignment.topLeft,
            margin:
                EdgeInsets.only(left: 12.0, top: 5.0, right: 0.0, bottom: 5.0),
            child: new Text(
              'Order Summary',
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontFamily: "openSans",
                  fontSize: 18.0),
            ),
          ),
          ],),
          _verticalDivider(),
          
          
          _loading?Container():
          Container(
              margin: EdgeInsets.only(
                  left: 12.0, top: 5.0, right: 12.0, bottom: 5.0),
              height: 170.0,

              child: ListView.builder(
                  itemCount: cartList.length,
                  itemBuilder: (BuildContext cont, int index) {
                    cart_db.Cart cart = cart_db.Cart.fromMap(cartList[index]);
                    return SafeArea(
                        child: Column(
                      children: <Widget>[
                        Padding(
padding:EdgeInsets.fromLTRB(0, 5, 0, 5),
child:Container(
height:2.0,
color:Colors.black12,),),
                        Container(
                          padding: EdgeInsets.all(5.0),
                          child: Row(

                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width/1.7,
                                      child:   Text(cart.name,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black,)),
                                    ),
                                  
                                    Expanded(child:  
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[

                                           Text("Qty: "+cart.quantity.toString(),
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black,)),
                                    Text("₹ " +cart.price.toInt().toString(),
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black,)),
                                      ],
                                    ),)
                                   
                                 
                                  ],

                          ),
                        ),

                        index == cartList.length-1?Padding(
padding:EdgeInsets.fromLTRB(0, 5, 0, 5),
child:Container(
height:2.0,
color:Colors.black12,),):Container(),
                      ],
                    ));
                  })),
          
        ],
      ),

      
      ) ,   bottomNavigationBar: Builder(
        // Create an inner BuildContext so that the onPressed methods
        // can refer to the Scaffold with Scaffold.of().
        
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
            child:  Container(
              alignment: Alignment.bottomLeft,
              height: 60.0,
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // IconButton(icon: Icon(Icons.info), onPressed: null),
                    Row(
                      children: <Widget>[
                        SizedBox(
                        width: 20,
                    ),
                    Text(
                      'Total :',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                        width: 10,
                    ),
                    Text(
                      "₹ " + totalPrice.toInt().toString(),
                      style: TextStyle(fontSize: 17.0, color: Colors.black54),
                    ),
                      ],
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                       child: FlatButton(
            color: Theme.of(context).accentColor,
            shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15.0),
    
  ),
            onPressed: (){
              if(checkboxList.contains(true)){
                if(checkboxList[0]){
                  if(_address1Control.text.isEmpty || _cityControl.text.isEmpty || _pincodeControl.text.isEmpty){
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text('Fill complete details')));
                              }else{
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Payment(
                                        firstName: _firstnameControl.text,
                                        lastName: _lastnameControl.text,
                                        email: user.email,
                                        address1: _address1Control.text,
                                        address2: _address2Control.text,
                                        city: _cityControl.text,
                                        country: "India",
                                        postCode: _pincodeControl.text,
                                        phone: _phoneControl.text,
                                        grandTotal: totalPrice,
                                        userId: user.userId,
                                        new_address: true,
                                      )));
                              }  
                }else{
                  int index = checkboxList.indexOf(true)-1;

                    Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Payment(
                                        firstName: addresses[index]['first_name'],
                                        lastName: addresses[index]['last_name'],
                                        email: user.email,
                                        address1: addresses[index]['address_1'],
                                        address2: addresses[index]['address_2'],
                                        city: addresses[index]['city'],
                                        country: "India",
                                        postCode: addresses[index]['postcode'],
                                        phone: addresses[index]['phone'],
                                        grandTotal: totalPrice,
                                        userId: user.userId,
                                        new_address: false,
                                      )));
                              
                }
                   
              }else{
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text('Please select an address')));
              }
                       
            },
            child: Text('CONFIRM ORDER', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          ),
                      
                      ),
                    ),
                  ],
                ),
              ),
         );
              
              
              ;
        },
      ),
    );
  }
  IconData _add_icon() {
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return Icons.add;
      case TargetPlatform.iOS:
        return Icons.arrow_back_ios;
    }
    assert(false);
    return null;
  }
  IconData _sub_icon() {
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return Icons.remove;
      case TargetPlatform.iOS:
        return Icons.arrow_back_ios;
    }
    assert(false);
    return null;
  }

  _verticalDivider() => Container(
        padding: EdgeInsets.all(2.0),
      );

  _verticalD() => Container(
        margin: EdgeInsets.only(left: 3.0, right: 0.0, top: 0.0, bottom: 0.0),
      );
}
