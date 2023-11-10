import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

double calculateRange(
  double batterySIzeKwh,
  double currentChargePercentage,
  double averageConsumptionKwh,
) {
  return (batterySIzeKwh * currentChargePercentage) / averageConsumptionKwh;
}

double calculateParkingPrice(
  DateTime parkingFrom,
  DateTime parkingTo,
  double parkingPricePerMinute,
) {
  double price =
      (parkingTo.millisecondsSinceEpoch - parkingFrom.millisecondsSinceEpoch) /
          1000 /
          60 *
          parkingPricePerMinute;
  double roundedPrice = double.parse((price).toStringAsFixed(2));
  return roundedPrice;
}

String calculateChargingTimeUntilFull(
  double chargingSpeed,
  double batterySize,
  double currentCharge,
) {
  final double capacityToCharge = batterySize - currentCharge;
  final double time = capacityToCharge / chargingSpeed * 60;
  return getTimeStringFromMinutes(time);
}

int stringToInt(String string) {
  int tries;

  try {
    tries = int.parse(string);
  } catch (err) {
    return 0;
  }

  return tries;
}

double calculatReservationPrice(
  DateTime reservationFrom,
  DateTime reservationTo,
  double reservationPricePerMinute,
) {
  double price = (reservationTo.millisecondsSinceEpoch -
          reservationFrom.millisecondsSinceEpoch) /
      1000 /
      60 *
      reservationPricePerMinute;
  double roundedPrice = double.parse((price).toStringAsFixed(2));
  if (roundedPrice < 0.5) return 0.50;
  return roundedPrice;
}

String? calculateChargingTimeUntilDesiredCharge(
  double chargingSpeed,
  double currentCharge,
  int desiredCharge,
  double batterySIzeKwh,
) {
  if (desiredCharge > currentCharge) {
    double percentToCharge = desiredCharge - currentCharge;
    double capacityToCharge = batterySIzeKwh * percentToCharge / 100;
    double time = capacityToCharge / chargingSpeed * 60;
    return getTimeStringFromMinutes(time);
  }
  return null;
}

String getTimeStringFromMinutes(double value) {
  final int hour = value ~/ 60;
  final int minutes = (value % 60).floor();
  return '${hour.toString().padLeft(2, "0")}h ${minutes.toString().padLeft(2, "0")}m';
}

int convertPriceForPayment(double paymentSum) {
  return (paymentSum * 100).toInt();
}

double calculateTotalPrice(
  double? reservationPrice,
  double? chargingPrice,
  double parkingPrice,
) {
  double total =
      ((reservationPrice ?? 0) + (chargingPrice ?? 0) + parkingPrice);
  if (total < 0.5)
    return 0.5;
  else
    return ((reservationPrice ?? 0) + (chargingPrice ?? 0) + parkingPrice);
}

double stringToDouble(String string) {
  double tries;

  try {
    tries = double.parse(string);
  } catch (err) {
    return 0;
  }

  return tries;
}
