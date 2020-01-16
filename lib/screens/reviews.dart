import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewsScreen extends StatefulWidget {
  final placeDetails;

  ReviewsScreen(this.placeDetails);

  @override
  _ReviewsScreenState createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Colors.white,
        title: Text(
          'Reviews',
          style: TextStyle(
            color: Colors.blue,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: widget.placeDetails == null
            ? 0
            : widget.placeDetails['reviews'].length,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Card(
              elevation: 0.7,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25, top: 10),
                      child: Text(
                        widget.placeDetails['reviews'][i]['author_name'],
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Lato',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 25, top: 15, bottom: 20.0),
                      child: Text(
                        widget.placeDetails['reviews'][i]['text'],
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Lato',
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, bottom: 10.0),
                              child: RatingBar(
                                ignoreGestures: true,
                                itemSize: 16.0,
                                initialRating: widget.placeDetails == null
                                    ? 0.0
                                    : widget.placeDetails['reviews'][i]
                                            ['rating']
                                        .toDouble(),
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
//                                  print(rating);
                                },
                              ),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 5.0, bottom: 5.0),
                              child: Text(
                                widget.placeDetails == null
                                    ? '0.0'
                                    : '${widget.placeDetails['reviews'][i]['rating']} / 5',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.0,
                                  color: Colors.blue,
                                  fontFamily: 'Lato',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(right: 20.0, bottom: 10.0),
                          child: Text(
                            '⏱  ${widget.placeDetails['reviews'][i]['relative_time_description']}',
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Lato',
                                fontSize: 15.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
