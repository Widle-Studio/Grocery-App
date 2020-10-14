class Wishlist{

  int _id;
  int _productId;
  String _name;
  String _img;
  // var _images;
  double _regularPrice;
  double _price;
  int _quantity;
  String _rating;
  String _desc;
  String _link;
  int rateAmount;
  int cat;
  String _serve_quantity;


  Wishlist(this._productId,
      this._name,
      this._img,
      // this._images,
      this._regularPrice,
      this._price,
      this._quantity,
      this._rating,
      this._desc,
      this._link,
      this.rateAmount,
      this.cat,
      this._serve_quantity,);

  Wishlist.map(dynamic obj){
    this._id = obj['id'];
    this._productId = obj['productId'];
    this._name = obj['name'];
    this._img = obj['img'];
    // this._images = obj['images'];
    this._price = obj['price'];
    this._quantity = obj['quantity'];
    this._link = obj['link'];

  }

  String get link => _link;
  int get quantity => _quantity;
  double get price => _price;
  String get img => _img;
  // List get images => _images;
  String get name => _name;
  int get productId => _productId;
  int get id => _id;
  double get regularPrice => _regularPrice;
  String get rating => _rating;
  String get desc => _desc;
  String get serve_quantity => _serve_quantity;


  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    if (id != null) {
      map['id'] = _id;
    }
    map['productId'] = _productId;
    map['name'] = _name;
    map['img'] = _img;
    // map['images'] = _images;
    map['price'] = _price;
    map['quantity'] = _quantity;
    map['link'] = _link;
    map['regularPrice'] = _regularPrice;
    map['rating'] = _rating;
    map['desc'] = _desc;
    map['rateAmount'] = rateAmount;
    map['cat'] = cat;
    map['serve_quantity'] = _serve_quantity;

    return map;
  }

  Wishlist.fromMap(Map<String, dynamic> map){
    this._id = map['id'];
    this._productId = map['productId'];
    this._name = map['name'];
    this._img = map['img'];
    // this._images = map['images'];
    this._price = map['price'];
    this._quantity = map['quantity'];
    this._link = map['link'];
    this._regularPrice = map['regularPrice'];
    this._rating = map['rating'];
    this._desc = map['desc'];
    this.rateAmount = map['rateAmount'];
    this.cat = map['cat'];
    this._serve_quantity = map['serve_quantity'];
  }
}