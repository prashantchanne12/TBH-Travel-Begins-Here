import 'package:nishant/firebase/ngo_notifier.dart';
import 'ngo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

getNgos(NgoNotifier ngoNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('ngo')
      .orderBy("time", descending: true)
      .getDocuments();
  List<Ngo> _ngoList = [];
  snapshot.documents.forEach((document) {
    Ngo ngo = Ngo.fromMap(document.data);
    _ngoList.add(ngo);
  });

  ngoNotifier.ngoList = _ngoList;
}

