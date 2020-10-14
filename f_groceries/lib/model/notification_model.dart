import 'package:flutter/cupertino.dart';

class NotificationModel{
  String id;
  String date;
  String  message;
  String order_id;
  String title;
  String time;
  String icon;
  String on_tap_screen;
  String user_id;
  // List ad_id;


  NotificationModel(
    this.id,
    this.date,
    this.message,
    this.order_id,
    this.title,
    this.time,
    this.icon,
    this.on_tap_screen,
    this.user_id
    // this.ad_id
  );

  NotificationModel.map(dynamic obj) {
    this.id = obj['id'];
    this.date = obj['date'];
    this.message = obj['message'];   
    this.order_id = obj['order_id'];   
    this.title = obj['title'];
    this.time = obj['time'];
    this.time = obj['icon'];
    this.on_tap_screen = obj['on_tap_screen'];
    this.user_id = obj['user_id'];
    // this.ad_id = obj['ad_id'];   

  }
      

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }

    map['date'] = date;
    map['message'] = message;
    map['order_id'] = order_id;
    map['title'] = title;
    map['time'] = time;
    map['icon'] = icon;
    map['on_tap_screen'] = on_tap_screen;
    map['user_id'] = user_id;
    // map['ad_id'] = ad_id;

    return map;
  }



  NotificationModel.fromMap(Map<String, dynamic> map)  {
    
    this.id = map['id'];
    this.date = map['date'];
    this.message = map['message'];
    this.order_id = map['order_id'];
    this.title = map['title'];
    this.time = map['time'];
    this.icon = map['icon'];
    this.on_tap_screen = map['on_tap_screen'];
    this.user_id = map['user_id'];
    // this.ad_id = map['ad_id'];

  }

}
