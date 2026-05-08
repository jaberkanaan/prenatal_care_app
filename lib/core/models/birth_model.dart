import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class BirthModel extends Equatable {
  final String id;
  final String patientId;
  final DateTime? labourStartTime;
  final DateTime? deliveryTime;
  final String birthType; // Normal SVD, C-Section, Ventouse, Forceps
  final double babyWeightKg;
  final double babyLengthCm;
  final String babySex; // Male, Female, Unknown
  final int apgar1min; // 0-10
  final int apgar5min; // 0-10
  final String notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const BirthModel({
    required this.id,
    required this.patientId,
    this.labourStartTime,
    this.deliveryTime,
    required this.birthType,
    required this.babyWeightKg,
    required this.babyLengthCm,
    required this.babySex,
    required this.apgar1min,
    required this.apgar5min,
    this.notes = '',
    required this.createdAt,
    required this.updatedAt,
  });

  // ── Computed Properties ──────────────────────────────────

  /// Total APGAR score (1-min + 5-min)
  int get apgarTotal => apgar1min + apgar5min;

  /// 5-min APGAR clinical interpretation
  String get apgarCategory {
    if (apgar5min >= 7) return 'Normal';
    if (apgar5min >= 4) return 'Moderate concern';
    return 'Requires immediate attention';
  }

  /// Labour duration in minutes
  int? get labourDurationMinutes {
    if (labourStartTime == null || deliveryTime == null) return null;
    return deliveryTime!.difference(labourStartTime!).inMinutes;
  }

  /// Labour duration formatted as hours:minutes
  String get labourDurationFormatted {
    final duration = labourDurationMinutes;
    if (duration == null) return 'N/A';
    final hours = duration ~/ 60;
    final minutes = duration % 60;
    return '${hours}h ${minutes}m';
  }

  /// To Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'patientId': patientId,
      'labourStartTime': labourStartTime,
      'deliveryTime': deliveryTime,
      'birthType': birthType,
      'babyWeightKg': babyWeightKg,
      'babyLengthCm': babyLengthCm,
      'babySex': babySex,
      'apgar1min': apgar1min,
      'apgar5min': apgar5min,
      'notes': notes,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  /// From Firestore
  factory BirthModel.fromMap(Map<String, dynamic> map) {
    return BirthModel(
      id: map['id'] ?? '',
      patientId: map['patientId'] ?? '',
      labourStartTime: (map['labourStartTime'] as Timestamp?)?.toDate(),
      deliveryTime: (map['deliveryTime'] as Timestamp?)?.toDate(),
      birthType: map['birthType'] ?? 'Normal SVD',
      babyWeightKg: (map['babyWeightKg'] as num?)?.toDouble() ?? 0.0,
      babyLengthCm: (map['babyLengthCm'] as num?)?.toDouble() ?? 0.0,
      babySex: map['babySex'] ?? 'Unknown',
      apgar1min: map['apgar1min'] ?? 0,
      apgar5min: map['apgar5min'] ?? 0,
      notes: map['notes'] ?? '',
      createdAt:
          (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt:
          (map['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  /// Copy with
  BirthModel copyWith({
    String? id,
    String? patientId,
    DateTime? labourStartTime,
    DateTime? deliveryTime,
    String? birthType,
    double? babyWeightKg,
    double? babyLengthCm,
    String? babySex,
    int? apgar1min,
    int? apgar5min,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BirthModel(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      labourStartTime: labourStartTime ?? this.labourStartTime,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      birthType: birthType ?? this.birthType,
      babyWeightKg: babyWeightKg ?? this.babyWeightKg,
      babyLengthCm: babyLengthCm ?? this.babyLengthCm,
      babySex: babySex ?? this.babySex,
      apgar1min: apgar1min ?? this.apgar1min,
      apgar5min: apgar5min ?? this.apgar5min,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        patientId,
        labourStartTime,
        deliveryTime,
        birthType,
        babyWeightKg,
        babyLengthCm,
        babySex,
        apgar1min,
        apgar5min,
        notes,
        createdAt,
        updatedAt,
      ];
}
