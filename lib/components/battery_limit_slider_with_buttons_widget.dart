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
import 'battery_limit_slider_with_buttons_model.dart';
export 'battery_limit_slider_with_buttons_model.dart';

class BatteryLimitSliderWithButtonsWidget extends StatefulWidget {
  const BatteryLimitSliderWithButtonsWidget({
    Key? key,
    int? currentPercentage,
  })  : this.currentPercentage = currentPercentage ?? 100,
        super(key: key);

  final int currentPercentage;

  @override
  _BatteryLimitSliderWithButtonsWidgetState createState() =>
      _BatteryLimitSliderWithButtonsWidgetState();
}

class _BatteryLimitSliderWithButtonsWidgetState
    extends State<BatteryLimitSliderWithButtonsWidget> {
  late BatteryLimitSliderWithButtonsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BatteryLimitSliderWithButtonsModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthUserStreamWidget(
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
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                    child: Text(
                      'Desired battery percentage: ',
                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                            fontFamily: 'Outfit',
                            fontSize: 20.0,
                          ),
                    ),
                  ),
                  if (_model.sliderValue != null)
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                      child: Text(
                        '${_model.sliderValue?.toString()}%',
                        style: FlutterFlowTheme.of(context).bodyLarge.override(
                              fontFamily: 'Outfit',
                              fontSize: 20.0,
                            ),
                      ),
                    ),
                ],
              ),
              Align(
                alignment: AlignmentDirectional(0.00, 0.00),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Slider.adaptive(
                      activeColor: FlutterFlowTheme.of(context).primary,
                      inactiveColor: FlutterFlowTheme.of(context).alternate,
                      min: 1.0,
                      max: 100.0,
                      value: _model.sliderValue ??=
                          columnCarRecord.desiredChargeAtDeparture.toDouble(),
                      label: _model.sliderValue.toString(),
                      divisions: 99,
                      onChanged: (newValue) {
                        newValue = double.parse(newValue.toStringAsFixed(0));
                        setState(() => _model.sliderValue = newValue);
                      },
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FFButtonWidget(
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    text: 'Cancel',
                    options: FFButtonOptions(
                      height: 40.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).error,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
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
                  FFButtonWidget(
                    onPressed: () async {
                      await columnCarRecord.reference
                          .update(createCarRecordData(
                        desiredChargeAtDeparture: functions
                            .stringToInt(_model.sliderValue!.toString()),
                      ));
                      Navigator.pop(context, _model.sliderValue?.toString());
                    },
                    text: 'Save',
                    options: FFButtonOptions(
                      height: 40.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
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
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
