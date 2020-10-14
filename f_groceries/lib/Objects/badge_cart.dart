import 'dart:async';

import 'package:f_groceries/database/cart/db_helper.dart';
import 'package:flutter/material.dart';

class IconBadge_cart extends StatefulWidget {

  final IconData icon;
  final double size;

  IconBadge_cart({Key key, @required this.icon, @required this.size})
      : super(key: key);

//  static updateCount(BuildContext context) {
//    final _IconBadgeState state =
//    context.ancestorStateOfType(const TypeMatcher<_IconBadgeState>());
//    state.updateCount();
//  }

  @override
  _IconBadgeState createState() => _IconBadgeState();
}

class _IconBadgeState extends State<IconBadge_cart> {

  int counter = 0;
  var db = CartHelper();

  var timeout = const Duration(seconds: 4);
  var ms = const Duration(milliseconds: 1);

  startTimeout([int milliseconds]) {
    var duration = milliseconds == null ? timeout : ms * milliseconds;
    return Timer.periodic(duration, (Timer t){
      if(mounted){
        getCount();
      }
    });
  }


  getCount() async{
    var c = await db.getCount();
    setState((){
      counter=c;
    });
  }

  @override
  void initState() {
    super.initState();
    getCount();
    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Icon(
          widget.icon,
          size: widget.size,
          color: Colors.black,
        ),
        Positioned(
          right: 0.0,
          child: Container(
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(6),
            ),
            constraints: BoxConstraints(
              minWidth: 11,
              minHeight: 11,
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 1),
              child:Text(
                '$counter',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
