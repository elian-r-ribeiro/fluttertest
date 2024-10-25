import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Firebaseservice {
  final CollectionReference tasks =
      FirebaseFirestore.instance.collection("cars");

  String get userId => FirebaseAuth.instance.currentUser!.uid;

  Future addCar(
      String manufacturer, String model, String year, String category) {
    return tasks.add({
      "manufacturer": manufacturer,
      "model": model,
      "year": year,
      "category": category,
      "userId": userId
    });
  }

  Stream<QuerySnapshot> getCarsStream() {
    final tasksStream = tasks.where("userId", isEqualTo: userId).snapshots();
    return tasksStream;
  }

  Future<void> updateTask(String docId, String newManufacturer, String newModel,
      String newYear, String newCategory) {
    return tasks.doc(docId).update({
      "manufacturer": newManufacturer,
      "model": newModel,
      "year": newYear,
      "category": newCategory,
      "userId": userId
    });
  }

  Future<void> deleteTask(String docId) {
    return tasks.doc(docId).delete();
  }

  Future<DocumentSnapshot> getCar(String docId) {
    return tasks.doc(docId).get();
  }
}
