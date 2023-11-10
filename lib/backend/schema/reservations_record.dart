import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ReservationsRecord extends FirestoreRecord {
  ReservationsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "reservedFrom" field.
  DateTime? _reservedFrom;
  DateTime? get reservedFrom => _reservedFrom;
  bool hasReservedFrom() => _reservedFrom != null;

  // "reservedTo" field.
  DateTime? _reservedTo;
  DateTime? get reservedTo => _reservedTo;
  bool hasReservedTo() => _reservedTo != null;

  // "price" field.
  double? _price;
  double get price => _price ?? 0.0;
  bool hasPrice() => _price != null;

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  bool hasUser() => _user != null;

  // "parkingSpot" field.
  DocumentReference? _parkingSpot;
  DocumentReference? get parkingSpot => _parkingSpot;
  bool hasParkingSpot() => _parkingSpot != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _reservedFrom = snapshotData['reservedFrom'] as DateTime?;
    _reservedTo = snapshotData['reservedTo'] as DateTime?;
    _price = castToType<double>(snapshotData['price']);
    _user = snapshotData['user'] as DocumentReference?;
    _parkingSpot = snapshotData['parkingSpot'] as DocumentReference?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('reservations')
          : FirebaseFirestore.instance.collectionGroup('reservations');

  static DocumentReference createDoc(DocumentReference parent) =>
      parent.collection('reservations').doc();

  static Stream<ReservationsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ReservationsRecord.fromSnapshot(s));

  static Future<ReservationsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ReservationsRecord.fromSnapshot(s));

  static ReservationsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ReservationsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ReservationsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ReservationsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ReservationsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ReservationsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createReservationsRecordData({
  DateTime? reservedFrom,
  DateTime? reservedTo,
  double? price,
  DocumentReference? user,
  DocumentReference? parkingSpot,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'reservedFrom': reservedFrom,
      'reservedTo': reservedTo,
      'price': price,
      'user': user,
      'parkingSpot': parkingSpot,
    }.withoutNulls,
  );

  return firestoreData;
}

class ReservationsRecordDocumentEquality
    implements Equality<ReservationsRecord> {
  const ReservationsRecordDocumentEquality();

  @override
  bool equals(ReservationsRecord? e1, ReservationsRecord? e2) {
    return e1?.reservedFrom == e2?.reservedFrom &&
        e1?.reservedTo == e2?.reservedTo &&
        e1?.price == e2?.price &&
        e1?.user == e2?.user &&
        e1?.parkingSpot == e2?.parkingSpot;
  }

  @override
  int hash(ReservationsRecord? e) => const ListEquality().hash(
      [e?.reservedFrom, e?.reservedTo, e?.price, e?.user, e?.parkingSpot]);

  @override
  bool isValidKey(Object? o) => o is ReservationsRecord;
}
