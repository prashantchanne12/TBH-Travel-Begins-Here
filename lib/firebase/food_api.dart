import 'dart:io';
import 'food.dart';
import 'food_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart' as path;




getFoods(FoodNotifier foodNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('data')
      .orderBy("time", descending: true)
      .getDocuments();
  List<Food> _foodList = [];

  snapshot.documents.forEach((document) {
    Food food = Food.fromMap(document.data);
    _foodList.add(food);
  });

  foodNotifier.foodList = _foodList;
}

