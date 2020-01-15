import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
class BlogList extends StatefulWidget {
  @override
  _BlogListState createState() => _BlogListState();
}

class _BlogListState extends State<BlogList> {
   List<String> images=[];
   List<String> title=[];
   int i=0;
    getData()async{
    final QuerySnapshot result =
          await Firestore.instance.collection('blogs').getDocuments();
final List<DocumentSnapshot> documents = result.documents;
documents.forEach((data) {
  i=i+1;
  title[i]=data.data['title'];
});
   i=0;
  }
  @override
  Widget build(BuildContext context) {
    getData();
        return Swiper(
          itemCount: i,
            itemBuilder: (BuildContext context,int index){
              return new Text(title[i]);
            },
        );
      }
}

class Comment extends StatelessWidget {
  final String title;
  final String description;
  final String location;
  final String uid;
Comment({this.description,this.location,this.title,this.uid});
  factory Comment.fromDocument(DocumentSnapshot doc){
    return Comment(
      uid: doc['uid'],
      title: doc['title'],
      location: doc['loction'],
      description: doc['description'],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(title),
          // leading: CircleAvatar(
          //   backgroundImage: NetworkImage(avatarUrl),
          // ),
          subtitle: Text(
            'f'
            ),
        )
      ],
    );
  }
}
