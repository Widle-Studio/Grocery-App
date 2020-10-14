
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_groceries/Utils/ModalProgressHUD.dart';
import 'package:f_groceries/Utils/constants.dart';
import 'package:f_groceries/database/user/db_helper.dart';
import 'package:f_groceries/database/user/user.dart';
import 'package:f_groceries/model/notification_model.dart';
import 'package:f_groceries/screens/offer_screen.dart';
import 'package:f_groceries/screens/orderhistory_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';


class NotificationPage extends StatefulWidget {
  List<NotificationModel> notificationList;

    NotificationPage({
    Key key,
    @required this.notificationList
  }) : super(key: key);

  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<NotificationPage> {


  SharedPreferences preferences;
  String user_id = '';

  bool _isInAsyncCall = false; 
  String userRole = '';
  var formatter = new DateFormat('yyyy-MM-dd');
   var now = new DateTime.now();
    String formatted;
  var userdb = UserHelper();
  User user;
  List items;
  final _animatedListKey = GlobalKey<AnimatedListState>();


  getUser() async {
    user = await userdb.getUser(1);
    setState(() {
      user = user;
    });
  }
   @override
  void initState() {
    super.initState();
    items = widget.notificationList;
    getUser();
    

  }

  @override
  void dispose() {
    super.dispose();
  }
//-----------------------------------------------



//---------------------------------------------------

  @override
  Widget build(BuildContext context) {
    
      return Scaffold(
        appBar: AppBar(                       
          title : Text('Notifications', style: TextStyle(fontWeight: FontWeight.bold)),
           automaticallyImplyLeading: true,
          //  iconTheme: new IconThemeData(color: Color(0xffb8b8b8)),   
           elevation: 3, 
              
         ),
        backgroundColor: Colors.white,

        body: ModalProgressHUD(
          child : Container(
                margin: EdgeInsets.only(left:5, right: 5, top: 5, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.white
                ),
                child: Column(         
                  crossAxisAlignment: CrossAxisAlignment.start,                     
                  children: <Widget>[

                    notificationlist()    

                  ]
                )
              ),
          
          inAsyncCall: _isInAsyncCall,
          opacity: 0.7,        
          color: Colors.white,
          progressIndicator: CircularProgressIndicator(),
        ),  
      );
    
  }

  Tween<Offset> _offSetTween = Tween(
  begin: Offset(1, 0),
  end: Offset.zero,
);

  Widget notificationlist(){
   return items == null || items.length == 0 ? Container(
     child: Center(child: Text("Stay tuned!"),),
   ) : 
     Container(
      margin: EdgeInsets.only(right : 0.0, left: 0.0, top:0, bottom: 0),
      child: AnimatedList(
      key: _animatedListKey,
      initialItemCount: items.length,
      shrinkWrap: true,
      
      itemBuilder: (context, index, animation) {
        
        var item = items[index];
        return _buildItem(item, animation, index) ;
      },
    ),) ;
    
  }

    Widget _buildItem(var item, Animation animation, int index) {
    return Stack(
      children: <Widget>[
        FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: _offSetTween.animate(animation),
            child: Dismissible(
                                  key: ObjectKey(item.id),
                                  background: stackBehindDismiss(),
                                  direction: DismissDirection.startToEnd,
                                  onDismissed: (direction) {
                                    Firestore.instance.collection("users").document(user.email)  
                                  .collection("notifications").document(item.id)
                                  .delete();
                                  // setState(() {
                                    
                                  //   var removedItem = items.removeAt(index);
                                  // //   
                                  // //       AnimatedListRemovedItemBuilder builder = (context, animation) {
                                  // //   // A method to build the Card widget.
                                  // //   return _buildItem(removedItem, animation, index);
                                  // // };
    
                                  // //   _animatedListKey.currentState.removeItem(index, builder);
                                    
 
                                  // });
                                  
                                  },
                    child: GestureDetector(
              
              child:  Card(                     
                    elevation: 2,             
                    shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                    color: Colors.white,
                    child: Stack(
                      children: <Widget>[
                        Container(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                      width: MediaQuery.of(context).size.width,  
                      child:   Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                                                height: 50.0,
                                                width: 50.0,
                                                child: CachedNetworkImage(
                                              imageUrl: item.icon,
                                              fit: BoxFit.cover,
                                              width: MediaQuery.of(context).size.width,
                                            ),),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                 
                                  // SizedBox(width: 5),
                                  Column(                                                        
                                    children: <Widget>[
                                        Container(
                                        width: MediaQuery.of(context).size.width * 0.58,
                                        child : 
                                            Text("${item.title}",
                                              style : TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold
                                              )
                                            )
                                        ),
                                        SizedBox(
                            height: 10,
                          ),
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.58,
                                        child : 
                                            Text("${item.message}",
                                              style : TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500
                                              )
                                            )
                                        ),
                                        SizedBox(
                            height: 5,
                          ),
                                        Container(
                                        width: MediaQuery.of(context).size.width * 0.58,
                                        child : 
                                            Text("${item.date}"+ " " + item.time,
                                              style : TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w300
                                              )
                                            )
                                        ),



                                    ],
                                  ),

                                ],
                              )
                            ],
                          ),
                 
                         
                          
                        ],
                      )
                    ),
                        Container(
          // padding: EdgeInsets.all(5),
          alignment: Alignment.topRight,
          child: IconButton(icon: Icon(Icons.cancel, color: Colors.grey,), onPressed: () {
            setState(() {
                                    var removedItem = items.removeAt(index);
                                        AnimatedListRemovedItemBuilder builder = (context, animation) {
                                    // A method to build the Card widget.
                                    return _buildItem(removedItem, animation, index);
                                  };
    
                                    _animatedListKey.currentState.removeItem(index, builder);
                                  Firestore.instance.collection("users").document(user.email)  
                                  .collection("notifications").document(item.id)
                                  .delete();

                                   Firestore.instance.collection("notifications").document(item.id)
                                  .delete();
                                  });

                                  

          },),
        )
                      ],
                    ) 
                   ),
                   onTap: (){
                     var bookingID = items[index].order_id;
                    //  var adID = notificationList[i].ad_id;
                    print("Booking ID :$bookingID");
                                Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {

          switch(items[index].on_tap_screen){
                case "order_screen":
                      return Order_History(toolbarname: ' Order History',);
                      
                     
                case "offer_screen": 
                      return OfferScreen();
          }


        },
      ),
    );

                   },
            ),)
          ),
        ),


      ],
    ) ;
  }

    Widget stackBehindDismiss() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: Colors.transparent,
      
    );
  }

}