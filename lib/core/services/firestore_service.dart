import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirestoreService._();

  static final FirestoreService instance = FirestoreService._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Create a new user document
  Future<void> createUser({
    required String uid,
    required String name,
    required String email,
  }) async {
    await _firestore.collection('users').doc(uid).set({
      'uid': uid,
      'name': name,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
      'careerGoal': '',
      'skills': [],
      'education': [],
      'experience': [],
      'resumeCompleted': false,
    });
  }

  /// Get complete user document
  Future<DocumentSnapshot<Map<String, dynamic>>> getUser(
    String uid,
  ) async {
    return await _firestore.collection('users').doc(uid).get();
  }

  /// Get only the resume data
  Future<Map<String, dynamic>?> getResume(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();

    if (!doc.exists) {
      return null;
    }

    final data = doc.data();

    if (data == null) {
      return null;
    }

    if (!data.containsKey('resume')) {
      return null;
    }

    return data['resume'] as Map<String, dynamic>?;
  }

  /// Update user document
  Future<void> updateUser(
    String uid,
    Map<String, dynamic> data,
  ) async {
    await _firestore.collection('users').doc(uid).update(data);
  }

  /// Save resume
  Future<void> saveResume({
    required String uid,
    required Map<String, dynamic> resumeData,
  }) async {
    await _firestore.collection('users').doc(uid).update({
      'resume': resumeData,
      'resumeCompleted': true,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}