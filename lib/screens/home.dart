import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nishant/modal/details.dart';
import 'package:nishant/screens/Timeline.dart';
import 'package:nishant/screens/anonyprofile.dart';
import 'package:nishant/screens/nearby.dart';
import 'package:nishant/screens/nearby_places_screen.dart';
import 'package:nishant/screens/ngos.dart';
import 'package:nishant/screens/upload.dart';
import 'package:nishant/services/authentication.dart';
import 'package:nishant/screens/EditProfile.dart';
import 'package:nishant/services/database.dart';
import 'package:provider/provider.dart';

Authentication _auth = Authentication();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController pageController;
  dynamic anonymous;
  int index = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController(initialPage: 0);
  }

  getanon() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    if (user.isAnonymous) {
      setState(() {
        this.anonymous = true;
      });
    } else {
      setState(() {
        this.anonymous = false;
      });
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  onPageChange(int index) {
    setState(() {
      this.index = index;
    });
  }

  onTap(int index) {
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 200), curve: Curves.bounceInOut);
  }

  @override
  Widget build(BuildContext context) {
    getanon();
    return StreamProvider<List<Details>>.value(
      value: DatabaseServices().details,
      child: Scaffold(
        body: PageView(
          children: <Widget>[
            Timeline(),
            Ngos(),
            anonymous ? Anonymous() : Upload(),
            NearbyPlacesScreen(),
            EditProfile(),
          ],
          controller: pageController,
          onPageChanged: onPageChange,
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: CupertinoTabBar(
          currentIndex: index,
          onTap: onTap,
          activeColor: Colors.red,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
              Icons.whatshot,
            )),
            BottomNavigationBarItem(
                icon: Icon(
              Icons.event,
            )),
            BottomNavigationBarItem(
                icon: Icon(
              Icons.photo_camera,
              size: 50,
            )),
            BottomNavigationBarItem(
                icon: Icon(
              Icons.location_on,
            )),
            BottomNavigationBarItem(icon: Icon(Icons.person))
          ],
        ),
      ),
    );
  }
}

// Future<List<String>> uploadImage(
//       {@required String fileName, @required List<Asset> assets}) async {
//     List<String> uploadUrls = [];

//     await Future.wait(assets.map((Asset asset) async {
//       ByteData byteData = await asset.requestOriginal();
//       List<int> imageData = byteData.buffer.asUint8List();

//       StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
//       StorageUploadTask uploadTask = reference.putData(imageData);
//       StorageTaskSnapshot storageTaskSnapshot;

//       // Release the image data
//       asset.releaseOriginal();

//       StorageTaskSnapshot snapshot = await uploadTask.onComplete;
//       if (snapshot.error == null) {
//         storageTaskSnapshot = snapshot;
//         final String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
//         uploadUrls.add(downloadUrl);

//         print('Upload success');
//       } else {
//         print('Error from image repo ${snapshot.error.toString()}');
//         throw ('This file is not an image');
//       }
//     }), eagerError: true, cleanUp: (_) {
//      print('eager cleaned up');
//     });

//     return uploadUrls;
// }
