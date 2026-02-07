import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/project_model.dart';

class FirestoreService {
  // Firestore instance
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // --- Projects Stream ---
  // Listens to the 'projects' collection in real-time.
  // We order by 'priority' so you can control which project shows up first.
  Stream<List<Project>> getProjects() {
    return _db
        .collection('projects')
        .orderBy('priority', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Project.fromMap(doc.id, doc.data());
      }).toList();
    });
  }

  // --- Profile Data ---
  // Fetches your bio, links, and resume URL. 
  Future<Map<String, dynamic>?> getProfile() async {
    try {
      DocumentSnapshot doc = await _db.collection('profile').doc('main_info').get();
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching profile: $e");
      }
      return null;
    }
  }
}