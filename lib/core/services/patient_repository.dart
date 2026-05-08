import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prenatal_care_app/core/models/patient_model.dart';

/// Firestore Patient Repository
class PatientRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Get patient by ID
  Future<PatientModel?> getPatient(String patientId) async {
    try {
      final doc =
          await _firestore.collection('patients').doc(patientId).get();
      if (doc.exists) {
        return PatientModel.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
        rethrow;
    }
  }

  /// Create patient
  Future<void> createPatient(PatientModel patient) async {
    try {
      await _firestore
          .collection('patients')
          .doc(patient.id)
          .set(patient.toMap());
    } catch (e) {
        rethrow;
    }
  }

  /// Update patient
  Future<void> updatePatient(PatientModel patient) async {
    try {
      await _firestore
          .collection('patients')
          .doc(patient.id)
          .update(patient.toMap());
    } catch (e) {
        rethrow;
    }
  }

  /// Delete patient
  Future<void> deletePatient(String patientId) async {
    try {
      await _firestore.collection('patients').doc(patientId).delete();
    } catch (e) {
        rethrow;
    }
  }

  /// Get all patients for a doctor
  Future<List<PatientModel>> getDoctorPatients(String doctorId) async {
    try {
      final snapshot = await _firestore
          .collection('patients')
          .where('assignedDoctorId', isEqualTo: doctorId)
          .get();

      return snapshot.docs
          .map((doc) => PatientModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
        rethrow;
    }
  }

  /// Stream of patient data
  Stream<PatientModel?> streamPatient(String patientId) {
    return _firestore
        .collection('patients')
        .doc(patientId)
        .snapshots()
        .map((doc) => doc.exists ? PatientModel.fromMap(doc.data()!) : null);
  }
}
