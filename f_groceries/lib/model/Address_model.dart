
class address {

  final int status;
  final String message;
  final List<Data> data;

  address({this.status,this.message,this.data});

  factory address.fromJson(Map<String, dynamic> parsedJson){

    var list = parsedJson['images'] as List;
    print(list.runtimeType);
    List<Data> dataList = list.map((i) => Data.fromJson(i)).toList();


    return address(
        status: parsedJson['status'],
        message: parsedJson['message'],
        data: dataList

    );
  }

}

class Data {

  final int id ;
  final String name;
  final String mobilenumber;
  final String address;
  final String city;
  final String distric;
  final String state;
  final String pincode;

  Data({this.id, this.name, this.mobilenumber, this.address, this.city,
      this.distric, this.state, this.pincode});

  factory Data.fromJson(Map<String,dynamic> parsedJson){
    return Data(
      id: parsedJson['id'],
      name: parsedJson['name'],
      mobilenumber: parsedJson['mobilenumber'],
      address: parsedJson['address'],
      city: parsedJson['city'],
      distric: parsedJson['distric'],
        state: parsedJson['state'],
        pincode: parsedJson['pincode']
    );
  }


}

