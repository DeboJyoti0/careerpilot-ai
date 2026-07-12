import 'package:cloud_firestore/cloud_firestore.dart';

import '../../shared/models/resume_model.dart';

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
      'resume': {},
    });
  }

  /// Get user data
  Future<DocumentSnapshot<Map<String, dynamic>>> getUser(
    String uid,
  ) async {
    return await _firestore.collection('users').doc(uid).get();
  }

  /// Update user data
  Future<void> updateUser(
    String uid,
    Map<String, dynamic> data,
  ) async {
    await _firestore.collection('users').doc(uid).update(data);
  }

  /// Save Resume
  Future<void> saveResume({
    required String uid,
    required ResumeModel resume,
  }) async {
    await _firestore.collection('users').doc(uid).update({
      'resume': resume.toMap(),
      'resumeCompleted': true,
    });
  }

  /// Load Resume
  Future<ResumeModel?> loadResume(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();

    if (!doc.exists) {
      return null;
    }

    final data = doc.data();

    if (data == null || data['resume'] == null) {
      return null;
    }

    return ResumeModel.fromMap(
      Map<String, dynamic>.from(data['resume']),
    );
  }
}