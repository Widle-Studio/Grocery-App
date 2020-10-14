
import 'package:flutter/material.dart';

class IconBadge_notification extends StatefulWidget {

  final int counter;

  IconBadge_notification({Key key, @required this.counter})
      : super(key: key);

//  static updateCount(BuildContext context) {
//    final _IconBadgeState state =
//    context.ancestorStateOfType(const TypeMatcher<_IconBadgeState>());
//    state.updateCount();
//  }

  @override
  _IconBadgeState createState() => _IconBadgeState();
}

class _IconBadgeState extends State<IconBadge_notification> {

  int counter = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Icon(
          Icons.notifications,
          size: 25,
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
                '${widget.counter}',
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
