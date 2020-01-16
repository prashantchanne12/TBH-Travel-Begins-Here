import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:nishant/constants.dart';
import 'package:nishant/screens/nearby_place_details_screen.dart';
import 'package:nishant/services/network.dart';

import '../shared/header.dart';

class NearbyPlacesScreen extends StatefulWidget {
  @override
  _NearbyPlacesScreenState createState() => _NearbyPlacesScreenState();
}

class _NearbyPlacesScreenState extends State<NearbyPlacesScreen> {
  var places = [];

  @override
  void initState() {
    super.initState();
    getPlacesData();
  }

  void getPlacesData() async {
    NetworkHelper networkHelper = NetworkHelper(kPointOfInterest);
    var data = await networkHelper.getJson();
    setState(() {
      places.addAll(data['results']);
    });
    getImageData();
  }

  List<String> newImages = [];
  void getImageData() async {
    List<String> images = [];
    for (int i = 0; i < places.length; i++) {
      NetworkHelper networkHelper = NetworkHelper(
          'https://api.unsplash.com/search/photos?per_page=1&client_id=8488e853780ea3ad56499853e464b82b3b477cb3fde46477dae84bbb2c4b6d29&query=${places[i]['name']}');
      var data = await networkHelper.getJson();
      if (data['total'] != 0) {
        images.add(data['results'][0]['urls']['regular']);
      } else {
        images.add(
            'https://images.unsplash.com/photo-1540750605116-db8607687576?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=60');
      }
    }
    setState(() {
      newImages = images;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: places == null
            ? Center(
                child: SpinKitDualRing(
                  color: Colors.blue,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 60, left: 25, bottom: 10),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Nearby Places',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Lato',
                                letterSpacing: 3.0,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Icon(
                            Icons.location_on,
                            color: Colors.blue[700],
                            size: 26.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 600,
                      child: Swiper(
                        loop: false,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              // open place details screen
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return NearbyPlaceDetails(
                                  place: places[index],
                                  images: newImages[index],
                                );
                              }));
                            },
                            child: Stack(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(35.0),
                                      topRight: Radius.circular(35.0),
                                    ),
                                    child: Container(
                                      height: 500,
                                      child: Image.network(
                                        newImages[index],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(9.0, 400.0, 0.0, 0.0),
                                  child: Container(
                                    height: 160.0,
                                    width: 295.0,
                                    child: Material(
                                      elevation: 1.5,
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(35.0),
                                        topRight: Radius.circular(35.0),
                                        bottomLeft: Radius.circular(35.0),
                                        bottomRight: Radius.circular(35.0),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0,
                                                top: 15.0,
                                                right: 10.0),
                                            child: Container(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                places[index]['name'],
                                                style: TextStyle(
                                                  fontSize: 19.0,
                                                  color: Colors.black,
                                                  fontFamily: 'Monst',
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0,
                                                    top: 10.0,
                                                    right: 10.0),
                                                child: Container(
                                                  alignment: Alignment.topLeft,
                                                  child: RatingBar(
                                                    ignoreGestures: true,
                                                    itemSize: 20.0,
                                                    initialRating: places[index]
                                                            ['rating']
                                                        .toDouble(),
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 4.0),
                                                    itemBuilder: (context, _) =>
                                                        Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    onRatingUpdate: (rating) {
//                                  print(rating);
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0.0, top: 12.0),
                                                child: Container(
                                                  child: Text(
                                                    '${places[index]['rating']}',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 17.0,
                                                      color: Colors.blue,
                                                      fontFamily: 'Monst',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0,
                                                top: 10.0,
                                                right: 10.0),
                                            child: Container(
                                              child: Text(
                                                places[index]
                                                    ['formatted_address'],
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.black54,
                                                  fontFamily: 'Ubuntu',
                                                  fontWeight: FontWeight.w700,
                                                ),
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
                          );
                        },
                        itemCount: newImages.length,
                        viewportFraction: 0.8,
                        scale: 0.9,
                      ),
                    ),
                  ],
                ),
              ));
  }
}
//ListView.builder(
//        itemCount: newImages == null ? 0 : newImages.length,
//        itemBuilder: (BuildContext context, int index) {
//          return GestureDetector(
//            onTap: () {},
//            child: Column(
//              children: <Widget>[
//                Image.network(newImages[index]),
//                SizedBox(
//                  height: 20.0,
//                ),
//                Text(places[index]['name']),
//                SizedBox(
//                  height: 20.0,
//                ),
//                Text(
//                  places[index]['formatted_address'],
//                ),
//              ],
//            ),
//          );
//        },
//      ),
