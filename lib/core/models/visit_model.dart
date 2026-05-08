import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class InvestigationResult extends Equatable {
  final String testName;
  final String value;
  final String unit;
  final String referenceRange;
  final String advice;
  final DateTime recordedAt;

  const InvestigationResult({
    required this.testName,
    required this.value,
    required this.unit,
    required this.referenceRange,
    required this.advice,
    required this.recordedAt,
  });

  /// To Map
  Map<String, dynamic> toMap() {
    return {
      'testName': testName,
      'value': value,
      'unit': unit,
      'referenceRange': referenceRange,
      'advice': advice,
      'recordedAt': recordedAt,
    };
  }

  /// From Map
  factory InvestigationResult.fromMap(Map<String, dynamic> map) {
    return InvestigationResult(
      testName: map['testName'] ?? '',
      value: map['value'] ?? '',
      unit: map['unit'] ?? '',
      referenceRange: map['referenceRange'] ?? '',
      advice: map['advice'] ?? '',
      recordedAt:
          (map['recordedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [
        testName,
        value,
        unit,
        referenceRange,
        advice,
        recordedAt,
      ];
}

class VisitModel extends Equatable {
  final String id;
  final String patientId;
  final int visitNumber; // 1-11
  final int weekNumber; // e.g. 12, 16, 20
  final String title;
  final DateTime? scheduledDate;
  final DateTime? completedDate;
  final bool isDone;
  final String notes;
  final List<InvestigationResult> results;
  final DateTime createdAt;
  final DateTime updatedAt;

  const VisitModel({
    required this.id,
    required this.patientId,
    required this.visitNumber,
    required this.weekNumber,
    required this.title,
    this.scheduledDate,
    this.completedDate,
    this.isDone = false,
    this.notes = '',
    this.results = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  /// To Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'patientId': patientId,
      'visitNumber': visitNumber,
      'weekNumber': weekNumber,
      'title': title,
      'scheduledDate': scheduledDate,
      'completedDate': completedDate,
      'isDone': isDone,
      'notes': notes,
      'results': results.map((r) => r.toMap()).toList(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  /// From Firestore
  factory VisitModel.fromMap(Map<String, dynamic> map) {
    return VisitModel(
      id: map['id'] ?? '',
      patientId: map['patientId'] ?? '',
      visitNumber: map['visitNumber'] ?? 0,
      weekNumber: map['weekNumber'] ?? 0,
      title: map['title'] ?? '',
      scheduledDate: (map['scheduledDate'] as Timestamp?)?.toDate(),
      completedDate: (map['completedDate'] as Timestamp?)?.toDate(),
      isDone: map['isDone'] ?? false,
      notes: map['notes'] ?? '',
      results: (map['results'] as List<dynamic>?)
              ?.map((r) => InvestigationResult.fromMap(
                  Map<String, dynamic>.from(r as Map)))
              .toList() ??
          [],
      createdAt:
          (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt:
          (map['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  /// Copy with
  VisitModel copyWith({
    String? id,
    String? patientId,
    int? visitNumber,
    int? weekNumber,
    String? title,
    DateTime? scheduledDate,
    DateTime? completedDate,
    bool? isDone,
    String? notes,
    List<InvestigationResult>? results,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return VisitModel(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      visitNumber: visitNumber ?? this.visitNumber,
      weekNumber: weekNumber ?? this.weekNumber,
      title: title ?? this.title,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      completedDate: completedDate ?? this.completedDate,
      isDone: isDone ?? this.isDone,
      notes: notes ?? this.notes,
      results: results ?? this.results,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        patientId,
        visitNumber,
        weekNumber,
        title,
        scheduledDate,
        completedDate,
        isDone,
        notes,
        results,
        createdAt,
        updatedAt,
      ];
}
