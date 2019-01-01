import 'package:f_groceries/Cart_Screen.dart';
import 'package:f_groceries/item_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart';

class Item_Screen extends StatefulWidget {
  final String toolbarname;

  Item_Screen({Key key, this.toolbarname}) : super(key: key);

  @override
  State<StatefulWidget> createState() => item(toolbarname);
}

class Item {
  final String itemname;
  final String imagename;
  final String itmprice;

  Item({this.itemname, this.imagename, this.itmprice});
}

class item extends State<Item_Screen> {
  List list = ['12', '11'];
  bool checkboxValueA = true;
  bool checkboxValueB = false;
  bool checkboxValueC = false;
  VoidCallback _showBottomSheetCallback;
  List<Item> itemList = <Item>[
    Item(imagename: 'images/apple.jpg', itemname: 'Apple', itmprice: '\$10'),
    Item(imagename: 'images/tomato.jpg', itemname: 'Tomato', itmprice: '\$15'),
    Item(imagename: 'images/lemons.jpg', itemname: 'Lemon', itmprice: '\$25'),
    Item(
        imagename: 'images/kiwi.jpg', itemname: 'Kiwi Fruit', itmprice: '\$10'),
    Item(imagename: 'images/guava.jpg', itemname: 'Guava', itmprice: '\$15'),
    Item(imagename: 'images/grapes.jpg', itemname: 'Grapes', itmprice: '\$25'),
    Item(
        imagename: 'images/pineapple.jpg',
        itemname: 'Pineapple',
        itmprice: '\$18'),
    Item(imagename: 'images/lemons.jpg', itemname: 'Lemon', itmprice: '\$25'),
    Item(imagename: 'images/tomato.jpg', itemname: 'Tomato', itmprice: '\$15'),
    Item(
        imagename: 'images/kiwi.jpg', itemname: 'Kiwi Fruit', itmprice: '\$10'),
    Item(imagename: 'images/apple.jpg', itemname: 'Apple', itmprice: '\$10'),
    Item(imagename: 'images/grapes.jpg', itemname: 'Grapes', itmprice: '\$25'),
    Item(imagename: 'images/grapes.jpg', itemname: 'Grapes', itmprice: '\$25'),
  ];
 // String toolbarname = 'Fruiys & Vegetables';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String toolbarname;

  item(this.toolbarname);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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

    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    final Orientation orientation = MediaQuery.of(context).orientation;
    return new Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(_backIcon()),
          alignment: Alignment.centerLeft,
          tooltip: 'Back',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(toolbarname),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            tooltip: 'Search',
            icon: const Icon(Icons.search),
            onPressed: () async {
              final int selected = await showSearch<int>(
                context: context,
                //delegate: _delegate,
              );

            },
          ),
          IconButton(
            tooltip: 'Sort',
            icon: const Icon(Icons.filter_list),
            onPressed: () {

              _showBottomSheet();
            }

          ),
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
                child: Stack(
                  children: <Widget>[
                    new IconButton(
                        icon: new Icon(
                          Icons.shopping_cart,
                          color: Colors.black,
                        ),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> Cart_screen()));
                        }),
                    list.length == 0
                        ? new Container()
                        : new Positioned(
                        child: new Stack(
                          children: <Widget>[
                            new Icon(Icons.brightness_1,
                                size: 20.0, color: Colors.orange.shade500),
                            new Positioned(
                                top: 4.0,
                                right: 5.5,
                                child: new Center(
                                  child: new Text(
                                    list.length.toString(),
                                    style: new TextStyle(
                                        color: Colors.white,
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            // height: 500.0,
            child: Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: (itemWidth / itemHeight),
                controller: new ScrollController(keepScrollOffset: false),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(4.0),
                children: itemList.map((Item photo) {
                  return TravelDestinationItem(
                    destination: photo,

                  );
                }).toList(),
              ),
            ),
          )
        ],
      ),

      /* return new GestureDetector(

                  onTap: (){},
                  child: Container(
                    height: 360.0,
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Column(
                       // crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          new Container(

                         child: SizedBox(
                        height: 184.0,
                           child:Image.asset(
                                    itemList[index].imagename,
                                    fit: BoxFit.contain,
                                  ),
                          ),
                          ),
                          new Container(

                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text(itemList[index].itemname,style: TextStyle(color: Colors.black87,fontSize: 17.0,fontWeight: FontWeight.bold),),
                                Text(itemList[index].itemname,style: TextStyle(color: Colors.black38,fontSize: 17.0),)
                              ],
                            ),
                          )


                          // description and share/explore buttons

                        ],

                      ),

                    ),
                  ),
                );*/
    );
  }


  _verticalDivider() =>
      Container(
        padding: EdgeInsets.all(2.0),
      );

  _verticalD() =>
      Container(
        margin: EdgeInsets.only(left: 10.0, right: 0.0, top: 0.0, bottom: 0.0),
      );


  bool a = true;
  String mText = "Press to hide";
  double _lowerValue = 1.0;
  double _upperValue = 100.0;

  void _visibilitymethod() {
    setState(() {
      if (a) {
        a = false;
        mText = "Press to show";
      } else {
        a = true;
        mText = "Press to hide";
      }
    });
  }

  List<RangeSliderData> rangeSliders;
  List<Widget> _buildRangeSliders() {
    List<Widget> children = <Widget>[];
    for (int index = 0; index < rangeSliders.length; index++) {
      children
          .add(rangeSliders[index].build(context, (double lower, double upper) {
        // adapt the RangeSlider lowerValue and upperValue
        setState(() {
          rangeSliders[index].lowerValue = lower;
          rangeSliders[index].upperValue = upper;
        });
      }));
      // Add an extra padding at the bottom of each RangeSlider
      children.add(new SizedBox(height: 8.0));
    }

    return children;
  }
  void _showBottomSheet() {
    setState(() { // disable the button
      _showBottomSheetCallback = null;
    });
    _scaffoldKey.currentState.showBottomSheet<Null>((BuildContext context) {
      final ThemeData themeData = Theme.of(context);
      return Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: themeData.disabledColor))
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: <Widget>[

              Row(

                crossAxisAlignment: CrossAxisAlignment.center,

                children: <Widget>[

                  IconButton(icon: const Icon(Icons.close), onPressed: (){
                    Navigator.pop(context);
                  }),
                  Text('FILTER/SORTING',
                    style: TextStyle(fontSize: 12.0, color: Colors.black26),),
                  _verticalD(),
                  OutlineButton(
                      borderSide: BorderSide(color: Colors.amber.shade500),
                      child: const Text('CLEAR'),
                      textColor: Colors.amber.shade500,
                      onPressed: () {},
                      shape: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      )),

                  _verticalD(),
                  OutlineButton(
                      borderSide: BorderSide(color: Colors.amber.shade500),
                      child: const Text('APPLY'),
                      textColor: Colors.amber.shade500,
                      onPressed: () {},
                      shape: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      )),

                ],
              ),

              Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Sort', style: TextStyle(color: Colors.black,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold),
                      ),

                    ],
                  )
              ),
              Container(
                  height: 115.0,
                  margin: EdgeInsets.only(left: 7.0,top: 5.0),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Container(
                        child: Card(
                          elevation: 3.0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: <Widget>[
                              new Column(
                                children: <Widget>[
                                  new Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: <Widget>[
                                        new Text(
                                          'LOWEST',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        _verticalDivider(),
                                        new Text(
                                          'PRICE',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 13.0,
                                              letterSpacing: 0.5),
                                        ),
                                        _verticalDivider(),
                                        new Text(
                                          'FIRST',
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

                            ],
                          ),
                        ),
                      ),

                      Container(
                        child: Card(
                          elevation: 3.0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: <Widget>[
                              new Column(


                                children: <Widget>[
                                  new Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: <Widget>[
                                        new Text(
                                          'HEGHEST',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        _verticalDivider(),
                                        new Text(
                                          'PRICE',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 13.0,
                                              letterSpacing: 0.5),
                                        ),
                                        _verticalDivider(),
                                        new Text(
                                          'FIRST',
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

                            ],
                          ),
                        ),
                      ),

                      Container(
                        child: Card(
                          elevation: 3.0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: <Widget>[
                              new Column(


                                children: <Widget>[
                                  new Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: <Widget>[
                                        new Text(
                                          'POPULER',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        _verticalDivider(),
                                        new Text(
                                          'PRICE',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 13.0,
                                              letterSpacing: 0.5),
                                        ),
                                        _verticalDivider(),
                                        new Text(
                                          'FIRST',
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

                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: Card(
                          elevation: 3.0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: <Widget>[
                              new Column(


                                children: <Widget>[
                                  new Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: <Widget>[
                                        new Text(
                                          'NEWEST',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        _verticalDivider(),
                                        new Text(
                                          'PRICE',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 13.0,
                                              letterSpacing: 0.5),
                                        ),
                                        _verticalDivider(),
                                        new Text(
                                          'FIRST',
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

                            ],
                          ),
                        ),
                      ),Container(
                        child: Card(
                          elevation: 3.0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: <Widget>[
                              new Column(


                                children: <Widget>[
                                  new Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: <Widget>[
                                        new Text(
                                          'BEST',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        _verticalDivider(),
                                        new Text(
                                          'PRICE',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 13.0,
                                              letterSpacing: 0.5),
                                        ),
                                        _verticalDivider(),
                                        new Text(
                                          'FIRST',
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

                            ],
                          ),
                        ),
                      ),



                    ],
                  )
              ),
              _verticalDivider(),
              Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Filter', style: TextStyle(color: Colors.black,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold),
                      ),
                      _verticalDivider(),
                      Text('PRICE', style: TextStyle(color: Colors.black54,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                      ),

                    ],
                  )
              ),

      /*  Container(
          padding: const EdgeInsets.only(top: 50.0, left: 10.0, right: 10.0),
          child: new Column(
              children: <Widget>[]
                ..add(
                  //
                  // Simple example
                  //
                  new RangeSlider(
                    min: 0.0,
                    max: 100.0,
                    lowerValue: _lowerValue,
                    upperValue: _upperValue,
                    divisions: 5,
                    showValueIndicator: true,
                    valueIndicatorMaxDecimals: 1,
                    onChanged: (double newLowerValue, double newUpperValue) {
                      setState(() {
                        _lowerValue = newLowerValue;
                        _upperValue = newUpperValue;
                      });
                    },
                    onChangeStart:
                        (double startLowerValue, double startUpperValue) {
                      print(
                          'Started with values: $startLowerValue and $startUpperValue');
                    },
                    onChangeEnd: (double newLowerValue, double newUpperValue) {
                      print(
                          'Ended with values: $newLowerValue and $newUpperValue');
                    },
                  ),
                )
              // Add some space
                ..add(
                  new SizedBox(height: 24.0),
                )
              //
              // Add a series of RangeSliders, built as regular Widgets
              // each one having some specific customizations
              //
                ..addAll(_buildRangeSliders())),
        ),*/

              _verticalDivider(),
              Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      _verticalDivider(),
                      Text('SELECT OFFER', style: TextStyle(color: Colors.black54,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                      ),

                    ],
                  )
              ),

              Container(
                  height: 80.0,
                  margin: EdgeInsets.only(left: 7.0,top: 5.0),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Container(
                        height:80.0,
                        width: 120.0,
                        child: Card(
                          color: Colors.pink.shade100,
                          elevation: 3.0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: <Widget>[
                              new Column(
                                children: <Widget>[
                                  new Container(
                                    color: Colors.pink.shade100,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: <Widget>[
                                        new Text(
                                          'Buy More,',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        _verticalDivider(),
                                        new Text(
                                          'Save More',
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

                            ],
                          ),
                        ),
                      ),

                      Container(
                        height:80.0,
                        width: 120.0,
                        child: Card(
                          color: Colors.indigo.shade500,
                          elevation: 3.0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: <Widget>[
                              new Column(
                                children: <Widget>[
                                  new Container(

                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: <Widget>[
                                        new Text(
                                          'Special,',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        _verticalDivider(),
                                        new Text(
                                          'Price',
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

                            ],
                          ),
                        ),
                      ),
                      Container(
                        height:80.0,
                        width: 120.0,
                        child: Card(
                          color: Colors.teal.shade200,
                          elevation: 3.0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: <Widget>[
                              new Column(
                                children: <Widget>[
                                  new Container(

                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: <Widget>[
                                        new Text(
                                          'Item of,',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        _verticalDivider(),
                                        new Text(
                                          'The Day',
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

                            ],
                          ),
                        ),
                      ),
                      Container(
                        height:80.0,
                        width: 120.0,
                        child: Card(
                          color: Colors.yellow.shade100,
                          elevation: 3.0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: <Widget>[
                              new Column(
                                children: <Widget>[
                                  new Container(

                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: <Widget>[
                                        new Text(
                                          'Buy 1,,',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        _verticalDivider(),
                                        new Text(
                                          'GET 1 FREE',
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

                            ],
                          ),
                        ),
                      ),



                    ],
                  )
              ),

              _verticalDivider(),
              Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      _verticalDivider(),
                      Text('DISCOUNT', style: TextStyle(color: Colors.black54,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                      ),

                    ],
                  )
              ),

              Container(
                  height: 90.0,
                  margin: EdgeInsets.only(left: 7.0,top: 5.0),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Container(
                        height:80.0,

                        child: Card(
                          color: Colors.white,
                          elevation: 3.0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: <Widget>[
                              new Column(
                                children: <Widget>[
                                  new Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,

                                      children: <Widget>[
                                        new Text(
                                          '10%',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        _verticalDivider(),
                                        new Text(
                                          'OR LESS',
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

                            ],
                          ),
                        ),
                      ),


                      Container(
                        height:80.0,

                        child: Card(
                          color: Colors.white,
                          elevation: 3.0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: <Widget>[
                              new Column(
                                children: <Widget>[
                                  new Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,

                                      children: <Widget>[
                                        new Text(
                                          '20%',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        _verticalDivider(),
                                        new Text(
                                          'OR LESS',
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

                            ],
                          ),
                        ),
                      ),

                      Container(
                        height:80.0,

                        child: Card(
                          color: Colors.white,
                          elevation: 3.0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: <Widget>[
                              new Column(
                                children: <Widget>[
                                  new Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,

                                      children: <Widget>[
                                        new Text(
                                          '30%',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        _verticalDivider(),
                                        new Text(
                                          'OR LESS',
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

                            ],
                          ),
                        ),
                      ),

                      Container(
                        height:80.0,

                        child: Card(
                          color: Colors.white,
                          elevation: 3.0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: <Widget>[
                              new Column(
                                children: <Widget>[
                                  new Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,

                                      children: <Widget>[
                                        new Text(
                                          '40%',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        _verticalDivider(),
                                        new Text(
                                          'OR LESS',
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

                            ],
                          ),
                        ),
                      ),


                    ],
                  )
              ),

              _verticalDivider(),
              Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      _verticalDivider(),
                      Text('AVAILIBILITY', style: TextStyle(color: Colors.black54,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                      ),

                    ],
                  )
              ),
              _verticalDivider(),
              Container(
                  child: Align(
                    alignment: const Alignment(0.0, -0.2),
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                    children: <Widget>[

                      _verticalDivider(),
                      Radio<int>(
                          value: 0,
                          groupValue: radioValue,
                          onChanged: handleRadioValueChanged
                      ),

                      Text('Available for this location', style: TextStyle(color: Colors.black54,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                      ),



                    ],
                  )
                  )
              ),




            ]),
      );
    })
        .closed.whenComplete(() {
      if (mounted) {
        setState(() { // re-enable the button
          _showBottomSheetCallback = _showBottomSheet;
        });
      }
    });
  }

  int radioValue = 0;
  bool switchValue = false;

  void handleRadioValueChanged(int value) {
    setState(() {
      radioValue = value;
    });
  }


}

class TravelDestinationItem extends StatelessWidget {
  TravelDestinationItem({Key key, @required this.destination, this.shape})
      : assert(destination != null),
        super(key: key);

  static const double height = 566.0;
  final Item destination;
  final ShapeBorder shape;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle =
        theme.textTheme.headline.copyWith(color: Colors.white);
    final TextStyle descriptionStyle = theme.textTheme.subhead;

    return SafeArea(
        top: false,
        bottom: false,
        child: Container(
          padding: const EdgeInsets.all(4.0),
          height: height,
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Item_Details()));
            },

          child: Card(
            shape: shape,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // photo and title
                SizedBox(
                  height: 150.0,
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Image.asset(
                          destination.imagename,
                          // package: destination.assetPackage,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                       // padding: EdgeInsets.all(5.0),
                        child: IconButton(icon: const Icon(Icons.favorite_border), onPressed: (){

                        }),
                      ),
                    ],
                  ),

                ),
                // description and share/explore buttons
                Divider(),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                    child: DefaultTextStyle(
                      style: descriptionStyle,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // three line description
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              destination.itemname,
                              style: descriptionStyle.copyWith(
                                  color: Colors.black87),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              destination.itmprice,
                              style: descriptionStyle.copyWith(
                                  color: Colors.black54),
                            ),
                          ),
                          // Text(destination.description[1]),
                          // Text(destination.description[2]),
                        ],
                      ),
                    ),
                  ),
                ),
                // share, explore buttons
                Container(
                  alignment: Alignment.center,
                  child: OutlineButton(
                      borderSide: BorderSide(color: Colors.amber.shade500),
                      child: const Text('Add'),
                      textColor: Colors.amber.shade500,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Item_Details()));
                      },
                      shape: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      )),
                ),
              ],
            ),
          ),
        )
        )
    );



  }



 /* List<RangeSliderData> _rangeSliderDefinitions() {
    return <RangeSliderData>[
      RangeSliderData(
          min: 0.0, max: 100.0, lowerValue: 10.0, upperValue: 100.0),
      RangeSliderData(
          min: 0.0,
          max: 100.0,
          lowerValue: 25.0,
          upperValue: 75.0,
          divisions: 20,
          overlayColor: Colors.red[100]),
      RangeSliderData(
          min: 0.0,
          max: 100.0,
          lowerValue: 10.0,
          upperValue: 30.0,
          showValueIndicator: false,
          valueIndicatorMaxDecimals: 0),
      RangeSliderData(
          min: 0.0,
          max: 100.0,
          lowerValue: 10.0,
          upperValue: 30.0,
          showValueIndicator: true,
          valueIndicatorMaxDecimals: 0,
          activeTrackColor: Colors.red,
          inactiveTrackColor: Colors.red[50],
          valueIndicatorColor: Colors.green),
      RangeSliderData(
          min: 0.0,
          max: 100.0,
          lowerValue: 25.0,
          upperValue: 75.0,
          divisions: 20,
          thumbColor: Colors.grey,
          valueIndicatorColor: Colors.grey),
    ];
  }*/
}

// ---------------------------------------------------
// Helper class aimed at simplifying the way to
// automate the creation of a series of RangeSliders,
// based on various parameters
//
// This class is to be used to demonstrate the appearance
// customization of the RangeSliders
// ---------------------------------------------------
class RangeSliderData {
  double min;
  double max;
  double lowerValue;
  double upperValue;
  int divisions;
  bool showValueIndicator;
  int valueIndicatorMaxDecimals;
  bool forceValueIndicator;
  Color overlayColor;
  Color activeTrackColor;
  Color inactiveTrackColor;
  Color thumbColor;
  Color valueIndicatorColor;
  Color activeTickMarkColor;

  static const Color defaultActiveTrackColor = const Color(0xFF0175c2);
  static const Color defaultInactiveTrackColor = const Color(0x3d0175c2);
  static const Color defaultActiveTickMarkColor = const Color(0x8a0175c2);
  static const Color defaultThumbColor = const Color(0xFF0175c2);
  static const Color defaultValueIndicatorColor = const Color(0xFF0175c2);
  static const Color defaultOverlayColor = const Color(0x290175c2);

  RangeSliderData({
    this.min,
    this.max,
    this.lowerValue,
    this.upperValue,
    this.divisions,
    this.showValueIndicator: true,
    this.valueIndicatorMaxDecimals: 1,
    this.forceValueIndicator: false,
    this.overlayColor: defaultOverlayColor,
    this.activeTrackColor: defaultActiveTrackColor,
    this.inactiveTrackColor: defaultInactiveTrackColor,
    this.thumbColor: defaultThumbColor,
    this.valueIndicatorColor: defaultValueIndicatorColor,
    this.activeTickMarkColor: defaultActiveTickMarkColor,
  });

  // Returns the values in text format, with the number
  // of decimals, limited to the valueIndicatedMaxDecimals
  //
  String get lowerValueText =>
      lowerValue.toStringAsFixed(valueIndicatorMaxDecimals);
  String get upperValueText =>
      upperValue.toStringAsFixed(valueIndicatorMaxDecimals);

  // Builds a RangeSlider and customizes the theme
  // based on parameters
  //
  Widget build(BuildContext context, RangeSliderCallback callback) {
    return new Container(
      width: double.infinity,
      child: new Row(
        children: <Widget>[
          new Container(
            constraints: new BoxConstraints(
              minWidth: 40.0,
              maxWidth: 40.0,
            ),
            child: new Text(lowerValueText),
          ),
          new Expanded(
            child: new SliderTheme(
              // Customization of the SliderTheme
              // based on individual definitions
              // (see rangeSliders in _RangeSliderSampleState)
              data: SliderTheme.of(context).copyWith(
                overlayColor: overlayColor,
                activeTickMarkColor: activeTickMarkColor,
                activeTrackColor: activeTrackColor,
                inactiveTrackColor: inactiveTrackColor,
                thumbColor: thumbColor,
                valueIndicatorColor: valueIndicatorColor,
                showValueIndicator: showValueIndicator
                    ? ShowValueIndicator.always
                    : ShowValueIndicator.onlyForDiscrete,
              ),
              child: new RangeSlider(
                min: min,
                max: max,
                lowerValue: lowerValue,
                upperValue: upperValue,
                divisions: divisions,
                showValueIndicator: showValueIndicator,
                valueIndicatorMaxDecimals: valueIndicatorMaxDecimals,
                onChanged: (double lower, double upper) {
                  // call
                  callback(lower, upper);
                },
              ),
            ),
          ),
          new Container(
            constraints: new BoxConstraints(
              minWidth: 40.0,
              maxWidth: 40.0,
            ),
            child: new Text(upperValueText),
          ),
        ],
      ),
    );
  }
}

