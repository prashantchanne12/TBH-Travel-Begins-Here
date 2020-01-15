import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nishant/modal/Username.dart';
import 'package:nishant/modal/details.dart';

class DatabaseServices{
  final String uid;
  DatabaseServices({this.uid});
    final CollectionReference userCollection=Firestore.instance.collection('users');
Future updateUserData(String name,String profilepic,String location)async{
  return await userCollection.document(uid).setData({
    'uid':uid,
     'name':name,
      'profilephoto':profilepic,
      'uid':uid,
  });
}  
  List<Details> _usersFromSnapshot(QuerySnapshot snapshot)
  {
    return snapshot.documents.map((doc)
    {
      return Details(
        uid: doc.data['uid'],
        name: doc.data['name'],
        profilepic: doc.data['profilephoto'],
        location: doc.data['location']
      );
    }).toList();
  }
Stream<List<Details>> get details
  {
    return userCollection.snapshots().map(_usersFromSnapshot);
  }
  UserName _userNameFromSnapshot(DocumentSnapshot snapshot)
  {
    return UserName(
      uid: uid,
      name: snapshot.data['name'],
      profilepic: snapshot.data['profilephoto'],
      location: snapshot.data['location']
    );
  }
  Stream<UserName> get userName
  {
    return userCollection.document(uid).snapshots().map(_userNameFromSnapshot);

  }  
}