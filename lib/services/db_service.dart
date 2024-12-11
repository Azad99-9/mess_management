import 'package:cloud_firestore/cloud_firestore.dart';

class DBService {
  static CollectionReference users = FirebaseFirestore.instance.collection('users');
  static CollectionReference feedbackResponses = FirebaseFirestore.instance.collection('feedbackResponses');
  static CollectionReference complaints = FirebaseFirestore.instance.collection('complaints');
}