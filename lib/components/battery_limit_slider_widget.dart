import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'battery_limit_slider_model.dart';
export 'battery_limit_slider_model.dart';

class BatteryLimitSliderWidget extends StatefulWidget {
  const BatteryLimitSliderWidget({Key? key}) : super(key: key);

  @override
  _BatteryLimitSliderWidgetState createState() =>
      _BatteryLimitSliderWidgetState();
}

class _BatteryLimitSliderWidgetState extends State<BatteryLimitSliderWidget> {
  late BatteryLimitSliderModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BatteryLimitSliderModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Desired battery percentage: ${valueOrDefault<String>(
            _model.sliderValue.toString(),
            '80',
          )}%',
          style: FlutterFlowTheme.of(context).bodyLarge.override(
                fontFamily: 'Outfit',
                fontSize: 20.0,
              ),
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
                value: _model.sliderValue ??= 80.0,
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
      ],
    );
  }
}
