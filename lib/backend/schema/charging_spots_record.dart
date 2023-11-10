import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ChargingSpotsRecord extends FirestoreRecord {
  ChargingSpotsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "parkingSpotNumber" field.
  int? _parkingSpotNumber;
  int get parkingSpotNumber => _parkingSpotNumber ?? 0;
  bool hasParkingSpotNumber() => _parkingSpotNumber != null;

  // "chargingMode" field.
  int? _chargingMode;
  int get chargingMode => _chargingMode ?? 0;
  bool hasChargingMode() => _chargingMode != null;

  // "chargingSpeedKW" field.
  double? _chargingSpeedKW;
  double get chargingSpeedKW => _chargingSpeedKW ?? 0.0;
  bool hasChargingSpeedKW() => _chargingSpeedKW != null;

  // "car" field.
  DocumentReference? _car;
  DocumentReference? get car => _car;
  bool hasCar() => _car != null;

  // "isOccupied" field.
  bool? _isOccupied;
  bool get isOccupied => _isOccupied ?? false;
  bool hasIsOccupied() => _isOccupied != null;

  // "isCharging" field.
  bool? _isCharging;
  bool get isCharging => _isCharging ?? false;
  bool hasIsCharging() => _isCharging != null;

  // "parkingLot" field.
  DocumentReference? _parkingLot;
  DocumentReference? get parkingLot => _parkingLot;
  bool hasParkingLot() => _parkingLot != null;

  // "isV2GActive" field.
  bool? _isV2GActive;
  bool get isV2GActive => _isV2GActive ?? false;
  bool hasIsV2GActive() => _isV2GActive != null;

  // "isReserved" field.
  bool? _isReserved;
  bool get isReserved => _isReserved ?? false;
  bool hasIsReserved() => _isReserved != null;

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  bool hasUser() => _user != null;

  // "reservation" field.
  DocumentReference? _reservation;
  DocumentReference? get reservation => _reservation;
  bool hasReservation() => _reservation != null;

  void _initializeFields() {
    _parkingSpotNumber = castToType<int>(snapshotData['parkingSpotNumber']);
    _chargingMode = castToType<int>(snapshotData['chargingMode']);
    _chargingSpeedKW = castToType<double>(snapshotData['chargingSpeedKW']);
    _car = snapshotData['car'] as DocumentReference?;
    _isOccupied = snapshotData['isOccupied'] as bool?;
    _isCharging = snapshotData['isCharging'] as bool?;
    _parkingLot = snapshotData['parkingLot'] as DocumentReference?;
    _isV2GActive = snapshotData['isV2GActive'] as bool?;
    _isReserved = snapshotData['isReserved'] as bool?;
    _user = snapshotData['user'] as DocumentReference?;
    _reservation = snapshotData['reservation'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('chargingSpots');

  static Stream<ChargingSpotsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ChargingSpotsRecord.fromSnapshot(s));

  static Future<ChargingSpotsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ChargingSpotsRecord.fromSnapshot(s));

  static ChargingSpotsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ChargingSpotsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ChargingSpotsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ChargingSpotsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ChargingSpotsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ChargingSpotsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createChargingSpotsRecordData({
  int? parkingSpotNumber,
  int? chargingMode,
  double? chargingSpeedKW,
  DocumentReference? car,
  bool? isOccupied,
  bool? isCharging,
  DocumentReference? parkingLot,
  bool? isV2GActive,
  bool? isReserved,
  DocumentReference? user,
  DocumentReference? reservation,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'parkingSpotNumber': parkingSpotNumber,
      'chargingMode': chargingMode,
      'chargingSpeedKW': chargingSpeedKW,
      'car': car,
      'isOccupied': isOccupied,
      'isCharging': isCharging,
      'parkingLot': parkingLot,
      'isV2GActive': isV2GActive,
      'isReserved': isReserved,
      'user': user,
      'reservation': reservation,
    }.withoutNulls,
  );

  return firestoreData;
}

class ChargingSpotsRecordDocumentEquality
    implements Equality<ChargingSpotsRecord> {
  const ChargingSpotsRecordDocumentEquality();

  @override
  bool equals(ChargingSpotsRecord? e1, ChargingSpotsRecord? e2) {
    return e1?.parkingSpotNumber == e2?.parkingSpotNumber &&
        e1?.chargingMode == e2?.chargingMode &&
        e1?.chargingSpeedKW == e2?.chargingSpeedKW &&
        e1?.car == e2?.car &&
        e1?.isOccupied == e2?.isOccupied &&
        e1?.isCharging == e2?.isCharging &&
        e1?.parkingLot == e2?.parkingLot &&
        e1?.isV2GActive == e2?.isV2GActive &&
        e1?.isReserved == e2?.isReserved &&
        e1?.user == e2?.user &&
        e1?.reservation == e2?.reservation;
  }

  @override
  int hash(ChargingSpotsRecord? e) => const ListEquality().hash([
        e?.parkingSpotNumber,
        e?.chargingMode,
        e?.chargingSpeedKW,
        e?.car,
        e?.isOccupied,
        e?.isCharging,
        e?.parkingLot,
        e?.isV2GActive,
        e?.isReserved,
        e?.user,
        e?.reservation
      ]);

  @override
  bool isValidKey(Object? o) => o is ChargingSpotsRecord;
}
