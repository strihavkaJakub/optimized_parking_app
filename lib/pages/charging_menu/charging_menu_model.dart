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
import 'charging_menu_widget.dart' show ChargingMenuWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChargingMenuModel extends FlutterFlowModel<ChargingMenuWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for regularMode component.
  late RegularModeModel regularModeModel;
  // Model for ecoMode component.
  late EcoModeModel ecoModeModel;
  // Model for surplusMode component.
  late SurplusModeModel surplusModeModel;
  // Model for savingMode component.
  late SavingModeModel savingModeModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    regularModeModel = createModel(context, () => RegularModeModel());
    ecoModeModel = createModel(context, () => EcoModeModel());
    surplusModeModel = createModel(context, () => SurplusModeModel());
    savingModeModel = createModel(context, () => SavingModeModel());
  }

  void dispose() {
    regularModeModel.dispose();
    ecoModeModel.dispose();
    surplusModeModel.dispose();
    savingModeModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
