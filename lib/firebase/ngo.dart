class Ngo {
  String title;
  String description;
  List image = [];
  String location;
String name;
String userPic;
  Ngo();
  Ngo.fromMap(Map<String, dynamic> data) {
    
    title = data['title'];
    description = data['description'];
    
     image = data['images'];
    location = data['location'];

name=data['name'];
userPic=data['userPic'];
  }
  Map<String, dynamic> toMap() {
    return {

      'title': title,
      'description': description,
      'image': image,
      'location': location,
      'name':name,
      'userPic':userPic
    };
  }
}