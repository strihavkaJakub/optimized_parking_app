import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/eco_mode_widget.dart';
import '/components/regular_mode_widget.dart';
import '/components/saving_mode_widget.dart';
import '/components/surplus_mode_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'charging_modes_model.dart';
export 'charging_modes_model.dart';

class ChargingModesWidget extends StatefulWidget {
  const ChargingModesWidget({Key? key}) : super(key: key);

  @override
  _ChargingModesWidgetState createState() => _ChargingModesWidgetState();
}

class _ChargingModesWidgetState extends State<ChargingModesWidget> {
  late ChargingModesModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChargingModesModel());

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
      width: MediaQuery.sizeOf(context).width * 1.0,
      height: MediaQuery.sizeOf(context).height * 1.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Choose a charging mode',
            style: FlutterFlowTheme.of(context).titleLarge,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(8.0, 12.0, 8.0, 0.0),
              child: GridView(
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.sizeOf(context).width >
                          MediaQuery.sizeOf(context).height
                      ? 5
                      : 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 1.0,
                ),
                scrollDirection: Axis.vertical,
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      await currentUserDocument!.chargingSpot!
                          .update(createChargingSpotsRecordData(
                        chargingMode: 1,
                      ));
                      Navigator.pop(context);
                    },
                    child: wrapWithModel(
                      model: _model.regularModeModel,
                      updateCallback: () => setState(() {}),
                      child: RegularModeWidget(),
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      await currentUserDocument!.chargingSpot!
                          .update(createChargingSpotsRecordData(
                        chargingMode: 2,
                      ));
                      Navigator.pop(context);
                    },
                    child: wrapWithModel(
                      model: _model.ecoModeModel,
                      updateCallback: () => setState(() {}),
                      child: EcoModeWidget(),
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      await currentUserDocument!.chargingSpot!
                          .update(createChargingSpotsRecordData(
                        chargingMode: 3,
                      ));
                      Navigator.pop(context);
                    },
                    child: wrapWithModel(
                      model: _model.surplusModeModel,
                      updateCallback: () => setState(() {}),
                      child: SurplusModeWidget(),
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      await currentUserDocument!.chargingSpot!
                          .update(createChargingSpotsRecordData(
                        chargingMode: 4,
                      ));
                      Navigator.pop(context);
                    },
                    child: wrapWithModel(
                      model: _model.savingModeModel,
                      updateCallback: () => setState(() {}),
                      child: SavingModeWidget(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
