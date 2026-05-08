import 'package:flutter/foundation.dart';
import 'package:prenatal_care_app/core/models/patient_model.dart';
import 'package:prenatal_care_app/core/services/patient_repository.dart';

/// Patient Provider for state management
class PatientProvider extends ChangeNotifier {
  final PatientRepository _patientRepository;

  PatientProvider(this._patientRepository);

  PatientModel? _currentPatient;
  bool _isLoading = false;
  String? _error;

  // Getters
  PatientModel? get currentPatient => _currentPatient;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Load patient data
  Future<void> loadPatient(String patientId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final patient = await _patientRepository.getPatient(patientId);
      _currentPatient = patient;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Update patient
  Future<void> updatePatient(PatientModel patient) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _patientRepository.updatePatient(patient);
      _currentPatient = patient;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Update patient LMP
  Future<void> updateLmp(DateTime lmp) async {
    if (_currentPatient == null) return;

    final updatedPatient = _currentPatient!.copyWith(lmp: lmp);
    await updatePatient(updatedPatient);
  }

  /// Update patient weight
  Future<void> updateWeight(double weight) async {
    if (_currentPatient == null) return;

    final updatedPatient = _currentPatient!.copyWith(weightKg: weight);
    await updatePatient(updatedPatient);
  }

  /// Update patient height
  Future<void> updateHeight(double height) async {
    if (_currentPatient == null) return;

    final updatedPatient = _currentPatient!.copyWith(heightM: height);
    await updatePatient(updatedPatient);
  }

  /// Clear patient data
  void clearPatient() {
    _currentPatient = null;
    _error = null;
    notifyListeners();
  }
}
