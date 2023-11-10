import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'reserve_car_model.dart';
export 'reserve_car_model.dart';

class ReserveCarWidget extends StatefulWidget {
  const ReserveCarWidget({Key? key}) : super(key: key);

  @override
  _ReserveCarWidgetState createState() => _ReserveCarWidgetState();
}

class _ReserveCarWidgetState extends State<ReserveCarWidget> {
  late ReserveCarModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReserveCarModel());

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

    return StreamBuilder<List<ChargingSpotsRecord>>(
      stream: queryChargingSpotsRecord(
        queryBuilder: (chargingSpotsRecord) => chargingSpotsRecord
            .where(
              'isOccupied',
              isEqualTo: false,
            )
            .where(
              'isReserved',
              isEqualTo: false,
            ),
        limit: 10,
      ),
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
        List<ChargingSpotsRecord> reserveCarChargingSpotsRecordList =
            snapshot.data!;
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
              'Reserve a parking spot',
              style: FlutterFlowTheme.of(context).titleSmall.override(
                    fontFamily: 'Outfit',
                    fontSize: 20.0,
                  ),
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
                      Align(
                        alignment: AlignmentDirectional(0.00, 0.00),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 12.0),
                          child: Icon(
                            Icons.edit_calendar,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 200.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Form(
                    key: _model.formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0.00, 0.00),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 0.0, 20.0, 16.0),
                            child: Text(
                              'Reserve a parking spot. Reservation fee is \$0.5. You will be charged \$0.01 for every minute above 50 minutes.',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Outfit',
                                    fontSize: 18.0,
                                  ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.00, 0.00),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 0.0, 20.0, 16.0),
                            child: Text(
                              'Number of available charging spots: ${valueOrDefault<String>(
                                reserveCarChargingSpotsRecordList.length
                                    .toString(),
                                '0',
                              )}',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Outfit',
                                    fontSize: 18.0,
                                  ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if (reserveCarChargingSpotsRecordList.length == 0)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 20.0, 0.0, 30.0),
                                  child: Text(
                                    'No availabile charging spots',
                                    style: FlutterFlowTheme.of(context)
                                        .headlineMedium,
                                  ),
                                ),
                              if (reserveCarChargingSpotsRecordList.length > 0)
                                Align(
                                  alignment: AlignmentDirectional(0.00, 0.05),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 24.0, 0.0, 40.0),
                                    child: StreamBuilder<
                                        List<ChargingSpotsRecord>>(
                                      stream: queryChargingSpotsRecord(
                                        queryBuilder: (chargingSpotsRecord) =>
                                            chargingSpotsRecord
                                                .where(
                                                  'isOccupied',
                                                  isEqualTo: false,
                                                )
                                                .where(
                                                  'isReserved',
                                                  isEqualTo: false,
                                                ),
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
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                size: 50.0,
                                              ),
                                            ),
                                          );
                                        }
                                        List<ChargingSpotsRecord>
                                            buttonChargingSpotsRecordList =
                                            snapshot.data!;
                                        // Return an empty Container when the item does not exist.
                                        if (snapshot.data!.isEmpty) {
                                          return Container();
                                        }
                                        final buttonChargingSpotsRecord =
                                            buttonChargingSpotsRecordList
                                                    .isNotEmpty
                                                ? buttonChargingSpotsRecordList
                                                    .first
                                                : null;
                                        return FFButtonWidget(
                                          onPressed: () async {
                                            if (_model.formKey.currentState ==
                                                    null ||
                                                !_model.formKey.currentState!
                                                    .validate()) {
                                              return;
                                            }

                                            var reservationsRecordReference =
                                                ReservationsRecord.createDoc(
                                                    buttonChargingSpotsRecord!
                                                        .reference);
                                            await reservationsRecordReference
                                                .set(
                                                    createReservationsRecordData(
                                              reservedFrom: getCurrentTimestamp,
                                              user: currentUserReference,
                                              parkingSpot:
                                                  buttonChargingSpotsRecord
                                                      ?.reference,
                                            ));
                                            _model.createdReservation =
                                                ReservationsRecord.getDocumentFromData(
                                                    createReservationsRecordData(
                                                      reservedFrom:
                                                          getCurrentTimestamp,
                                                      user:
                                                          currentUserReference,
                                                      parkingSpot:
                                                          buttonChargingSpotsRecord
                                                              ?.reference,
                                                    ),
                                                    reservationsRecordReference);

                                            await currentUserReference!
                                                .update(createUsersRecordData(
                                              chargingSpot:
                                                  buttonChargingSpotsRecord
                                                      ?.reference,
                                              reservation: _model
                                                  .createdReservation
                                                  ?.reference,
                                            ));

                                            await buttonChargingSpotsRecord!
                                                .reference
                                                .update(
                                                    createChargingSpotsRecordData(
                                              reservation: _model
                                                  .createdReservation
                                                  ?.reference,
                                              isReserved: true,
                                              user: currentUserReference,
                                            ));

                                            context
                                                .goNamed('reservationPending');

                                            setState(() {});
                                          },
                                          text: 'Make reservation',
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
                                        );
                                      },
                                    ),
                                  ),
                                ),
                            ],
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
    );
  }
}
