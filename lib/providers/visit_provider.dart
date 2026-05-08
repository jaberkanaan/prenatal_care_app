import 'package:flutter/foundation.dart';
import 'package:prenatal_care_app/core/services/visit_repository.dart';
import 'package:prenatal_care_app/core/models/visit_model.dart';

/// Visit Provider for state management
class VisitProvider extends ChangeNotifier {
  final VisitRepository _visitRepository;

  VisitProvider(this._visitRepository);

  List<VisitModel> _visits = [];
  bool _isLoading = false;
  String? _error;

  // Getters
  List<VisitModel> get visits => _visits;
  bool get isLoading => _isLoading;
  String? get error => _error;

  int get completedVisits => _visits.where((v) => v.isDone).length;
  int get totalVisits => _visits.length;
  double get completionPercentage =>
      totalVisits > 0 ? (completedVisits / totalVisits) * 100 : 0;

  /// Load patient visits
  Future<void> loadPatientVisits(String patientId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _visits = await _visitRepository.getPatientVisits(patientId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Create visit
  Future<void> createVisit(VisitModel visit) async {
    try {
      await _visitRepository.createVisit(visit);
      _visits.add(visit);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Update visit
  Future<void> updateVisit(VisitModel visit) async {
    try {
      await _visitRepository.updateVisit(visit);
      final index = _visits.indexWhere((v) => v.id == visit.id);
      if (index != -1) {
        _visits[index] = visit;
      }
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Mark visit as done
  Future<void> markVisitDone(String visitId) async {
    try {
      final visit = _visits.firstWhere((v) => v.id == visitId);
      final updatedVisit = visit.copyWith(
        isDone: true,
        completedDate: DateTime.now(),
      );
      await updateVisit(updatedVisit);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Clear visits
  void clearVisits() {
    _visits = [];
    _error = null;
    notifyListeners();
  }
}
