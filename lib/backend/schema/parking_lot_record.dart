import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ParkingLotRecord extends FirestoreRecord {
  ParkingLotRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "availablePowerKwh" field.
  double? _availablePowerKwh;
  double get availablePowerKwh => _availablePowerKwh ?? 0.0;
  bool hasAvailablePowerKwh() => _availablePowerKwh != null;

  // "latLngPosition" field.
  LatLng? _latLngPosition;
  LatLng? get latLngPosition => _latLngPosition;
  bool hasLatLngPosition() => _latLngPosition != null;

  // "chargingSlots" field.
  List<DocumentReference>? _chargingSlots;
  List<DocumentReference> get chargingSlots => _chargingSlots ?? const [];
  bool hasChargingSlots() => _chargingSlots != null;

  // "maximumPowerKwh" field.
  double? _maximumPowerKwh;
  double get maximumPowerKwh => _maximumPowerKwh ?? 0.0;
  bool hasMaximumPowerKwh() => _maximumPowerKwh != null;

  // "reservationPricePerMinute" field.
  double? _reservationPricePerMinute;
  double get reservationPricePerMinute => _reservationPricePerMinute ?? 0.0;
  bool hasReservationPricePerMinute() => _reservationPricePerMinute != null;

  // "parkingPricePerMinute" field.
  double? _parkingPricePerMinute;
  double get parkingPricePerMinute => _parkingPricePerMinute ?? 0.0;
  bool hasParkingPricePerMinute() => _parkingPricePerMinute != null;

  void _initializeFields() {
    _availablePowerKwh = castToType<double>(snapshotData['availablePowerKwh']);
    _latLngPosition = snapshotData['latLngPosition'] as LatLng?;
    _chargingSlots = getDataList(snapshotData['chargingSlots']);
    _maximumPowerKwh = castToType<double>(snapshotData['maximumPowerKwh']);
    _reservationPricePerMinute =
        castToType<double>(snapshotData['reservationPricePerMinute']);
    _parkingPricePerMinute =
        castToType<double>(snapshotData['parkingPricePerMinute']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('parkingLot');

  static Stream<ParkingLotRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ParkingLotRecord.fromSnapshot(s));

  static Future<ParkingLotRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ParkingLotRecord.fromSnapshot(s));

  static ParkingLotRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ParkingLotRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ParkingLotRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ParkingLotRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ParkingLotRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ParkingLotRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createParkingLotRecordData({
  double? availablePowerKwh,
  LatLng? latLngPosition,
  double? maximumPowerKwh,
  double? reservationPricePerMinute,
  double? parkingPricePerMinute,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'availablePowerKwh': availablePowerKwh,
      'latLngPosition': latLngPosition,
      'maximumPowerKwh': maximumPowerKwh,
      'reservationPricePerMinute': reservationPricePerMinute,
      'parkingPricePerMinute': parkingPricePerMinute,
    }.withoutNulls,
  );

  return firestoreData;
}

class ParkingLotRecordDocumentEquality implements Equality<ParkingLotRecord> {
  const ParkingLotRecordDocumentEquality();

  @override
  bool equals(ParkingLotRecord? e1, ParkingLotRecord? e2) {
    const listEquality = ListEquality();
    return e1?.availablePowerKwh == e2?.availablePowerKwh &&
        e1?.latLngPosition == e2?.latLngPosition &&
        listEquality.equals(e1?.chargingSlots, e2?.chargingSlots) &&
        e1?.maximumPowerKwh == e2?.maximumPowerKwh &&
        e1?.reservationPricePerMinute == e2?.reservationPricePerMinute &&
        e1?.parkingPricePerMinute == e2?.parkingPricePerMinute;
  }

  @override
  int hash(ParkingLotRecord? e) => const ListEquality().hash([
        e?.availablePowerKwh,
        e?.latLngPosition,
        e?.chargingSlots,
        e?.maximumPowerKwh,
        e?.reservationPricePerMinute,
        e?.parkingPricePerMinute
      ]);

  @override
  bool isValidKey(Object? o) => o is ParkingLotRecord;
}
