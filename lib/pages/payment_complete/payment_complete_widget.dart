import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'payment_complete_model.dart';
export 'payment_complete_model.dart';

class PaymentCompleteWidget extends StatefulWidget {
  const PaymentCompleteWidget({
    Key? key,
    this.payedPrice,
    bool? isParkingPayment,
  })  : this.isParkingPayment = isParkingPayment ?? false,
        super(key: key);

  final double? payedPrice;
  final bool isParkingPayment;

  @override
  _PaymentCompleteWidgetState createState() => _PaymentCompleteWidgetState();
}

class _PaymentCompleteWidgetState extends State<PaymentCompleteWidget> {
  late PaymentCompleteModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PaymentCompleteModel());

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
      backgroundColor: FlutterFlowTheme.of(context).tertiary,
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: FlutterFlowTheme.of(context).primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(70.0),
                ),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(30.0, 30.0, 30.0, 30.0),
                  child: Icon(
                    Icons.check_rounded,
                    color: FlutterFlowTheme.of(context).alternate,
                    size: 60.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
              child: Text(
                'Payment Confirmed!',
                style: FlutterFlowTheme.of(context).displaySmall.override(
                      fontFamily: 'Outfit',
                      color: FlutterFlowTheme.of(context).alternate,
                    ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
              child: Text(
                formatNumber(
                  widget.payedPrice,
                  formatType: FormatType.decimal,
                  decimalType: DecimalType.automatic,
                  currency: '\$',
                ),
                style: GoogleFonts.getFont(
                  'Overpass',
                  color: FlutterFlowTheme.of(context).alternate,
                  fontWeight: FontWeight.w100,
                  fontSize: 72.0,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24.0, 8.0, 24.0, 0.0),
              child: Text(
                'Your payment has been confirmed, it may take 1-2 hours in order for your payment to go through and show up in your transation list.',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).bodySmall,
              ),
            ),
            if (widget.isParkingPayment)
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 32.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FFButtonWidget(
                        onPressed: () async {
                          if (widget.isParkingPayment) {
                            context.goNamed('unparkThankYouScreen');
                          }
                        },
                        text: 'Leave',
                        options: FFButtonOptions(
                          width: 150.0,
                          height: 50.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).dark400,
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                fontFamily: 'Outfit',
                                color:
                                    FlutterFlowTheme.of(context).customColor1,
                              ),
                          elevation: 2.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (!widget.isParkingPayment)
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 32.0),
                  child: AuthUserStreamWidget(
                    builder: (context) => StreamBuilder<ReservationsRecord>(
                      stream: ReservationsRecord.getDocument(
                          currentUserDocument!.reservation!),
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
                        final bottomButtonAreaReservationsRecord =
                            snapshot.data!;
                        return Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            StreamBuilder<ChargingSpotsRecord>(
                              stream: ChargingSpotsRecord.getDocument(
                                  currentUserDocument!.chargingSpot!),
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
                                final buttonChargingSpotsRecord =
                                    snapshot.data!;
                                return FFButtonWidget(
                                  onPressed: () async {
                                    final firestoreBatch =
                                        FirebaseFirestore.instance.batch();
                                    try {
                                      if (widget.isParkingPayment) {
                                        context.goNamed('unparkThankYouScreen');
                                      } else {
                                        context.goNamed(
                                          'onboarding',
                                          extra: <String, dynamic>{
                                            kTransitionInfoKey: TransitionInfo(
                                              hasTransition: true,
                                              transitionType:
                                                  PageTransitionType.fade,
                                              duration:
                                                  Duration(milliseconds: 240),
                                            ),
                                          },
                                        );

                                        firestoreBatch.update(
                                            bottomButtonAreaReservationsRecord
                                                .reference,
                                            createReservationsRecordData(
                                              reservedTo: getCurrentTimestamp,
                                              price: widget.payedPrice,
                                            ));

                                        firestoreBatch.update(
                                            buttonChargingSpotsRecord.reference,
                                            {
                                              ...createChargingSpotsRecordData(
                                                isReserved: false,
                                              ),
                                              ...mapToFirestore(
                                                {
                                                  'user': FieldValue.delete(),
                                                  'reservation':
                                                      FieldValue.delete(),
                                                },
                                              ),
                                            });

                                        firestoreBatch
                                            .update(currentUserReference!, {
                                          ...createUsersRecordData(
                                            reservationPrice: functions
                                                .calculatReservationPrice(
                                                    bottomButtonAreaReservationsRecord
                                                        .reservedFrom!,
                                                    getCurrentTimestamp,
                                                    widget.payedPrice!),
                                          ),
                                          ...mapToFirestore(
                                            {
                                              'reservation':
                                                  FieldValue.delete(),
                                              'chargingSpot':
                                                  FieldValue.delete(),
                                            },
                                          ),
                                        });
                                      }
                                    } finally {
                                      await firestoreBatch.commit();
                                    }
                                  },
                                  text: 'Leave',
                                  options: FFButtonOptions(
                                    width: 150.0,
                                    height: 50.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context).dark400,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Outfit',
                                          color: FlutterFlowTheme.of(context)
                                              .customColor1,
                                        ),
                                    elevation: 2.0,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(40.0),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
