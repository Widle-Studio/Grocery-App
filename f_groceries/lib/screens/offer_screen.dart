
import 'package:flutter/material.dart';

class OfferScreen extends StatefulWidget {


  const OfferScreen({Key key, }) : super(key: key);


  @override
  State<StatefulWidget> createState() => offerScreen();
}

class offerScreen extends State<OfferScreen> {

  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: new AppBar(
          title: Text('Offers Screen',style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
                
        ),
        body: null
        );
        
                } 

  }
