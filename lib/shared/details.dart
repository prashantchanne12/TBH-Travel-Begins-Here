import 'package:flutter/material.dart';
import 'package:nishant/firebase/food_api.dart';
import 'package:nishant/firebase/food_notifier.dart';
import 'package:nishant/services/authentication.dart';
import 'package:nishant/shared/header.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  final String title;
  final int ind;
  final dynamic images;
  final String location;
  final String description;
  final String name;
  final String userPic;
  Details({this.title,this.ind,this.images, this.location, this.description,this.name,this.userPic});
  @override
  _DetailsState createState() => _DetailsState();

}
Authentication _auth=Authentication();
class _DetailsState extends State<Details> {
  @override
  void initState() {
    // TODO: implement initState
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context, listen: false);
    getFoods(foodNotifier);
    super.initState();
  }
  _showImage(BuildContext context,String image){
        showDialog(
          context: context,
          builder: (_)=>Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    width: double.infinity,
                    child: Image(
                      image: NetworkImage(
                        image,
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.close),
                      onPressed: ()=>Navigator.pop(context),
                    ),
                  ],
                )
              ],
            ),
          )
        ); 
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context,isAppTitle: false,titleText: "Home"),
        body: Container(
      child: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap:()=>_showImage(context,widget.images),
              child:Container(
              height: 500,
              width: double.infinity,
              child: Image.network(
                widget.images,
                fit: BoxFit.cover,
              ),
              )
            ),
            Padding(
              padding: EdgeInsets.only(top: 380.0),
              child: Container(
                width: double.infinity,
                child: Material(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45.0),
                    topRight: Radius.circular(45.0),
                  ),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(top: 35, left: 35.0),
                            child: Icon(
                              Icons.location_on,
                              color: Colors.blue,
                              size: 17.0,
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(top: 35, left: 5.0),
                            child: Text(
                              widget.location,
                              style: TextStyle(
                                fontFamily: 'Lato',
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                                fontSize: 17.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding:
                            EdgeInsets.only(top: 10, left: 35.0, right: 35.0),
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            fontFamily: 'Lato',
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20.0, left: 35.0),
                        child: Row(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.network(
                                widget.userPic,
                                height: 60,
                                width: 60,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 15.0),
                              alignment: Alignment.topLeft,
                              child: Text(
                                widget.name,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: 25.0, left: 35.0, right: 35.0, bottom: 25.0),
                        child: Text(
                          widget.description,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20.0,
                            height: 1.6,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    ),

      );
  }
    
  }
