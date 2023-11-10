import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/stripe/payment_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/instant_timer.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'reservation_pending_model.dart';
export 'reservation_pending_model.dart';

class ReservationPendingWidget extends StatefulWidget {
  const ReservationPendingWidget({Key? key}) : super(key: key);

  @override
  _ReservationPendingWidgetState createState() =>
      _ReservationPendingWidgetState();
}

class _ReservationPendingWidgetState extends State<ReservationPendingWidget> {
  late ReservationPendingModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReservationPendingModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (currentUserDocument?.reservation?.id != null &&
          currentUserDocument?.reservation?.id != '') {
        _model.instantTimer = InstantTimer.periodic(
          duration: Duration(milliseconds: 1000),
          callback: (timer) async {
            setState(() {});
          },
          startImmediately: true,
        );
      } else {
        context.goNamed('HomePage');
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return AuthUserStreamWidget(
      builder: (context) => StreamBuilder<ReservationsRecord>(
        stream:
            ReservationsRecord.getDocument(currentUserDocument!.reservation!),
        builder: (context, snapshot) {
          // Customize what your widget looks like when it's loading.
          if (!snapshot.hasData) {
            return Scaffold(
              backgroundColor: FlutterFlowTheme.of(context).customColor1,
              body: Center(
                child: SizedBox(
                  width: 50.0,
                  height: 50.0,
                  child: SpinKitCubeGrid(
                    color: FlutterFlowTheme.of(context).primary,
                    size: 50.0,
                  ),
                ),
              ),
            );
          }
          final reservationPendingReservationsRecord = snapshot.data!;
          return GestureDetector(
            onTap: () => _model.unfocusNode.canRequestFocus
                ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                : FocusScope.of(context).unfocus(),
            child: WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                key: scaffoldKey,
                backgroundColor: FlutterFlowTheme.of(context).customColor1,
                body: SafeArea(
                  top: true,
                  child: StreamBuilder<List<CarRecord>>(
                    stream: queryCarRecord(
                      singleRecord: true,
                    ),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 50.0,
                            height: 50.0,
                            child: SpinKitCubeGrid(
                              color: FlutterFlowTheme.of(context).primary,
                              size: 50.0,
                            ),
                          ),
                        );
                      }
                      List<CarRecord> columnCarRecordList = snapshot.data!;
                      final columnCarRecord = columnCarRecordList.isNotEmpty
                          ? columnCarRecordList.first
                          : null;
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.safety_check_sharp,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 200.0,
                                ),
                              ],
                            ),
                            StreamBuilder<ChargingSpotsRecord>(
                              stream: ChargingSpotsRecord.getDocument(
                                  reservationPendingReservationsRecord
                                      .parkingSpot!),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 50.0,
                                      height: 50.0,
                                      child: SpinKitCubeGrid(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 50.0,
                                      ),
                                    ),
                                  );
                                }
                                final formChargingSpotsRecord = snapshot.data!;
                                return Form(
                                  key: _model.formKey,
                                  autovalidateMode: AutovalidateMode.disabled,
                                  child: StreamBuilder<ParkingLotRecord>(
                                    stream: ParkingLotRecord.getDocument(
                                        formChargingSpotsRecord.parkingLot!),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: 50.0,
                                            height: 50.0,
                                            child: SpinKitCubeGrid(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              size: 50.0,
                                            ),
                                          ),
                                        );
                                      }
                                      final columnParkingLotRecord =
                                          snapshot.data!;
                                      return Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Align(
                                            alignment: AlignmentDirectional(
                                                0.00, 0.00),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      20.0, 0.0, 20.0, 16.0),
                                              child: Text(
                                                'Parking spot is reserved. \nYou will be charged \$0.01 for every minute. First 50 minutes are included in a reservation fee. ',
                                                textAlign: TextAlign.center,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Outfit',
                                                          fontSize: 20.0,
                                                        ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: AlignmentDirectional(
                                                0.00, 0.00),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      20.0, 0.0, 20.0, 16.0),
                                              child: Text(
                                                'Reserved from:',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Outfit',
                                                          fontSize: 20.0,
                                                        ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: AlignmentDirectional(
                                                0.00, 0.00),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      20.0, 0.0, 20.0, 16.0),
                                              child: Text(
                                                dateTimeFormat(
                                                  'd/M H:mm',
                                                  reservationPendingReservationsRecord
                                                      .reservedFrom!,
                                                  locale: FFLocalizations.of(
                                                          context)
                                                      .languageCode,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Outfit',
                                                          fontSize: 20.0,
                                                        ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: AlignmentDirectional(
                                                0.00, 0.00),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      20.0, 0.0, 20.0, 16.0),
                                              child: Text(
                                                'Current price: ',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Outfit',
                                                          fontSize: 20.0,
                                                        ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: AlignmentDirectional(
                                                0.00, 0.00),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      20.0, 0.0, 20.0, 16.0),
                                              child: Text(
                                                formatNumber(
                                                  functions.calculatReservationPrice(
                                                      reservationPendingReservationsRecord
                                                          .reservedFrom!,
                                                      getCurrentTimestamp,
                                                      columnParkingLotRecord
                                                          .reservationPricePerMinute),
                                                  formatType:
                                                      FormatType.decimal,
                                                  decimalType:
                                                      DecimalType.automatic,
                                                  currency: '\$',
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Outfit',
                                                          fontSize: 20.0,
                                                        ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: AlignmentDirectional(
                                                0.00, 0.05),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 24.0, 0.0, 0.0),
                                              child: FFButtonWidget(
                                                onPressed: () async {
                                                  await currentUserReference!
                                                      .update(
                                                          createUsersRecordData(
                                                    reservationPrice:
                                                        functions.calculatReservationPrice(
                                                            reservationPendingReservationsRecord
                                                                .reservedFrom!,
                                                            getCurrentTimestamp,
                                                            columnParkingLotRecord
                                                                .reservationPricePerMinute),
                                                  ));

                                                  await reservationPendingReservationsRecord
                                                      .reference
                                                      .update(
                                                          createReservationsRecordData(
                                                    reservedTo:
                                                        getCurrentTimestamp,
                                                    price: valueOrDefault(
                                                        currentUserDocument
                                                            ?.reservationPrice,
                                                        0.0),
                                                  ));

                                                  context.goNamed(
                                                      'addCarAfterReservation');
                                                },
                                                text: 'Arrived - Park car',
                                                options: FFButtonOptions(
                                                  width: 230.0,
                                                  height: 50.0,
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 0.0, 0.0),
                                                  iconPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(0.0, 0.0,
                                                              0.0, 0.0),
                                                  color: Color(0xFF39D2C0),
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color: Colors.white,
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                  elevation: 2.0,
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: AlignmentDirectional(
                                                0.00, 0.05),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 24.0, 0.0, 40.0),
                                              child: FFButtonWidget(
                                                onPressed: () async {
                                                  if (_model.formKey
                                                              .currentState ==
                                                          null ||
                                                      !_model
                                                          .formKey.currentState!
                                                          .validate()) {
                                                    return;
                                                  }
                                                  var confirmDialogResponse =
                                                      await showDialog<bool>(
                                                            context: context,
                                                            builder:
                                                                (alertDialogContext) {
                                                              return AlertDialog(
                                                                title: Text(
                                                                    'Are you sure want to cancel your reservation?'),
                                                                content: Text(
                                                                    'You will be redirected to a payment'),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            alertDialogContext,
                                                                            false),
                                                                    child: Text(
                                                                        'Cancel'),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            alertDialogContext,
                                                                            true),
                                                                    child: Text(
                                                                        'Confirm'),
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          ) ??
                                                          false;
                                                  if (confirmDialogResponse) {
                                                    final paymentResponse =
                                                        await processStripePayment(
                                                      context,
                                                      amount: functions.convertPriceForPayment(
                                                          functions.calculatReservationPrice(
                                                              reservationPendingReservationsRecord
                                                                  .reservedFrom!,
                                                              getCurrentTimestamp,
                                                              columnParkingLotRecord
                                                                  .reservationPricePerMinute)),
                                                      currency: 'EUR',
                                                      customerEmail:
                                                          currentUserEmail,
                                                      description: 'Parking',
                                                      allowGooglePay: false,
                                                      allowApplePay: false,
                                                      themeStyle:
                                                          ThemeMode.system,
                                                    );
                                                    if (paymentResponse
                                                                .paymentId ==
                                                            null &&
                                                        paymentResponse
                                                                .errorMessage !=
                                                            null) {
                                                      showSnackbar(
                                                        context,
                                                        'Error: ${paymentResponse.errorMessage}',
                                                      );
                                                    }
                                                    _model.paymentId =
                                                        paymentResponse
                                                                .paymentId ??
                                                            '';

                                                    if (_model.paymentId !=
                                                            null &&
                                                        _model.paymentId !=
                                                            '') {
                                                      await PaymentsRecord
                                                          .collection
                                                          .doc()
                                                          .set(
                                                              createPaymentsRecordData(
                                                            paymentUser:
                                                                currentUserReference,
                                                            paymentDate:
                                                                getCurrentTimestamp,
                                                            paymentStatus:
                                                                'Complete',
                                                            paymentAmount: functions.calculatReservationPrice(
                                                                reservationPendingReservationsRecord
                                                                    .reservedFrom!,
                                                                getCurrentTimestamp,
                                                                columnParkingLotRecord
                                                                    .reservationPricePerMinute),
                                                            paymentId: _model
                                                                .paymentId,
                                                          ));

                                                      context.goNamed(
                                                        'paymentComplete',
                                                        queryParameters: {
                                                          'payedPrice':
                                                              serializeParam(
                                                            functions.calculatReservationPrice(
                                                                reservationPendingReservationsRecord
                                                                    .reservedFrom!,
                                                                getCurrentTimestamp,
                                                                columnParkingLotRecord
                                                                    .reservationPricePerMinute),
                                                            ParamType.double,
                                                          ),
                                                          'isParkingPayment':
                                                              serializeParam(
                                                            false,
                                                            ParamType.bool,
                                                          ),
                                                        }.withoutNulls,
                                                      );
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            'Payment failed. Please try it again.',
                                                            style: TextStyle(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryText,
                                                            ),
                                                          ),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  4000),
                                                          backgroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .secondary,
                                                        ),
                                                      );
                                                    }
                                                  }

                                                  setState(() {});
                                                },
                                                text:
                                                    'Cancel reservation and pay',
                                                options: FFButtonOptions(
                                                  width: 230.0,
                                                  height: 50.0,
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 0.0, 0.0),
                                                  iconPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(0.0, 0.0,
                                                              0.0, 0.0),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color: Colors.white,
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                  elevation: 2.0,
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
