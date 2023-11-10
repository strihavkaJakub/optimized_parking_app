import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PaymentsRecord extends FirestoreRecord {
  PaymentsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "paymentUser" field.
  DocumentReference? _paymentUser;
  DocumentReference? get paymentUser => _paymentUser;
  bool hasPaymentUser() => _paymentUser != null;

  // "paymentDate" field.
  DateTime? _paymentDate;
  DateTime? get paymentDate => _paymentDate;
  bool hasPaymentDate() => _paymentDate != null;

  // "paymentStatus" field.
  String? _paymentStatus;
  String get paymentStatus => _paymentStatus ?? '';
  bool hasPaymentStatus() => _paymentStatus != null;

  // "payment_amount" field.
  double? _paymentAmount;
  double get paymentAmount => _paymentAmount ?? 0.0;
  bool hasPaymentAmount() => _paymentAmount != null;

  // "paymentProduct" field.
  DocumentReference? _paymentProduct;
  DocumentReference? get paymentProduct => _paymentProduct;
  bool hasPaymentProduct() => _paymentProduct != null;

  // "paymentId" field.
  String? _paymentId;
  String get paymentId => _paymentId ?? '';
  bool hasPaymentId() => _paymentId != null;

  void _initializeFields() {
    _paymentUser = snapshotData['paymentUser'] as DocumentReference?;
    _paymentDate = snapshotData['paymentDate'] as DateTime?;
    _paymentStatus = snapshotData['paymentStatus'] as String?;
    _paymentAmount = castToType<double>(snapshotData['payment_amount']);
    _paymentProduct = snapshotData['paymentProduct'] as DocumentReference?;
    _paymentId = snapshotData['paymentId'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('payments');

  static Stream<PaymentsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PaymentsRecord.fromSnapshot(s));

  static Future<PaymentsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PaymentsRecord.fromSnapshot(s));

  static PaymentsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PaymentsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PaymentsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PaymentsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PaymentsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PaymentsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPaymentsRecordData({
  DocumentReference? paymentUser,
  DateTime? paymentDate,
  String? paymentStatus,
  double? paymentAmount,
  DocumentReference? paymentProduct,
  String? paymentId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'paymentUser': paymentUser,
      'paymentDate': paymentDate,
      'paymentStatus': paymentStatus,
      'payment_amount': paymentAmount,
      'paymentProduct': paymentProduct,
      'paymentId': paymentId,
    }.withoutNulls,
  );

  return firestoreData;
}

class PaymentsRecordDocumentEquality implements Equality<PaymentsRecord> {
  const PaymentsRecordDocumentEquality();

  @override
  bool equals(PaymentsRecord? e1, PaymentsRecord? e2) {
    return e1?.paymentUser == e2?.paymentUser &&
        e1?.paymentDate == e2?.paymentDate &&
        e1?.paymentStatus == e2?.paymentStatus &&
        e1?.paymentAmount == e2?.paymentAmount &&
        e1?.paymentProduct == e2?.paymentProduct &&
        e1?.paymentId == e2?.paymentId;
  }

  @override
  int hash(PaymentsRecord? e) => const ListEquality().hash([
        e?.paymentUser,
        e?.paymentDate,
        e?.paymentStatus,
        e?.paymentAmount,
        e?.paymentProduct,
        e?.paymentId
      ]);

  @override
  bool isValidKey(Object? o) => o is PaymentsRecord;
}
