import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'charging_progress_bar_component_model.dart';
export 'charging_progress_bar_component_model.dart';

class ChargingProgressBarComponentWidget extends StatefulWidget {
  const ChargingProgressBarComponentWidget({Key? key}) : super(key: key);

  @override
  _ChargingProgressBarComponentWidgetState createState() =>
      _ChargingProgressBarComponentWidgetState();
}

class _ChargingProgressBarComponentWidgetState
    extends State<ChargingProgressBarComponentWidget> {
  late ChargingProgressBarComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChargingProgressBarComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
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
            final progressBarCarRecord = snapshot.data!;
            return LinearPercentIndicator(
              percent: progressBarCarRecord.batteryChargePercentage / 100,
              lineHeight: 40.0,
              animation: true,
              animateFromLastPercent: true,
              progressColor: FlutterFlowTheme.of(context).primary,
              backgroundColor: FlutterFlowTheme.of(context).grayLighter,
              center: Text(
                valueOrDefault<String>(
                  formatNumber(
                    progressBarCarRecord.batteryChargePercentage,
                    formatType: FormatType.custom,
                    format: '##.##\'%\'',
                    locale: '',
                  ),
                  '80%',
                ),
                style: FlutterFlowTheme.of(context).bodyLarge.override(
                      fontFamily: 'Outfit',
                      fontSize: 32.0,
                    ),
              ),
              barRadius: Radius.circular(40.0),
              padding: EdgeInsets.zero,
            );
          },
        ),
      ),
    );
  }
}
