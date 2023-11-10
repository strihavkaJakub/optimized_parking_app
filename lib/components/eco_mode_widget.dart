import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'eco_mode_model.dart';
export 'eco_mode_model.dart';

class EcoModeWidget extends StatefulWidget {
  const EcoModeWidget({Key? key}) : super(key: key);

  @override
  _EcoModeWidgetState createState() => _EcoModeWidgetState();
}

class _EcoModeWidgetState extends State<EcoModeWidget> {
  late EcoModeModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EcoModeModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.677,
        height: 216.0,
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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
              child: Icon(
                Icons.eco,
                color: FlutterFlowTheme.of(context).alternate,
                size: 44.0,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
              child: AutoSizeText(
                'Eco mode',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).titleMedium.override(
                      fontFamily: 'Outfit',
                      color: FlutterFlowTheme.of(context).alternate,
                      fontSize: 20.0,
                    ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 8.0, 0.0),
                child: Text(
                  'Charge only from green energy',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.getFont(
                    'Lexend Deca',
                    color: Color(0xB3FFFFFF),
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 8.0, 0.0),
                child: Text(
                  'Warning: Desired charge may not be reached',
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
    );
  }
}
