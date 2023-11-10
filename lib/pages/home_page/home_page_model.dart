import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/stripe/payment_manager.dart';
import '/components/charging_progress_bar_component_widget.dart';
import '/components/loading_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/instant_timer.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'home_page_widget.dart' show HomePageWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  Local state fields for this page.

  DocumentReference? carLocalVariable;

  ///  State fields for stateful widgets in this page.

  InstantTimer? parkingPriceTimer;
  // Model for chargingProgressBarComponent component.
  late ChargingProgressBarComponentModel chargingProgressBarComponentModel;
  // Stores action output result for [Stripe Payment] action in Column widget.
  String? paymentId;
  // Stores action output result for [Backend Call - Create Document] action in Column widget.
  PaymentsRecord? outputPayment;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    chargingProgressBarComponentModel =
        createModel(context, () => ChargingProgressBarComponentModel());
  }

  void dispose() {
    parkingPriceTimer?.cancel();
    chargingProgressBarComponentModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
