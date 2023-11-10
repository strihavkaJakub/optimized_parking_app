import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CarRecord extends FirestoreRecord {
  CarRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "batteryChargePercentage" field.
  double? _batteryChargePercentage;
  double get batteryChargePercentage => _batteryChargePercentage ?? 0.0;
  bool hasBatteryChargePercentage() => _batteryChargePercentage != null;

  // "batterySizeKwh" field.
  double? _batterySizeKwh;
  double get batterySizeKwh => _batterySizeKwh ?? 0.0;
  bool hasBatterySizeKwh() => _batterySizeKwh != null;

  // "vehicleRegistrationPlate" field.
  String? _vehicleRegistrationPlate;
  String get vehicleRegistrationPlate => _vehicleRegistrationPlate ?? '';
  bool hasVehicleRegistrationPlate() => _vehicleRegistrationPlate != null;

  // "averageConsumptionKWh" field.
  double? _averageConsumptionKWh;
  double get averageConsumptionKWh => _averageConsumptionKWh ?? 0.0;
  bool hasAverageConsumptionKWh() => _averageConsumptionKWh != null;

  // "carUser" field.
  DocumentReference? _carUser;
  DocumentReference? get carUser => _carUser;
  bool hasCarUser() => _carUser != null;

  // "carPayment" field.
  DocumentReference? _carPayment;
  DocumentReference? get carPayment => _carPayment;
  bool hasCarPayment() => _carPayment != null;

  // "carChargingSpot" field.
  DocumentReference? _carChargingSpot;
  DocumentReference? get carChargingSpot => _carChargingSpot;
  bool hasCarChargingSpot() => _carChargingSpot != null;

  // "desiredDepartureDateTime" field.
  DateTime? _desiredDepartureDateTime;
  DateTime? get desiredDepartureDateTime => _desiredDepartureDateTime;
  bool hasDesiredDepartureDateTime() => _desiredDepartureDateTime != null;

  // "desiredChargeAtDeparture" field.
  int? _desiredChargeAtDeparture;
  int get desiredChargeAtDeparture => _desiredChargeAtDeparture ?? 0;
  bool hasDesiredChargeAtDeparture() => _desiredChargeAtDeparture != null;

  // "parkingPrice" field.
  double? _parkingPrice;
  double get parkingPrice => _parkingPrice ?? 0.0;
  bool hasParkingPrice() => _parkingPrice != null;

  // "parkedFrom" field.
  DateTime? _parkedFrom;
  DateTime? get parkedFrom => _parkedFrom;
  bool hasParkedFrom() => _parkedFrom != null;

  // "parkedTo" field.
  DateTime? _parkedTo;
  DateTime? get parkedTo => _parkedTo;
  bool hasParkedTo() => _parkedTo != null;

  void _initializeFields() {
    _batteryChargePercentage =
        castToType<double>(snapshotData['batteryChargePercentage']);
    _batterySizeKwh = castToType<double>(snapshotData['batterySizeKwh']);
    _vehicleRegistrationPlate =
        snapshotData['vehicleRegistrationPlate'] as String?;
    _averageConsumptionKWh =
        castToType<double>(snapshotData['averageConsumptionKWh']);
    _carUser = snapshotData['carUser'] as DocumentReference?;
    _carPayment = snapshotData['carPayment'] as DocumentReference?;
    _carChargingSpot = snapshotData['carChargingSpot'] as DocumentReference?;
    _desiredDepartureDateTime =
        snapshotData['desiredDepartureDateTime'] as DateTime?;
    _desiredChargeAtDeparture =
        castToType<int>(snapshotData['desiredChargeAtDeparture']);
    _parkingPrice = castToType<double>(snapshotData['parkingPrice']);
    _parkedFrom = snapshotData['parkedFrom'] as DateTime?;
    _parkedTo = snapshotData['parkedTo'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('car');

  static Stream<CarRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CarRecord.fromSnapshot(s));

  static Future<CarRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CarRecord.fromSnapshot(s));

  static CarRecord fromSnapshot(DocumentSnapshot snapshot) => CarRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CarRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CarRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CarRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CarRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCarRecordData({
  double? batteryChargePercentage,
  double? batterySizeKwh,
  String? vehicleRegistrationPlate,
  double? averageConsumptionKWh,
  DocumentReference? carUser,
  DocumentReference? carPayment,
  DocumentReference? carChargingSpot,
  DateTime? desiredDepartureDateTime,
  int? desiredChargeAtDeparture,
  double? parkingPrice,
  DateTime? parkedFrom,
  DateTime? parkedTo,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'batteryChargePercentage': batteryChargePercentage,
      'batterySizeKwh': batterySizeKwh,
      'vehicleRegistrationPlate': vehicleRegistrationPlate,
      'averageConsumptionKWh': averageConsumptionKWh,
      'carUser': carUser,
      'carPayment': carPayment,
      'carChargingSpot': carChargingSpot,
      'desiredDepartureDateTime': desiredDepartureDateTime,
      'desiredChargeAtDeparture': desiredChargeAtDeparture,
      'parkingPrice': parkingPrice,
      'parkedFrom': parkedFrom,
      'parkedTo': parkedTo,
    }.withoutNulls,
  );

  return firestoreData;
}

class CarRecordDocumentEquality implements Equality<CarRecord> {
  const CarRecordDocumentEquality();

  @override
  bool equals(CarRecord? e1, CarRecord? e2) {
    return e1?.batteryChargePercentage == e2?.batteryChargePercentage &&
        e1?.batterySizeKwh == e2?.batterySizeKwh &&
        e1?.vehicleRegistrationPlate == e2?.vehicleRegistrationPlate &&
        e1?.averageConsumptionKWh == e2?.averageConsumptionKWh &&
        e1?.carUser == e2?.carUser &&
        e1?.carPayment == e2?.carPayment &&
        e1?.carChargingSpot == e2?.carChargingSpot &&
        e1?.desiredDepartureDateTime == e2?.desiredDepartureDateTime &&
        e1?.desiredChargeAtDeparture == e2?.desiredChargeAtDeparture &&
        e1?.parkingPrice == e2?.parkingPrice &&
        e1?.parkedFrom == e2?.parkedFrom &&
        e1?.parkedTo == e2?.parkedTo;
  }

  @override
  int hash(CarRecord? e) => const ListEquality().hash([
        e?.batteryChargePercentage,
        e?.batterySizeKwh,
        e?.vehicleRegistrationPlate,
        e?.averageConsumptionKWh,
        e?.carUser,
        e?.carPayment,
        e?.carChargingSpot,
        e?.desiredDepartureDateTime,
        e?.desiredChargeAtDeparture,
        e?.parkingPrice,
        e?.parkedFrom,
        e?.parkedTo
      ]);

  @override
  bool isValidKey(Object? o) => o is CarRecord;
}
