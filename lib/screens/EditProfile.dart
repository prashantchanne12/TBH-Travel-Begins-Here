import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nishant/modal/User.dart';
import 'package:nishant/modal/Username.dart';
import 'package:nishant/modal/details.dart';
import 'package:nishant/services/authentication.dart';
import 'package:nishant/services/database.dart';
import 'package:nishant/shared/header.dart';
import 'package:nishant/shared/settings.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:intl/intl.dart';
class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    
   showEditDialog()
    {
       showModalBottomSheet(isScrollControlled: true,context: context,builder: (context)
            {
              return Settings();
            });
    }
    String name;
    String dp;
      File sampleImage;
  Authentication _auth=Authentication();
      final user=Provider.of<User>(context);
   final details=Provider.of<List<Details>>(context);
        details.forEach((val)
        {
          if(val.uid==user.uid)
          {
            setState(() {
              name=val.name;
              dp=val.profilepic;
            });
          }
        });
    return StreamBuilder<UserName>(
      stream: DatabaseServices(uid: user.uid).userName,
      builder: (context, snapshot) {
   Future getImage()async
{
      var tempImage=await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        sampleImage=tempImage;
      });
      String nameofPhoto=basename(sampleImage.path);
      final StorageReference firebaseStorageRef=await FirebaseStorage.instance.ref().child(
                    'profilepics/${nameofPhoto}.jpg'
                  );
      final StorageUploadTask task=await firebaseStorageRef.putFile(sampleImage);

      StorageTaskSnapshot taskSnapshot=await task.onComplete;
      //getting the storages name
      String downloadUri =await taskSnapshot.ref.getDownloadURL();
      //updating the data
            UserName user=snapshot.data;
        await DatabaseServices(uid: user.uid).updateUserData(
                              name??user.name, 
                              downloadUri,
                              user.location
                              );
              }
        if(snapshot.hasData){
        return Scaffold(
          appBar: header(context,titleText: "Profile"),
          body: Stack(
            children: <Widget>[
              ClipPath(
                child: Container(color: Colors.redAccent.withOpacity(0.4),),
                clipper: getClipper(),
              ),
                    Positioned(
                      width: 350.0,
                      top: MediaQuery.of(context).size.height/6,
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              image: DecorationImage(
                                image: NetworkImage(dp),
                                fit: BoxFit.cover
                              ),
                              borderRadius: BorderRadius.circular(0.0),
                              boxShadow:[
                                BoxShadow(blurRadius: 7.0,color: Colors.pink,spreadRadius: 0)
                              ]
                            ),
                          ),
                          SizedBox(height:30,),
                          Text(name,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Mono'
                          ),
                          ),
                          SizedBox(height: 60.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center
                            ,children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 35,width: 95,
                              child: Material(
                                borderRadius: BorderRadius.circular(2),
                                shadowColor: Colors.pink,
                                color: Colors.pink,
                                elevation: 7.0,
                                child: GestureDetector(
                                  onTap:
                                      getImage,
                                  child: Center(
                                    child: Text('Change Dp',
                                    style: TextStyle(
                                      fontFamily: 'Mono',
                                      color: Colors.white
                                    ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 35,width: 95,
                              child: Material(
                                borderRadius: BorderRadius.circular(2),
                                shadowColor: Colors.redAccent,
                                color: Colors.pink,
                                elevation: 7.0,
                                child: GestureDetector(
                                  onTap: (){    
                                   showEditDialog();
                                  },
                                  child: Center(
                                    child: Text('Edit Name',
                                    style: TextStyle(
                                      fontFamily: 'Mono',
                                      color: Colors.white
                                    ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 35,width: 95,
                              child: Material(
                                borderRadius: BorderRadius.circular(2),
                                shadowColor: Colors.redAccent,
                                color: Colors.pink,
                                elevation: 7.0,
                                child: GestureDetector(
                                  onTap: () async{    
                                         _auth.signOut();
                                  },
                                  child: Center(
                                    child: Text('Logout',
                                    style: TextStyle(
                                      fontFamily: 'Mono',
                                      color: Colors.white
                                    ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          ],)
                          
                        ],
                      ),
                    )
            ],
          )
        );

        }
        else{
          return Scaffold(
            appBar: header(context,titleText: "Profile"),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('please login to See profile'),
                    RaisedButton(
                      onPressed:()=> _auth.signOut(),
                      child: Text('Login'),
                    )
                  ],
                ),
            ),
          );
        }
      }
    );
  }
}

class getClipper extends CustomClipper<Path>
{
  @override
  Path getClip(Size size)
  {
    var path=new Path();
    path.lineTo(0.0, size.height/2.2);
    path.lineTo(size.width+224, 0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper)
  {
    return true;
  }
}