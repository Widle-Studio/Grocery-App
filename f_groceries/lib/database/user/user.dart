class User{

  int _id;
  String _username;
  String _email;
  String _password;
  String _token;
  int _userId;



  User(this._username, this._email, this._password, this._token, this._userId);

  User.map(dynamic obj){
    this._id = obj['id'];
    this._username = obj['username'];
    this._email = obj['email'];
    this._password = obj['password'];
    this._token = obj['token'];
    this._userId = obj['userId'];
  }

  int get id => _id;
  String get username => _username;
  String get email => _email;
  String get password => _password;
  String get token => _token;
  int get userId => _userId;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    if (id != null) {
      map['id'] = _id;
    }
    map['username'] = _username;
    map['email'] = _email;
    map['password'] = _password;
    map['token'] = _token;
    map['userId'] = _userId;

    return map;
  }

  User.fromMap(Map<String, dynamic> map){
    this._id = map['id'];
    this._username = map['username'];
    this._email = map['email'];
    this._password = map['password'];
    this._token = map['token'];
    this._userId = map['userId'];
  }

}