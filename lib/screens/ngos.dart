import 'package:flutter/material.dart';
import 'package:nishant/firebase/ngo_api.dart';
import 'package:nishant/firebase/ngo_notifier.dart';
import 'package:nishant/services/authentication.dart';
import 'package:nishant/shared/details.dart';
import 'package:nishant/shared/header.dart';
import 'package:provider/provider.dart';

class Ngos extends StatefulWidget {

  @override
  _NgosState createState() => _NgosState();

}
Authentication _auth=Authentication();
class _NgosState extends State<Ngos> {


  @override
  void initState() {
    // TODO: implement initState
    NgoNotifier ngoNotifier = Provider.of<NgoNotifier>(context, listen: false);
    getNgos(ngoNotifier);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    NgoNotifier ngoNotifier = Provider.of<NgoNotifier>(context); 
     Future<void> _refreshList() async {
      getNgos(ngoNotifier);
    }
     return Scaffold(
      appBar: header(context,isAppTitle: false,titleText: "Events"),
      body:new RefreshIndicator(
        child:ListView.builder(
                itemCount: ngoNotifier.ngoList.length,
                itemBuilder: (context,index){    
                  var image; 
                  ngoNotifier.ngoList[index].image.map(
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
                                  MaterialPageRoute(builder: (context) => Details(title: ngoNotifier.ngoList[index].title,ind:index,images:image,
                                  description: ngoNotifier.ngoList[index].description,
                                  location: ngoNotifier.ngoList[index].location,
                                  name:ngoNotifier.ngoList[index].name,
                                  userPic:ngoNotifier.ngoList[index].userPic
                                  ))),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Container(
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
                                ngoNotifier.ngoList[index].title,
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Padding(padding: const EdgeInsets.all(2.0)),
                              Text(
                                ngoNotifier.ngoList[index].description,
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
