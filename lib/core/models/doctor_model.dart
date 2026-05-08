import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class DoctorModel extends Equatable {
  final String id;
  final String name;
  final String specialty; // Obstetrician, Midwife, General Practitioner
  final String clinicName;
  final String phone;
  final String email;
  final List<String> patientIds;
  final DateTime createdAt;
  final DateTime updatedAt;

  const DoctorModel({
    required this.id,
    required this.name,
    required this.specialty,
    required this.clinicName,
    required this.phone,
    required this.email,
    required this.patientIds,
    required this.createdAt,
    required this.updatedAt,
  });

  /// To Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'specialty': specialty,
      'clinicName': clinicName,
      'phone': phone,
      'email': email,
      'patientIds': patientIds,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  /// From Firestore
  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      specialty: map['specialty'] ?? '',
      clinicName: map['clinicName'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      patientIds: List<String>.from(map['patientIds'] ?? []),
      createdAt:
          (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt:
          (map['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  /// Copy with
  DoctorModel copyWith({
    String? id,
    String? name,
    String? specialty,
    String? clinicName,
    String? phone,
    String? email,
    List<String>? patientIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DoctorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      specialty: specialty ?? this.specialty,
      clinicName: clinicName ?? this.clinicName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      patientIds: patientIds ?? this.patientIds,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        specialty,
        clinicName,
        phone,
        email,
        patientIds,
        createdAt,
        updatedAt,
      ];
}
