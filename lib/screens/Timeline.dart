import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:nishant/firebase/food_api.dart';
import 'package:nishant/firebase/food_notifier.dart';
import 'package:nishant/modal/User.dart';
import 'package:nishant/services/authentication.dart';
import 'package:nishant/shared/details.dart';
import 'package:nishant/shared/drewer.dart';
import 'package:nishant/shared/header.dart';
import 'package:provider/provider.dart';

class Timeline extends StatefulWidget {

  @override
  _TimelineState createState() => _TimelineState();

}
Authentication _auth=Authentication();
class _TimelineState extends State<Timeline> {


  @override
  void initState() {
    // TODO: implement initState
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context, listen: false);
    getFoods(foodNotifier);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context); 
     Future<void> _refreshList() async {
      getFoods(foodNotifier);
    }
     return Scaffold(
      appBar: header(context,isAppTitle: false,titleText: "Home",isLogout: true),
      body:new RefreshIndicator(
        child:ListView.builder(
                itemCount: foodNotifier.foodList.length,
                itemBuilder: (context,index){    
                  var image; 
                  foodNotifier.foodList[index].image.map(
                    (images){
                      image=images;
                    }
                  ).toList();
                          return  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  left: 15.0,
                ),
                child: GestureDetector(
                  onTap:()=> Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Details(title: foodNotifier.foodList[index].title,ind:index,images:image,
                                  description: foodNotifier.foodList[index].description,
                                  location: foodNotifier.foodList[index].location,
                                  name:foodNotifier.foodList[index].name,
                                  userPic:foodNotifier.foodList[index].userPic,
                                  address: '',
                                  ))),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.red[50],
                          ),
                          margin: EdgeInsets.all(16.0),
                          child: Container(
                            height: 70.0,
                            width: 70.0,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              child: Image.network(
                                      image,
                                  height: 90,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                foodNotifier.foodList[index].title,
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Padding(padding: const EdgeInsets.all(2.0)),
                              Text(
                                foodNotifier.foodList[index].description,
                                maxLines: 3,
                                style: new TextStyle(
                                    fontFamily: 'Lato',
                                    color: Colors.black,
                                    fontSize: 13.0),
                              ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(),
            ],
          ),
        ),
      );
                             
                }
        ),      
                onRefresh: _refreshList,
        ),
      );

    
  }
  
  }

// foodNotifier.foodList[index].title











// Padding(
//                             padding: const EdgeInsets.all(2.0),
//                             child: GestureDetector(
//                                  onTap:()=> Navigator.push(
//                                   context,
//                                   MaterialPageRoute(builder: (context) => Details(title: foodNotifier.foodList[index].title,ind:index,images:image,
//                                   description: foodNotifier.foodList[index].description,
//                                   location: foodNotifier.foodList[index].location,
//                                   name:foodNotifier.foodList[index].name,
//                                   userPic:foodNotifier.foodList[index].userPic
//                                   ))),
//                                  child: Card(
//                                    elevation: 0.7,
//                                    child:ListTile(
//                                    leading: CircleAvatar(
//                                      child: Container(
//                                        height: 80,
//                                        child: ClipOval(
//                                           child: Image.network(
//                                             image,
//                                             fit: BoxFit.cover,
//                                             width: 90.0,
//                                             height: 90.0,
//                                           )
//                                         ),
//                                      ),
//                                    ),
//                                    isThreeLine: true,
//                                    title: Text(foodNotifier.foodList[index].title),
//                                    subtitle: Text('${foodNotifier.foodList[index].description.substring(0,10)}...'),
//                                  ) ,
//                                  ),
//                                ),
//                           );