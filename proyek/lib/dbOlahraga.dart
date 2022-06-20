  import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference tbOlahraga = FirebaseFirestore.instance.collection("tbOlahraga");

class DatabaseOlahraga {
  static Stream<QuerySnapshot> getData() {
    return tbOlahraga.snapshots();
  }
}