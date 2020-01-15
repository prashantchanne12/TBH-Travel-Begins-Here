import 'dart:collection';
import 'package:nishant/firebase/ngo.dart';
import 'ngo.dart';
import 'package:flutter/cupertino.dart';

class NgoNotifier with ChangeNotifier {
  List<Ngo> _ngoList = [];
  Ngo _currentNgo;

  UnmodifiableListView<Ngo> get ngoList => UnmodifiableListView(_ngoList);

  Ngo get currentFood => _currentNgo;

  set ngoList(List<Ngo> ngoList) {
    _ngoList = ngoList;
    notifyListeners();
  }

  set currentFood(Ngo ngo) {
    _currentNgo = ngo;
    notifyListeners();
  }

  
}