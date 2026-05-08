import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PatientModel extends Equatable {
  final String id;
  final String name;
  final DateTime dateOfBirth;
  final String bloodType; // A+, A-, B+, B-, O+, O-, AB+, AB-
  final int gravida; // Number of pregnancies
  final int para; // Number of deliveries
  final String? allergies;
  final String? notes;
  final DateTime? lmp; // Last Menstrual Period
  final double weightKg;
  final double heightM;
  final DateTime? nextVisitDate;
  final String assignedDoctorId;
  final String language; // 'en' | 'ar'
  final DateTime createdAt;
  final DateTime updatedAt;

  const PatientModel({
    required this.id,
    required this.name,
    required this.dateOfBirth,
    required this.bloodType,
    required this.gravida,
    required this.para,
    this.allergies,
    this.notes,
    this.lmp,
    required this.weightKg,
    required this.heightM,
    this.nextVisitDate,
    required this.assignedDoctorId,
    required this.language,
    required this.createdAt,
    required this.updatedAt,
  });

  // ── Computed Properties ──────────────────────────────────

  /// Gestational Age in days from LMP
  int get gestationalAgeDays =>
      lmp == null ? 0 : DateTime.now().difference(lmp!).inDays;

  /// Gestational Age in weeks
  int get gestationalAgeWeeks => gestationalAgeDays ~/ 7;

  /// Remaining days in current week
  int get gestationalAgeDaysRemainder => gestationalAgeDays % 7;

  /// Estimated Due Date (EDD) = LMP + 280 days (Naegele's rule)
  DateTime? get edd => lmp?.add(const Duration(days: 280));

  /// BMI = weight(kg) / height(m)²
  double get bmi {
    if (heightM == 0) return 0;
    return weightKg / (heightM * heightM);
  }

  /// BMI Category
  String get bmiCategory {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25.0) return 'Normal';
    if (bmi < 30.0) return 'Overweight';
    return 'Obese';
  }

  /// Current Trimester (1, 2, or 3)
  int get trimester {
    if (gestationalAgeWeeks <= 13) return 1;
    if (gestationalAgeWeeks <= 26) return 2;
    return 3;
  }

  /// Percentage through pregnancy (0-100)
  double get pregnancyProgress {
    const totalDays = 280; // 40 weeks
    if (gestationalAgeDays >= totalDays) return 100.0;
    return (gestationalAgeDays / totalDays) * 100;
  }

  /// To Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dateOfBirth': dateOfBirth,
      'bloodType': bloodType,
      'gravida': gravida,
      'para': para,
      'allergies': allergies,
      'notes': notes,
      'lmp': lmp,
      'weightKg': weightKg,
      'heightM': heightM,
      'nextVisitDate': nextVisitDate,
      'assignedDoctorId': assignedDoctorId,
      'language': language,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  /// From Firestore
  factory PatientModel.fromMap(Map<String, dynamic> map) {
    return PatientModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      dateOfBirth:
          (map['dateOfBirth'] as Timestamp?)?.toDate() ?? DateTime.now(),
      bloodType: map['bloodType'] ?? 'O+',
      gravida: map['gravida'] ?? 0,
      para: map['para'] ?? 0,
      allergies: map['allergies'],
      notes: map['notes'],
      lmp: (map['lmp'] as Timestamp?)?.toDate(),
      weightKg: (map['weightKg'] as num?)?.toDouble() ?? 0.0,
      heightM: (map['heightM'] as num?)?.toDouble() ?? 0.0,
      nextVisitDate: (map['nextVisitDate'] as Timestamp?)?.toDate(),
      assignedDoctorId: map['assignedDoctorId'] ?? '',
      language: map['language'] ?? 'en',
      createdAt:
          (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt:
          (map['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  /// Copy with
  PatientModel copyWith({
    String? id,
    String? name,
    DateTime? dateOfBirth,
    String? bloodType,
    int? gravida,
    int? para,
    String? allergies,
    String? notes,
    DateTime? lmp,
    double? weightKg,
    double? heightM,
    DateTime? nextVisitDate,
    String? assignedDoctorId,
    String? language,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PatientModel(
      id: id ?? this.id,
      name: name ?? this.name,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      bloodType: bloodType ?? this.bloodType,
      gravida: gravida ?? this.gravida,
      para: para ?? this.para,
      allergies: allergies ?? this.allergies,
      notes: notes ?? this.notes,
      lmp: lmp ?? this.lmp,
      weightKg: weightKg ?? this.weightKg,
      heightM: heightM ?? this.heightM,
      nextVisitDate: nextVisitDate ?? this.nextVisitDate,
      assignedDoctorId: assignedDoctorId ?? this.assignedDoctorId,
      language: language ?? this.language,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        dateOfBirth,
        bloodType,
        gravida,
        para,
        allergies,
        notes,
        lmp,
        weightKg,
        heightM,
        nextVisitDate,
        assignedDoctorId,
        language,
        createdAt,
        updatedAt,
      ];
}
