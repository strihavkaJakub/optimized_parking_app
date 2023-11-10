import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/stripe/payment_manager.dart';
import '/components/charging_progress_bar_component_widget.dart';
import '/components/loading_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/instant_timer.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget>
    with TickerProviderStateMixin {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'imageOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(79.0, 0.0),
          end: Offset(0.0, 0.0),
        ),
        ScaleEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(1.0, 0.0),
          end: Offset(1.0, 1.0),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (currentUserReference?.id == null || currentUserReference?.id == '') {
        context.goNamed('Login');
      } else if ((currentUserDocument?.car?.id == null ||
              currentUserDocument?.car?.id == '') &&
          (currentUserDocument?.chargingSpot?.id == null ||
              currentUserDocument?.chargingSpot?.id == '')) {
        context.pushNamed('onboarding');
      } else if ((currentUserDocument?.car?.id == null ||
              currentUserDocument?.car?.id == '') &&
          (currentUserDocument?.chargingSpot?.id != null &&
              currentUserDocument?.chargingSpot?.id != '')) {
        context.goNamed('reservationPending');
      } else {
        _model.parkingPriceTimer = InstantTimer.periodic(
          duration: Duration(milliseconds: 1000),
          callback: (timer) async {
            setState(() {});
          },
          startImmediately: true,
        );
      }
    });

    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

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

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).background,
      body: SafeArea(
        top: true,
        child: AuthUserStreamWidget(
          builder: (context) => StreamBuilder<CarRecord>(
            stream: CarRecord.getDocument(currentUserDocument!.car!),
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
              final columnCarRecord = snapshot.data!;
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 16.0, 24.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Your Car',
                            style: FlutterFlowTheme.of(context).bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 0.0, 0.0),
                          child: Text(
                            columnCarRecord.vehicleRegistrationPlate,
                            style: FlutterFlowTheme.of(context)
                                .displaySmall
                                .override(
                                  fontFamily: 'Outfit',
                                  color: FlutterFlowTheme.of(context).dark400,
                                ),
                          ),
                        ),
                      ],
                    ),
                    Image.asset(
                      'assets/images/shutterstock_678961774.png',
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: 240.0,
                      fit: BoxFit.fitHeight,
                    ).animateOnPageLoad(
                        animationsMap['imageOnPageLoadAnimation']!),
                    wrapWithModel(
                      model: _model.chargingProgressBarComponentModel,
                      updateCallback: () => setState(() {}),
                      child: ChargingProgressBarComponentWidget(),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          12.0, 20.0, 12.0, 12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 8.0),
                                child: Text(
                                  'Desired departure time',
                                  style: FlutterFlowTheme.of(context).bodySmall,
                                ),
                              ),
                              Text(
                                valueOrDefault<String>(
                                  dateTimeFormat(
                                    'd/M H:mm',
                                    columnCarRecord.desiredDepartureDateTime,
                                    locale: FFLocalizations.of(context)
                                        .languageCode,
                                  ),
                                  'Not set',
                                ),
                                style:
                                    FlutterFlowTheme.of(context).displaySmall,
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 8.0),
                                child: Text(
                                  'Current range',
                                  style: FlutterFlowTheme.of(context).bodySmall,
                                ),
                              ),
                              Text(
                                valueOrDefault<String>(
                                  '${formatNumber(
                                    functions.calculateRange(
                                        columnCarRecord.batterySizeKwh,
                                        columnCarRecord.batteryChargePercentage,
                                        columnCarRecord.averageConsumptionKWh),
                                    formatType: FormatType.decimal,
                                    decimalType: DecimalType.automatic,
                                  )} km',
                                  '0',
                                ),
                                style:
                                    FlutterFlowTheme.of(context).displaySmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    StreamBuilder<ChargingSpotsRecord>(
                      stream: ChargingSpotsRecord.getDocument(
                          columnCarRecord.carChargingSpot!),
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
                        final containerChargingSpotsRecord = snapshot.data!;
                        return Container(
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          height: 100.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if (containerChargingSpotsRecord.isCharging ==
                                  true)
                                Container(
                                  width: MediaQuery.sizeOf(context).width * 0.9,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).primary,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 3.0,
                                        color: Color(0x39000000),
                                        offset: Offset(0.0, 1.0),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(8.0),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 16.0, 0.0, 0.0),
                                        child: Icon(
                                          Icons.electric_car,
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          size: 44.0,
                                        ),
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 8.0, 0.0, 0.0),
                                            child: AutoSizeText(
                                              'Car Charging',
                                              textAlign: TextAlign.center,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMedium
                                                      .override(
                                                        fontFamily: 'Outfit',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate,
                                                      ),
                                            ),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(8.0, 4.0, 8.0, 0.0),
                                              child: Text(
                                                'Current Status',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.getFont(
                                                  'Lexend Deca',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .customColor1,
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (functions.calculateChargingTimeUntilDesiredCharge(
                                                      containerChargingSpotsRecord
                                                          .chargingSpeedKW,
                                                      columnCarRecord
                                                          .batteryChargePercentage,
                                                      columnCarRecord
                                                          .desiredChargeAtDeparture,
                                                      columnCarRecord
                                                          .batterySizeKwh) !=
                                                  null &&
                                              functions.calculateChargingTimeUntilDesiredCharge(
                                                      containerChargingSpotsRecord
                                                          .chargingSpeedKW,
                                                      columnCarRecord
                                                          .batteryChargePercentage,
                                                      columnCarRecord
                                                          .desiredChargeAtDeparture,
                                                      columnCarRecord
                                                          .batterySizeKwh) !=
                                                  '')
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        8.0, 4.0, 8.0, 0.0),
                                                child: Text(
                                                  '${functions.calculateChargingTimeUntilDesiredCharge(containerChargingSpotsRecord.chargingSpeedKW, columnCarRecord.batteryChargePercentage, columnCarRecord.desiredChargeAtDeparture, columnCarRecord.batterySizeKwh)} until desired charge',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.getFont(
                                                    'Lexend Deca',
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .customColor1,
                                                    fontSize: 12.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(8.0, 4.0, 8.0, 0.0),
                                              child: Text(
                                                'Charging speed: ${formatNumber(
                                                  containerChargingSpotsRecord
                                                      .chargingSpeedKW,
                                                  formatType:
                                                      FormatType.decimal,
                                                  decimalType:
                                                      DecimalType.automatic,
                                                )} kW',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.getFont(
                                                  'Lexend Deca',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .customColor1,
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              if (containerChargingSpotsRecord.isCharging ==
                                  false)
                                Container(
                                  width: MediaQuery.sizeOf(context).width * 0.9,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .customColor3,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 3.0,
                                        color: Color(0x39000000),
                                        offset: Offset(0.0, 1.0),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(8.0),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 16.0, 0.0, 0.0),
                                        child: Icon(
                                          Icons.electric_car,
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          size: 44.0,
                                        ),
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 8.0, 0.0, 0.0),
                                            child: AutoSizeText(
                                              'Car not Charging',
                                              textAlign: TextAlign.center,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMedium
                                                      .override(
                                                        fontFamily: 'Outfit',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate,
                                                      ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.4,
                            height: 150.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).secondary,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4.0,
                                  color: Color(0x37000000),
                                  offset: Offset(0.0, 1.0),
                                )
                              ],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pushNamed(
                                  'chargingMenu',
                                  extra: <String, dynamic>{
                                    kTransitionInfoKey: TransitionInfo(
                                      hasTransition: true,
                                      transitionType:
                                          PageTransitionType.bottomToTop,
                                      duration: Duration(milliseconds: 250),
                                    ),
                                  },
                                );
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 16.0, 0.0, 0.0),
                                    child: Icon(
                                      Icons.bolt,
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      size: 44.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 8.0, 0.0, 0.0),
                                    child: AutoSizeText(
                                      'Charge options',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .override(
                                            fontFamily: 'Outfit',
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                          ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8.0, 4.0, 8.0, 0.0),
                                      child: Text(
                                        'View charging options',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.getFont(
                                          'Lexend Deca',
                                          color: Color(0xB3FFFFFF),
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.4,
                            height: 150.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).secondary,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4.0,
                                  color: Color(0x37000000),
                                  offset: Offset(0.0, 1.0),
                                )
                              ],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: StreamBuilder<ParkingLotRecord>(
                              stream: ParkingLotRecord.getDocument(
                                  currentUserDocument!.parkingLot!),
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
                                final columnParkingLotRecord = snapshot.data!;
                                return InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      isDismissible: false,
                                      enableDrag: false,
                                      context: context,
                                      builder: (context) {
                                        return Padding(
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: Container(
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.8,
                                            child: LoadingWidget(),
                                          ),
                                        );
                                      },
                                    ).then((value) => safeSetState(() {}));

                                    await currentUserReference!
                                        .update(createUsersRecordData(
                                      parkingPrice:
                                          functions.calculateParkingPrice(
                                              columnCarRecord.parkedFrom!,
                                              getCurrentTimestamp,
                                              columnParkingLotRecord
                                                  .parkingPricePerMinute),
                                    ));

                                    await columnCarRecord.reference
                                        .update(createCarRecordData(
                                      parkingPrice:
                                          functions.calculateParkingPrice(
                                              columnCarRecord.parkedFrom!,
                                              getCurrentTimestamp,
                                              columnParkingLotRecord
                                                  .parkingPricePerMinute),
                                    ));
                                    final paymentResponse =
                                        await processStripePayment(
                                      context,
                                      amount: functions.convertPriceForPayment(
                                          functions.calculateTotalPrice(
                                              valueOrDefault(
                                                  currentUserDocument
                                                      ?.reservationPrice,
                                                  0.0),
                                              valueOrDefault(
                                                  currentUserDocument
                                                      ?.chargingPrice,
                                                  0.0),
                                              columnCarRecord.parkingPrice)),
                                      currency: 'EUR',
                                      customerEmail: currentUserEmail,
                                      allowGooglePay: false,
                                      allowApplePay: false,
                                      themeStyle: ThemeMode.system,
                                    );
                                    if (paymentResponse.paymentId == null &&
                                        paymentResponse.errorMessage != null) {
                                      showSnackbar(
                                        context,
                                        'Error: ${paymentResponse.errorMessage}',
                                      );
                                    }
                                    _model.paymentId =
                                        paymentResponse.paymentId ?? '';

                                    if (_model.paymentId != null &&
                                        _model.paymentId != '') {
                                      var paymentsRecordReference =
                                          PaymentsRecord.collection.doc();
                                      await paymentsRecordReference
                                          .set(createPaymentsRecordData(
                                        paymentUser: currentUserReference,
                                        paymentDate: getCurrentTimestamp,
                                        paymentStatus: 'Complete',
                                        paymentAmount:
                                            functions.calculateTotalPrice(
                                                valueOrDefault(
                                                    currentUserDocument
                                                        ?.reservationPrice,
                                                    0.0),
                                                valueOrDefault(
                                                    currentUserDocument
                                                        ?.chargingPrice,
                                                    0.0),
                                                valueOrDefault(
                                                    currentUserDocument
                                                        ?.parkingPrice,
                                                    0.0)),
                                        paymentId: _model.paymentId,
                                        paymentProduct:
                                            columnCarRecord.reference,
                                      ));
                                      _model.outputPayment =
                                          PaymentsRecord.getDocumentFromData(
                                              createPaymentsRecordData(
                                                paymentUser:
                                                    currentUserReference,
                                                paymentDate:
                                                    getCurrentTimestamp,
                                                paymentStatus: 'Complete',
                                                paymentAmount: functions
                                                    .calculateTotalPrice(
                                                        valueOrDefault(
                                                            currentUserDocument
                                                                ?.reservationPrice,
                                                            0.0),
                                                        valueOrDefault(
                                                            currentUserDocument
                                                                ?.chargingPrice,
                                                            0.0),
                                                        valueOrDefault(
                                                            currentUserDocument
                                                                ?.parkingPrice,
                                                            0.0)),
                                                paymentId: _model.paymentId,
                                                paymentProduct:
                                                    columnCarRecord.reference,
                                              ),
                                              paymentsRecordReference);

                                      await columnCarRecord.reference
                                          .update(createCarRecordData(
                                        carPayment:
                                            _model.outputPayment?.reference,
                                        parkingPrice: valueOrDefault(
                                            currentUserDocument?.parkingPrice,
                                            0.0),
                                      ));

                                      context.pushNamed(
                                        'paymentComplete',
                                        queryParameters: {
                                          'payedPrice': serializeParam(
                                            functions.calculateTotalPrice(
                                                valueOrDefault(
                                                    currentUserDocument
                                                        ?.reservationPrice,
                                                    0.0),
                                                valueOrDefault(
                                                    currentUserDocument
                                                        ?.chargingPrice,
                                                    0.0),
                                                columnCarRecord.parkingPrice),
                                            ParamType.double,
                                          ),
                                          'isParkingPayment': serializeParam(
                                            true,
                                            ParamType.bool,
                                          ),
                                        }.withoutNulls,
                                      );
                                    } else {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Error has occured. Please try again.',
                                            style: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                          ),
                                          duration:
                                              Duration(milliseconds: 4000),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondary,
                                        ),
                                      );
                                    }

                                    setState(() {});
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 16.0, 0.0, 0.0),
                                        child: Icon(
                                          Icons.exit_to_app,
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          size: 44.0,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 8.0, 0.0, 0.0),
                                        child: AutoSizeText(
                                          'Pay and Exit',
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .titleMedium
                                              .override(
                                                fontFamily: 'Outfit',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                              ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8.0, 4.0, 8.0, 0.0),
                                          child: Text(
                                            'End your parking',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.getFont(
                                              'Lexend Deca',
                                              color: Color(0xB3FFFFFF),
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8.0, 4.0, 8.0, 0.0),
                                          child: Text(
                                            formatNumber(
                                              functions.calculateTotalPrice(
                                                  valueOrDefault(
                                                      currentUserDocument
                                                          ?.reservationPrice,
                                                      0.0),
                                                  valueOrDefault(
                                                      currentUserDocument
                                                          ?.chargingPrice,
                                                      0.0),
                                                  functions.calculateParkingPrice(
                                                      columnCarRecord
                                                          .parkedFrom!,
                                                      getCurrentTimestamp,
                                                      columnParkingLotRecord
                                                          .parkingPricePerMinute)),
                                              formatType: FormatType.decimal,
                                              decimalType:
                                                  DecimalType.automatic,
                                              currency: '\$',
                                            ),
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.getFont(
                                              'Lexend Deca',
                                              color: Color(0xB3FFFFFF),
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
