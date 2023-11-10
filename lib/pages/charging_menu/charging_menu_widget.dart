import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/battery_limit_slider_with_buttons_widget.dart';
import '/components/charging_modes_widget.dart';
import '/components/departure_time_widget.dart';
import '/components/eco_mode_widget.dart';
import '/components/regular_mode_widget.dart';
import '/components/saving_mode_widget.dart';
import '/components/surplus_mode_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'charging_menu_model.dart';
export 'charging_menu_model.dart';

class ChargingMenuWidget extends StatefulWidget {
  const ChargingMenuWidget({Key? key}) : super(key: key);

  @override
  _ChargingMenuWidgetState createState() => _ChargingMenuWidgetState();
}

class _ChargingMenuWidgetState extends State<ChargingMenuWidget> {
  late ChargingMenuModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChargingMenuModel());

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
      backgroundColor: FlutterFlowTheme.of(context).customColor1,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30.0,
          borderWidth: 1.0,
          buttonSize: 54.0,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: FlutterFlowTheme.of(context).secondaryText,
            size: 24.0,
          ),
          onPressed: () async {
            context.pop();
          },
        ),
        title: Text(
          'Charging Options',
          style: FlutterFlowTheme.of(context).displaySmall,
        ),
        actions: [],
        centerTitle: false,
        elevation: 0.0,
      ),
      body: Align(
        alignment: AlignmentDirectional(0.00, 0.00),
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
              final containerCarRecord = snapshot.data!;
              return Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: MediaQuery.sizeOf(context).height * 1.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 12.0),
                  child: StreamBuilder<ChargingSpotsRecord>(
                    stream: ChargingSpotsRecord.getDocument(
                        containerCarRecord.carChargingSpot!),
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
                      final gridViewChargingSpotsRecord = snapshot.data!;
                      return GridView(
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: MediaQuery.sizeOf(context).width <
                                  MediaQuery.sizeOf(context).height
                              ? 2
                              : 5,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: 1.0,
                        ),
                        scrollDirection: Axis.vertical,
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
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  useSafeArea: true,
                                  context: context,
                                  builder: (context) {
                                    return Padding(
                                      padding: MediaQuery.viewInsetsOf(context),
                                      child: Container(
                                        height: 150.0,
                                        child:
                                            BatteryLimitSliderWithButtonsWidget(
                                          currentPercentage: containerCarRecord
                                              .desiredChargeAtDeparture,
                                        ),
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 16.0, 0.0, 0.0),
                                    child: Icon(
                                      Icons.battery_5_bar_sharp,
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      size: 44.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 8.0, 0.0, 0.0),
                                    child: AutoSizeText(
                                      'Desired charge',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .override(
                                            fontFamily: 'Outfit',
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            fontSize: 20.0,
                                          ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8.0, 4.0, 8.0, 0.0),
                                      child: Text(
                                        '${containerCarRecord.desiredChargeAtDeparture.toString()}%',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.getFont(
                                          'Lexend Deca',
                                          color: Color(0xB3FFFFFF),
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8.0, 4.0, 8.0, 0.0),
                                      child: Text(
                                        'Car won\'t be charged above this limit',
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
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  enableDrag: false,
                                  context: context,
                                  builder: (context) {
                                    return Padding(
                                      padding: MediaQuery.viewInsetsOf(context),
                                      child: DepartureTimeWidget(),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 16.0, 0.0, 0.0),
                                    child: Icon(
                                      Icons.access_time,
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      size: 44.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 8.0, 0.0, 0.0),
                                    child: AutoSizeText(
                                      'Set departure time',
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
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8.0, 4.0, 8.0, 0.0),
                                      child: Text(
                                        valueOrDefault<String>(
                                          dateTimeFormat(
                                            'd/M H:mm',
                                            containerCarRecord
                                                .desiredDepartureDateTime,
                                            locale: FFLocalizations.of(context)
                                                .languageCode,
                                          ),
                                          'Not set',
                                        ),
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.getFont(
                                          'Lexend Deca',
                                          color: Color(0xB3FFFFFF),
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8.0, 4.0, 8.0, 0.0),
                                      child: Text(
                                        'So your car will be charged at the time of departure',
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
                              color: valueOrDefault<Color>(
                                gridViewChargingSpotsRecord.isV2GActive
                                    ? FlutterFlowTheme.of(context).primary
                                    : FlutterFlowTheme.of(context).error,
                                FlutterFlowTheme.of(context).secondary,
                              ),
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
                                if (gridViewChargingSpotsRecord.isV2GActive) {
                                  await gridViewChargingSpotsRecord.reference
                                      .update(createChargingSpotsRecordData(
                                    isV2GActive: false,
                                  ));
                                } else {
                                  await gridViewChargingSpotsRecord.reference
                                      .update(createChargingSpotsRecordData(
                                    isV2GActive: true,
                                  ));
                                }
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 16.0, 0.0, 0.0),
                                    child: Icon(
                                      Icons.change_circle,
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      size: 44.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 8.0, 0.0, 0.0),
                                    child: AutoSizeText(
                                      gridViewChargingSpotsRecord.isV2GActive
                                          ? 'Enabled V2G'
                                          : 'Disabled V2G',
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
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8.0, 4.0, 8.0, 0.0),
                                      child: Text(
                                        'Enable using your vehicle to charge other cars',
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
                              color: gridViewChargingSpotsRecord.isCharging
                                  ? FlutterFlowTheme.of(context).primary
                                  : FlutterFlowTheme.of(context).error,
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
                                if (gridViewChargingSpotsRecord.isCharging) {
                                  await gridViewChargingSpotsRecord.reference
                                      .update(createChargingSpotsRecordData(
                                    isCharging: false,
                                  ));
                                } else {
                                  await gridViewChargingSpotsRecord.reference
                                      .update(createChargingSpotsRecordData(
                                    isCharging: true,
                                  ));
                                }
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                      'Charging',
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
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8.0, 4.0, 8.0, 0.0),
                                      child: Text(
                                        'Force enable/disable charging.\nYour vehicle will not be charged if enabled!',
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
                          if (valueOrDefault<bool>(
                            gridViewChargingSpotsRecord.chargingMode == 1,
                            true,
                          ))
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  enableDrag: false,
                                  context: context,
                                  builder: (context) {
                                    return Padding(
                                      padding: MediaQuery.viewInsetsOf(context),
                                      child: Container(
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.5,
                                        child: ChargingModesWidget(),
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));
                              },
                              child: wrapWithModel(
                                model: _model.regularModeModel,
                                updateCallback: () => setState(() {}),
                                child: RegularModeWidget(),
                              ),
                            ),
                          if (gridViewChargingSpotsRecord.chargingMode == 2)
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  enableDrag: false,
                                  context: context,
                                  builder: (context) {
                                    return Padding(
                                      padding: MediaQuery.viewInsetsOf(context),
                                      child: Container(
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.5,
                                        child: ChargingModesWidget(),
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));
                              },
                              child: wrapWithModel(
                                model: _model.ecoModeModel,
                                updateCallback: () => setState(() {}),
                                child: EcoModeWidget(),
                              ),
                            ),
                          if (gridViewChargingSpotsRecord.chargingMode == 3)
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  enableDrag: false,
                                  context: context,
                                  builder: (context) {
                                    return Padding(
                                      padding: MediaQuery.viewInsetsOf(context),
                                      child: Container(
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.5,
                                        child: ChargingModesWidget(),
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));
                              },
                              child: wrapWithModel(
                                model: _model.surplusModeModel,
                                updateCallback: () => setState(() {}),
                                child: SurplusModeWidget(),
                              ),
                            ),
                          if (gridViewChargingSpotsRecord.chargingMode == 4)
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  enableDrag: false,
                                  context: context,
                                  builder: (context) {
                                    return Padding(
                                      padding: MediaQuery.viewInsetsOf(context),
                                      child: Container(
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.5,
                                        child: ChargingModesWidget(),
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));
                              },
                              child: wrapWithModel(
                                model: _model.savingModeModel,
                                updateCallback: () => setState(() {}),
                                child: SavingModeWidget(),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
