import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nishant/modal/User.dart';
import 'package:nishant/modal/details.dart';
import 'package:nishant/services/authentication.dart';
import 'package:nishant/shared/decoration.dart';
import 'package:nishant/shared/header.dart';
import 'package:nishant/shared/loading.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
final DateTime timestamp=DateTime.now();
bool isLoading=false;
Authentication _auth=Authentication();
class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  final  databaseReference = Firestore.instance;
TextEditingController titleController=TextEditingController();
TextEditingController descriptionController=TextEditingController();
TextEditingController locationController=TextEditingController();
TextEditingController addressController=TextEditingController();
TextEditingController contactController=TextEditingController();
  List<Asset> images = List<Asset>();
  Asset asset;
  String _error;
  String _title;
  String _location;
  String address;
  String  contact;
  String _description;
  List<Asset> resultList;
    String name;
    String dp;
  int _sec=0;
bool ngoOption=false;
  String dropdownValue = 'Feed';
  var now = new DateTime.now();
List<String> urls=new List();
String url;
  getUserLocation() async{
  Position position=await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  List<Placemark> placemarks= await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
  Placemark placemark=placemarks[0];
  String formattedaddress="${placemark.locality},${placemark.country},";
  locationController.text=formattedaddress;
  }
   final format = DateFormat("yyyy-MM-dd HH:mm");
//for showing alert after the uploading
 void _showDialog(String info,String infotitle) {
    // flutter defined function
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("$infotitle"),
          content: new Text('$info uploaded'),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok",style: TextStyle(color: Colors.green),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

void saveImagetofirebase(){
  for ( var imageFile in resultList) {
         saveImage(imageFile).then((downloadUrl) {
            // Get the download URL
            url=downloadUrl.toString();
            urls.add(url);
       //     print(downloadUrl.toString());
         }).catchError((err) {
           print(err);
         });
    }
    uploadtofirebase();
}
   Future saveImage(Asset asset) async {
  String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  ByteData byteData = await asset.getByteData(quality: 30);
  List<int> imageData = byteData.buffer.asUint8List();
  StorageReference ref = FirebaseStorage.instance.ref().child(fileName);
  
  StorageUploadTask uploadTask = ref.putData(imageData);

    return  (await uploadTask.onComplete).ref.getDownloadURL();
     
}
 

  void uploadtofirebase() async{
             FirebaseUser currentUser=await  _auth.getCurrentUser();
    if(locationController.text.length<1){
      getUserLocation();
    }
         setState(() {
           isLoading=true;
         });
    if(_title.trim().length<1){

    }
    else{      
    resultList.length<3?_sec=10:_sec=15;
    print(resultList.length);
    Timer(Duration(seconds: _sec), ()  {
      
      var data={
        "title":_title,
        "description":_description,
        "date":DateFormat("dd-MM-yyyy").format(now),
        "time":timestamp,
        "images":urls,
        "location":locationController.text,
        'name':name,
        'userPic':dp
      };

          String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          String collec;
          if(dropdownValue=='Feed'){
databaseReference.collection("data").document(fileName).setData(data).whenComplete((){

         _showDialog("successfully ","Success");
          }).then((val){
            titleController.clear();
         descriptionController.clear();
         setState(() {
           images=[];
           isLoading=false;
         });
databaseReference.collection("posts").document(currentUser.uid).collection("usersPosts").document(fileName).setData(data);});
          }else{
databaseReference.collection("ngo").document(fileName).setData(data).whenComplete((){

         _showDialog("successfully ","Success");
          }).then((val){
            titleController.clear();
         descriptionController.clear();
         setState(() {
           images=[];
           isLoading=false;
         });
databaseReference.collection("posts").document(currentUser.uid).collection("usersPosts").document(fileName).setData(data);});
          }
           
  });

      setState(() {
      url="";
      urls.clear();
    });
    }
  }

 Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        asset = images[index];
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: AssetThumb(
            asset: asset,     
            width: 300,
            height: 300,
          ),
        );
      }),
    );
    setState(() {
      asset:asset;
    });
  }

  Future<void> loadAssets() async {

    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
      );
    }catch (e) {
      error = "this is error";
    }
    if (!mounted) return;

    setState(() {
      images = resultList;
      resultList=resultList;
      if (error == null) _error = 'No Error Dectected';
    });
  }
  
  @override
  Widget build(BuildContext context) {
    
    print(dropdownValue);
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
     return isLoading?Loading():Scaffold(
       appBar: header(context,titleText: "upload"),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                      child: TextField(
                                  controller: titleController,
                                  onChanged: (value) {
                                    _title = value.trim();
                                    setState(() {
                                      _title=_title;
                                    });
                                  },
                                  decoration: textInputDecoration.copyWith(hintText: 'Title'),
                      ),
                    ),
                     Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                       child: Scrollbar(
                                          child: new SingleChildScrollView(
                                              scrollDirection: Axis.vertical,
                                              reverse: true,
                                              child: new TextField(
                                                controller: descriptionController,
                                                maxLines: null,
                                                onChanged: (value) {
                                                _description = value.trim();
                                                setState(() {
                                                  _description=_description;
                                                });
                                                  },
                                  decoration: textInputDecoration.copyWith(hintText: 'Description'),
                                ),
                                          )
                                                ),
                     ), 
                     Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                       child: TextField(
                                  controller: locationController,
                                  onChanged: (value) {
                                    _location = value.trim();
                                    setState(() {
                                      _location=_location;
                                    });
                                  },
                                  decoration: textInputDecoration.copyWith(hintText: 'Location'),
                                  ),
                     ),
                     Row(
                                  children: <Widget>[
                                Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                                  child: FlatButton.icon(
                                    onPressed: loadAssets,
                                    icon: Icon(Icons.add_a_photo),
                                    label: Text('Choose Photo'),
                                  ),
                                    
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30,vertical: 8),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text('Want the post to be on ',
                                        style: TextStyle(
                                          fontSize: 15
                                        ),
                                        ),
                                        SizedBox(width: 40,),
                                DropdownButton<String>(
                                    value: dropdownValue,
                                    elevation: 16,
                                    style: TextStyle(
                                      color: Colors.black
                                    ),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        dropdownValue = newValue;
                                        if(dropdownValue=='Events'){
                                          ngoOption=true;
                                        }else{
                                          ngoOption=false;
                                        }
                                      });
                                    },
                                    items: <String>['Feed','Events']
                                      .map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      })
                                      .toList(),
                                  ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              ngoOption? 
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                                      child: TextField(
                                                  controller: contactController,
                                                  onChanged: (value) {
                                                    contact = value.trim();
                                                    setState(() {
                                                      contact=contact;
                                                    });
                                                  },
                                                  decoration:textInputDecoration.copyWith(hintText: 'Contact'),
                                                  ),
                                    ):SizedBox(height: 0,),
                                    ngoOption? 
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                                      child: TextField(
                                                  controller: addressController,
                                                  onChanged: (value) {
                                                    address = value.trim();
                                                    setState(() {
                                                      address=address;
                                                    });
                                                  },
                                                  decoration: textInputDecoration.copyWith(hintText: 'Address'),
                                                  ),
                                    ):SizedBox(height: 0,),
                                     Padding(
                                       padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                                       child:  ngoOption? DateTimeField(
                                         decoration: textInputDecoration.copyWith(hintText: "Select event's date"),
                                        format: format,
                                        onShowPicker: (context, currentValue) async {
                                          final date = await showDatePicker(
                                              context: context,
                                              firstDate: DateTime(1900),
                                              initialDate: currentValue ?? DateTime.now(),
                                              lastDate: DateTime(2100));
                                          if (date != null) {
                                            final time = await showTimePicker(
                                              context: context,
                                              initialTime:
                                                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                                            );
                                            return DateTimeField.combine(date, time);
                                          } else {
                                            return currentValue;
                                          }
                                        },
                                ):SizedBox(width: 10,),
                                     ),  
                              SizedBox(height: 10,),
                              Container(
                                height: 50.0,
                                width: 350.0,
                                child: Material(
                                  
                                  borderRadius: BorderRadius.circular(20.0),
                                  shadowColor: Color(0xff005AFE),
                                  color: Color(0xff003CAA),
                                  elevation: 5.0,
                                  child:InkWell(
                                     onTap:saveImagetofirebase,
                                     
                                //  onTap: uploadtofirebase,
                              child: Center(
                                  child: Text(
                                    'POST',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Monst',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ),
                              ),
                              ),
                            ),
                  ],
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 300,
                    child: buildGridView(),
                  ),
                )
        ],
      )
          )
        ]
      )
     );
  }
}

class BasicDateField extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Basic date field (${format.pattern})'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
      ),
    ]);
  }
}

class BasicTimeField extends StatelessWidget {
  final format = DateFormat("HH:mm");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Basic time field (${format.pattern})'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          return DateTimeField.convert(time);
        },
      ),
    ]);
  }
}
