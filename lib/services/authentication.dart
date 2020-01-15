import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nishant/modal/User.dart';
class Authentication {
  final FirebaseAuth _auth=FirebaseAuth.instance;
  User _userFromFireBase(FirebaseUser user){
    return user !=null? User(uid: user.uid):null;
  }
  Stream<User>  get user{
    return _auth.onAuthStateChanged.map(_userFromFireBase);
  }
  Future userLoginWithUserName(String email,String password)async{
    try{
      AuthResult result=await _auth.signInWithEmailAndPassword(email: email,password: password);
      FirebaseUser user=result.user;
      return _userFromFireBase(user);
    }catch(e){
      return null;
    }
  }
  String location;
  getUserLocation()async{
  Position position=await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  List<Placemark> placemarks= await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
  Placemark placemark=placemarks[0];
  String formattedaddress="${placemark.locality},${placemark.country},";
  location=formattedaddress;
  }
  Future userRegistration(String email,String password,String name)async{
    try{
      AuthResult result=await _auth.createUserWithEmailAndPassword(email: email,password: password);
      FirebaseUser user=result.user;
      CollectionReference hackUser=Firestore.instance.collection('users');
      await getUserLocation();
      hackUser.document(user.uid).setData({
        'uid':user.uid,
        'name':name,
        'profilephoto':'https://i.ya-webdesign.com/images/add-png-to-photo-8.png',
        'location':location
      });
      return _userFromFireBase(user);
    }catch(err){
      print(err);
      return null;
    }
  }
  Future signInAnon()async{
    try{
      AuthResult result=await _auth.signInAnonymously();
      FirebaseUser user=result.user;
      return _userFromFireBase(user);
    }catch(e){
      print('something went wrong');
      return null;
    }
  }
  Future signOut()async{
    try{
      return await _auth.signOut();
    }
    catch(err){
      print("err");
      return null;
    }
  }
   Future getCurrentUser()async{
    FirebaseUser user=await _auth.currentUser();
    return user;
  }
   getAnonymousUser()async{
    FirebaseUser user=await _auth.currentUser();
    return user.isAnonymous;
  }
}