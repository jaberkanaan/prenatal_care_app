import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prenatal_care_app/core/models/visit_model.dart';

/// Firestore Visit Repository
class VisitRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Get visit by ID
  Future<VisitModel?> getVisit(String visitId) async {
    try {
      final doc = await _firestore.collection('visits').doc(visitId).get();
      if (doc.exists) {
        return VisitModel.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
        rethrow;
    }
  }

  /// Create visit
  Future<void> createVisit(VisitModel visit) async {
    try {
      await _firestore.collection('visits').doc(visit.id).set(visit.toMap());
    } catch (e) {
        rethrow;
    }
  }

  /// Update visit
  Future<void> updateVisit(VisitModel visit) async {
    try {
      await _firestore
          .collection('visits')
          .doc(visit.id)
          .update(visit.toMap());
    } catch (e) {
        rethrow;
    }
  }

  /// Delete visit
  Future<void> deleteVisit(String visitId) async {
    try {
      await _firestore.collection('visits').doc(visitId).delete();
    } catch (e) {
        rethrow;
    }
  }

  /// Get all visits for a patient
  Future<List<VisitModel>> getPatientVisits(String patientId) async {
    try {
      final snapshot = await _firestore
          .collection('visits')
          .where('patientId', isEqualTo: patientId)
          .orderBy('visitNumber')
          .get();

      return snapshot.docs
          .map((doc) => VisitModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
        rethrow;
    }
  }

  /// Get completed visits for a patient
  Future<List<VisitModel>> getCompletedVisits(String patientId) async {
    try {
      final snapshot = await _firestore
          .collection('visits')
          .where('patientId', isEqualTo: patientId)
          .where('isDone', isEqualTo: true)
          .orderBy('visitNumber')
          .get();

      return snapshot.docs
          .map((doc) => VisitModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
        rethrow;
    }
  }

  /// Stream of patient visits
  Stream<List<VisitModel>> streamPatientVisits(String patientId) {
    return _firestore
        .collection('visits')
        .where('patientId', isEqualTo: patientId)
        .orderBy('visitNumber')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => VisitModel.fromMap(doc.data()))
            .toList());
  }
}
