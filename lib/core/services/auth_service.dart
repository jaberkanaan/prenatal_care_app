import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Firebase Authentication Service
class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Get current user
  User? get currentUser => _firebaseAuth.currentUser;

  /// Stream of auth state changes
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  /// Sign up as patient
  Future<UserCredential> signUpPatient({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create patient profile in Firestore
      await _firestore.collection('patients').doc(credential.user!.uid).set({
        'id': credential.user!.uid,
        'name': name,
        'email': email,
        'phone': phone,
        'role': 'patient',
        'createdAt': DateTime.now(),
        'updatedAt': DateTime.now(),
      });

      return credential;
    } on FirebaseAuthException catch (e) {
        rethrow;
    }
  }

  /// Sign up as doctor
  Future<UserCredential> signUpDoctor({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String specialty,
    required String clinicName,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create doctor profile in Firestore
      await _firestore.collection('doctors').doc(credential.user!.uid).set({
        'id': credential.user!.uid,
        'name': name,
        'email': email,
        'phone': phone,
        'specialty': specialty,
        'clinicName': clinicName,
        'role': 'doctor',
        'patientIds': [],
        'createdAt': DateTime.now(),
        'updatedAt': DateTime.now(),
      });

      return credential;
    } on FirebaseAuthException catch (e) {
        rethrow;
    }
  }

  /// Sign in with email and password
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
        rethrow;
    }
  }

  /// Get user role (patient or doctor)
  Future<String?> getUserRole(String uid) async {
    try {
      // Check if patient
      final patientDoc = await _firestore.collection('patients').doc(uid).get();
      if (patientDoc.exists) {
        return 'patient';
      }

      // Check if doctor
      final doctorDoc = await _firestore.collection('doctors').doc(uid).get();
      if (doctorDoc.exists) {
        return 'doctor';
      }

      return null;
    } catch (e) {
        rethrow;
    }
  }

  /// Update user profile
  Future<void> updateUserProfile({
    required String uid,
    required String role,
    required Map<String, dynamic> data,
  }) async {
    try {
      final collection = role == 'patient' ? 'patients' : 'doctors';
      await _firestore.collection(collection).doc(uid).update({
        ...data,
        'updatedAt': DateTime.now(),
      });
    } catch (e) {
        rethrow;
    }
  }

  /// Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
        rethrow;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
        rethrow;
    }
  }
}
