import 'package:flutter/material.dart';

class Constants{
    static String consumerKey = ""; // woocommerce consumerKey
    static String consumerSecret = ""; // woocommerce consumerSecret
 
    static String razorpay_key_id = ""; 
    static String razorpay_key_secret = "";

    static String baseURL = "https://widle.studio";

    static String loginURL = "$baseURL/wp-json/jwt-auth/v1/token";
    static String getIDURL = "$baseURL/wp-json/testone/loggedinuser";
    static String mediaURL = "$baseURL/wp-json/wp/v2/media/";


    static Color primary = Colors.black;
    static Color bG = Colors.white;
    static Color accent = Colors.orange;
}