import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prenatal_care_app/core/models/birth_model.dart';

/// Firestore Birth Repository
class BirthRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Create birth record
  Future<void> createBirthRecord(BirthModel birth) async {
    try {
      await _firestore
          .collection('births')
          .doc(birth.id)
          .set(birth.toMap());
    } catch (e) {
        rethrow;
    }
  }

  /// Get birth record by ID
  Future<BirthModel?> getBirthRecord(String birthId) async {
    try {
      final doc = await _firestore.collection('births').doc(birthId).get();
      if (doc.exists) {
        return BirthModel.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
        rethrow;
    }
  }

  /// Get birth record by patient ID
  Future<BirthModel?> getPatientBirthRecord(String patientId) async {
    try {
      final snapshot = await _firestore
          .collection('births')
          .where('patientId', isEqualTo: patientId)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return BirthModel.fromMap(snapshot.docs.first.data());
      }
      return null;
    } catch (e) {
        rethrow;
    }
  }

  /// Update birth record
  Future<void> updateBirthRecord(BirthModel birth) async {
    try {
      await _firestore
          .collection('births')
          .doc(birth.id)
          .update(birth.toMap());
    } catch (e) {
        rethrow;
    }
  }
}
