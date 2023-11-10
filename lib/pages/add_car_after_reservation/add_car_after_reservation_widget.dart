import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/battery_limit_slider_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'add_car_after_reservation_model.dart';
export 'add_car_after_reservation_model.dart';

class AddCarAfterReservationWidget extends StatefulWidget {
  const AddCarAfterReservationWidget({Key? key}) : super(key: key);

  @override
  _AddCarAfterReservationWidgetState createState() =>
      _AddCarAfterReservationWidgetState();
}

class _AddCarAfterReservationWidgetState
    extends State<AddCarAfterReservationWidget> with TickerProviderStateMixin {
  late AddCarAfterReservationModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'imageOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(0.0, 39.0),
          end: Offset(0.0, 0.0),
        ),
        ScaleEffect(
          curve: Curves.easeInOut,
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
    _model = createModel(context, () => AddCarAfterReservationModel());

    _model.vehicleRegistraionPlateController ??= TextEditingController();
    _model.vehicleRegistraionPlateFocusNode ??= FocusNode();

    _model.batterySizeController ??= TextEditingController();
    _model.batterySizeFocusNode ??= FocusNode();

    _model.averageConsumptionController ??= TextEditingController();
    _model.averageConsumptionFocusNode ??= FocusNode();

    _model.chargePercentageController ??= TextEditingController();
    _model.chargePercentageFocusNode ??= FocusNode();

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

    return AuthUserStreamWidget(
      builder: (context) => StreamBuilder<ChargingSpotsRecord>(
        stream:
            ChargingSpotsRecord.getDocument(currentUserDocument!.chargingSpot!),
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
          final addCarAfterReservationChargingSpotsRecord = snapshot.data!;
          return Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).customColor1,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).customColor1,
              automaticallyImplyLeading: false,
              leading: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  context.pop();
                },
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: FlutterFlowTheme.of(context).dark400,
                  size: 24.0,
                ),
              ),
              title: Text(
                'Add Your Car',
                style: FlutterFlowTheme.of(context).titleSmall,
              ),
              actions: [],
              centerTitle: false,
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/shutterstock_678961774.png',
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: 200.0,
                          fit: BoxFit.fitHeight,
                        ).animateOnPageLoad(
                            animationsMap['imageOnPageLoadAnimation']!),
                      ],
                    ),
                    Form(
                      key: _model.formKey,
                      autovalidateMode: AutovalidateMode.disabled,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          wrapWithModel(
                            model: _model.batteryLimitSliderModel,
                            updateCallback: () => setState(() {}),
                            child: BatteryLimitSliderWidget(),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 16.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Planned departure time',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium,
                                    ),
                                    Text(
                                      valueOrDefault<String>(
                                        _model.datePicked?.toString(),
                                        'Please set',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium,
                                    ),
                                  ],
                                ),
                                FFButtonWidget(
                                  onPressed: () async {
                                    if (kIsWeb) {
                                      final _datePickedDate =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: getCurrentTimestamp,
                                        firstDate: getCurrentTimestamp,
                                        lastDate: DateTime(2050),
                                      );

                                      TimeOfDay? _datePickedTime;
                                      if (_datePickedDate != null) {
                                        _datePickedTime = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.fromDateTime(
                                              getCurrentTimestamp),
                                        );
                                      }

                                      if (_datePickedDate != null &&
                                          _datePickedTime != null) {
                                        safeSetState(() {
                                          _model.datePicked = DateTime(
                                            _datePickedDate.year,
                                            _datePickedDate.month,
                                            _datePickedDate.day,
                                            _datePickedTime!.hour,
                                            _datePickedTime.minute,
                                          );
                                        });
                                      }
                                    } else {
                                      await DatePicker.showDateTimePicker(
                                        context,
                                        showTitleActions: true,
                                        onConfirm: (date) {
                                          safeSetState(() {
                                            _model.datePicked = date;
                                          });
                                        },
                                        currentTime: getCurrentTimestamp,
                                        minTime: getCurrentTimestamp,
                                        locale: LocaleType.values.firstWhere(
                                          (l) =>
                                              l.name ==
                                              FFLocalizations.of(context)
                                                  .languageCode,
                                          orElse: () => LocaleType.en,
                                        ),
                                      );
                                    }
                                  },
                                  text: 'Set',
                                  options: FFButtonOptions(
                                    height: 40.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24.0, 0.0, 24.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context).primary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Outfit',
                                          color: Colors.white,
                                        ),
                                    elevation: 3.0,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ].divide(SizedBox(width: 50.0)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 0.0, 20.0, 16.0),
                            child: TextFormField(
                              controller:
                                  _model.vehicleRegistraionPlateController,
                              focusNode:
                                  _model.vehicleRegistraionPlateFocusNode,
                              onChanged: (_) => EasyDebounce.debounce(
                                '_model.vehicleRegistraionPlateController',
                                Duration(milliseconds: 2000),
                                () => setState(() {}),
                              ),
                              textInputAction: TextInputAction.next,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Vehicle registration plate',
                                labelStyle:
                                    FlutterFlowTheme.of(context).bodySmall,
                                hintStyle:
                                    FlutterFlowTheme.of(context).bodySmall,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .grayLighter,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                filled: true,
                                fillColor:
                                    FlutterFlowTheme.of(context).customColor1,
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 24.0, 0.0, 24.0),
                                suffixIcon: _model
                                        .vehicleRegistraionPlateController!
                                        .text
                                        .isNotEmpty
                                    ? InkWell(
                                        onTap: () async {
                                          _model
                                              .vehicleRegistraionPlateController
                                              ?.clear();
                                          setState(() {});
                                        },
                                        child: Icon(
                                          Icons.clear,
                                          color: Color(0xFF757575),
                                          size: 22.0,
                                        ),
                                      )
                                    : null,
                              ),
                              style: FlutterFlowTheme.of(context).bodyMedium,
                              validator: _model
                                  .vehicleRegistraionPlateControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 0.0, 20.0, 12.0),
                            child: TextFormField(
                              controller: _model.batterySizeController,
                              focusNode: _model.batterySizeFocusNode,
                              textInputAction: TextInputAction.next,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Battery size (kWh)',
                                labelStyle:
                                    FlutterFlowTheme.of(context).bodySmall,
                                hintStyle:
                                    FlutterFlowTheme.of(context).bodySmall,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .grayLighter,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                filled: true,
                                fillColor:
                                    FlutterFlowTheme.of(context).customColor1,
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 24.0, 0.0, 24.0),
                              ),
                              style: FlutterFlowTheme.of(context).bodyMedium,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              validator: _model.batterySizeControllerValidator
                                  .asValidator(context),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[\\d\\.]'))
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 0.0, 20.0, 12.0),
                            child: TextFormField(
                              controller: _model.averageConsumptionController,
                              focusNode: _model.averageConsumptionFocusNode,
                              textInputAction: TextInputAction.next,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Average consumption (kWh)',
                                labelStyle:
                                    FlutterFlowTheme.of(context).bodySmall,
                                hintStyle:
                                    FlutterFlowTheme.of(context).bodySmall,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .grayLighter,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                filled: true,
                                fillColor:
                                    FlutterFlowTheme.of(context).customColor1,
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 24.0, 0.0, 24.0),
                              ),
                              style: FlutterFlowTheme.of(context).bodyMedium,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              validator: _model
                                  .averageConsumptionControllerValidator
                                  .asValidator(context),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[\\d\\.]'))
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 0.0, 20.0, 12.0),
                            child: TextFormField(
                              controller: _model.chargePercentageController,
                              focusNode: _model.chargePercentageFocusNode,
                              textInputAction: TextInputAction.done,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Charge percentage',
                                labelStyle:
                                    FlutterFlowTheme.of(context).bodySmall,
                                hintStyle:
                                    FlutterFlowTheme.of(context).bodySmall,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .grayLighter,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                filled: true,
                                fillColor:
                                    FlutterFlowTheme.of(context).customColor1,
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 24.0, 0.0, 24.0),
                              ),
                              style: FlutterFlowTheme.of(context).bodyMedium,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              validator: _model
                                  .chargePercentageControllerValidator
                                  .asValidator(context),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[\\d\\.]'))
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.9,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: StreamBuilder<ParkingLotRecord>(
                              stream: ParkingLotRecord.getDocument(
                                  addCarAfterReservationChargingSpotsRecord
                                      .parkingLot!),
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
                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Align(
                                      alignment:
                                          AlignmentDirectional(0.00, 0.05),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 24.0, 0.0, 40.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            if (_model.formKey.currentState ==
                                                    null ||
                                                !_model.formKey.currentState!
                                                    .validate()) {
                                              return;
                                            }

                                            var carRecordReference =
                                                CarRecord.collection.doc();
                                            await carRecordReference
                                                .set(createCarRecordData(
                                              batteryChargePercentage:
                                                  random_data.randomDouble(
                                                      1.0, 90.0),
                                              batterySizeKwh: functions
                                                  .stringToDouble(_model
                                                      .batterySizeController
                                                      .text),
                                              vehicleRegistrationPlate: _model
                                                  .vehicleRegistraionPlateController
                                                  .text,
                                              averageConsumptionKWh: functions
                                                  .stringToDouble(functions
                                                      .stringToDouble(_model
                                                          .averageConsumptionController
                                                          .text)
                                                      .toString()),
                                              carUser: currentUserReference,
                                              desiredDepartureDateTime:
                                                  _model.datePicked,
                                              desiredChargeAtDeparture:
                                                  valueOrDefault<int>(
                                                functions.stringToInt(_model
                                                    .batteryLimitSliderModel
                                                    .sliderValue!
                                                    .toString()),
                                                80,
                                              ),
                                              carChargingSpot:
                                                  currentUserDocument
                                                      ?.chargingSpot,
                                              parkedFrom: getCurrentTimestamp,
                                            ));
                                            _model.outputCar =
                                                CarRecord.getDocumentFromData(
                                                    createCarRecordData(
                                                      batteryChargePercentage:
                                                          random_data
                                                              .randomDouble(
                                                                  1.0, 90.0),
                                                      batterySizeKwh: functions
                                                          .stringToDouble(_model
                                                              .batterySizeController
                                                              .text),
                                                      vehicleRegistrationPlate:
                                                          _model
                                                              .vehicleRegistraionPlateController
                                                              .text,
                                                      averageConsumptionKWh: functions
                                                          .stringToDouble(functions
                                                              .stringToDouble(_model
                                                                  .averageConsumptionController
                                                                  .text)
                                                              .toString()),
                                                      carUser:
                                                          currentUserReference,
                                                      desiredDepartureDateTime:
                                                          _model.datePicked,
                                                      desiredChargeAtDeparture:
                                                          valueOrDefault<int>(
                                                        functions.stringToInt(_model
                                                            .batteryLimitSliderModel
                                                            .sliderValue!
                                                            .toString()),
                                                        80,
                                                      ),
                                                      carChargingSpot:
                                                          currentUserDocument
                                                              ?.chargingSpot,
                                                      parkedFrom:
                                                          getCurrentTimestamp,
                                                    ),
                                                    carRecordReference);

                                            await currentUserReference!
                                                .update(createUsersRecordData(
                                              car: _model.outputCar?.reference,
                                              parkingLot: columnParkingLotRecord
                                                  .reference,
                                              parkingPrice: 0.0,
                                              chargingPrice: 0.0,
                                            ));

                                            await addCarAfterReservationChargingSpotsRecord
                                                .reference
                                                .update(
                                                    createChargingSpotsRecordData(
                                              isOccupied: true,
                                              isReserved: false,
                                              car: _model.outputCar?.reference,
                                              user: currentUserReference,
                                              isCharging: true,
                                              chargingMode: 1,
                                              isV2GActive: false,
                                            ));
                                            if (Navigator.of(context)
                                                .canPop()) {
                                              context.pop();
                                            }
                                            context.pushNamed('HomePage');

                                            setState(() {});
                                          },
                                          text: 'Complete Account',
                                          options: FFButtonOptions(
                                            width: 230.0,
                                            height: 50.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: Color(0xFF39D2C0),
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Lexend Deca',
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
                                                BorderRadius.circular(30.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
