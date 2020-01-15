class Ngo {
  String title;
  String description;
  List image = [];
  String location;
String name;
String userPic;
String contact;
String address;
String eventDate;
  Ngo();
  Ngo.fromMap(Map<String, dynamic> data) {
    
    title = data['title'];
    description = data['description'];
     image = data['images'];
    location = data['location'];
    name=data['name'];
    userPic=data['userPic'];
    contact=data['phone'];
    address=data['address'];
    eventDate=data['timeOfevent'];
  }
  Map<String, dynamic> toMap() {
    return {

      'title': title,
      'description': description,
      'image': image,
      'location': location,
      'name':name,
      'userPic':userPic,
      'contact':contact,
      'address':address,
      'eventDate':eventDate
    };
  }
}