import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future clearParkingSpot(BuildContext context) async {
  await currentUserDocument!.chargingSpot!.update(createChargingSpotsRecordData(
    reservation: null,
    isOccupied: false,
    chargingMode: 1,
    car: null,
    isCharging: false,
    isV2GActive: false,
    isReserved: false,
    user: null,
  ));
}
