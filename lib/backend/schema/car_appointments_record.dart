import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CarAppointmentsRecord extends FirestoreRecord {
  CarAppointmentsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "carName" field.
  String? _carName;
  String get carName => _carName ?? '';
  bool hasCarName() => _carName != null;

  // "scheduledDate" field.
  DateTime? _scheduledDate;
  DateTime? get scheduledDate => _scheduledDate;
  bool hasScheduledDate() => _scheduledDate != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  // "appointmentNumber" field.
  int? _appointmentNumber;
  int get appointmentNumber => _appointmentNumber ?? 0;
  bool hasAppointmentNumber() => _appointmentNumber != null;

  // "carRef" field.
  DocumentReference? _carRef;
  DocumentReference? get carRef => _carRef;
  bool hasCarRef() => _carRef != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _carName = snapshotData['carName'] as String?;
    _scheduledDate = snapshotData['scheduledDate'] as DateTime?;
    _description = snapshotData['description'] as String?;
    _status = snapshotData['status'] as String?;
    _type = snapshotData['type'] as String?;
    _appointmentNumber = castToType<int>(snapshotData['appointmentNumber']);
    _carRef = snapshotData['carRef'] as DocumentReference?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('carAppointments')
          : FirebaseFirestore.instance.collectionGroup('carAppointments');

  static DocumentReference createDoc(DocumentReference parent) =>
      parent.collection('carAppointments').doc();

  static Stream<CarAppointmentsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CarAppointmentsRecord.fromSnapshot(s));

  static Future<CarAppointmentsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CarAppointmentsRecord.fromSnapshot(s));

  static CarAppointmentsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CarAppointmentsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CarAppointmentsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CarAppointmentsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CarAppointmentsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CarAppointmentsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCarAppointmentsRecordData({
  String? carName,
  DateTime? scheduledDate,
  String? description,
  String? status,
  String? type,
  int? appointmentNumber,
  DocumentReference? carRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'carName': carName,
      'scheduledDate': scheduledDate,
      'description': description,
      'status': status,
      'type': type,
      'appointmentNumber': appointmentNumber,
      'carRef': carRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class CarAppointmentsRecordDocumentEquality
    implements Equality<CarAppointmentsRecord> {
  const CarAppointmentsRecordDocumentEquality();

  @override
  bool equals(CarAppointmentsRecord? e1, CarAppointmentsRecord? e2) {
    return e1?.carName == e2?.carName &&
        e1?.scheduledDate == e2?.scheduledDate &&
        e1?.description == e2?.description &&
        e1?.status == e2?.status &&
        e1?.type == e2?.type &&
        e1?.appointmentNumber == e2?.appointmentNumber &&
        e1?.carRef == e2?.carRef;
  }

  @override
  int hash(CarAppointmentsRecord? e) => const ListEquality().hash([
        e?.carName,
        e?.scheduledDate,
        e?.description,
        e?.status,
        e?.type,
        e?.appointmentNumber,
        e?.carRef
      ]);

  @override
  bool isValidKey(Object? o) => o is CarAppointmentsRecord;
}
