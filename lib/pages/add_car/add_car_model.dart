import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/battery_limit_slider_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import 'add_car_widget.dart' show AddCarWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddCarModel extends FlutterFlowModel<AddCarWidget> {
  ///  Local state fields for this page.

  DocumentReference? chargingSpot;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Model for batteryLimitSlider component.
  late BatteryLimitSliderModel batteryLimitSliderModel;
  DateTime? datePicked;
  // State field(s) for vehicleRegistraionPlate widget.
  FocusNode? vehicleRegistraionPlateFocusNode;
  TextEditingController? vehicleRegistraionPlateController;
  String? Function(BuildContext, String?)?
      vehicleRegistraionPlateControllerValidator;
  String? _vehicleRegistraionPlateControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (val.length < 5) {
      return 'Requires at least 5 characters.';
    }

    return null;
  }

  // State field(s) for batterySize widget.
  FocusNode? batterySizeFocusNode;
  TextEditingController? batterySizeController;
  String? Function(BuildContext, String?)? batterySizeControllerValidator;
  String? _batterySizeControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (val.length < 1) {
      return 'Requires at least 1 characters.';
    }

    if (!RegExp('^\\d+(\\.\\d+)?\$').hasMatch(val)) {
      return 'Only numbers or numbers with decimal point';
    }
    return null;
  }

  // State field(s) for averageConsumption widget.
  FocusNode? averageConsumptionFocusNode;
  TextEditingController? averageConsumptionController;
  String? Function(BuildContext, String?)?
      averageConsumptionControllerValidator;
  String? _averageConsumptionControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (val.length < 1) {
      return 'Requires at least 1 characters.';
    }

    if (!RegExp('^\\d+(\\.\\d+)?\$').hasMatch(val)) {
      return 'Only numbers or numbers with decimal point';
    }
    return null;
  }

  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  CarRecord? outputCar;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    batteryLimitSliderModel =
        createModel(context, () => BatteryLimitSliderModel());
    vehicleRegistraionPlateControllerValidator =
        _vehicleRegistraionPlateControllerValidator;
    batterySizeControllerValidator = _batterySizeControllerValidator;
    averageConsumptionControllerValidator =
        _averageConsumptionControllerValidator;
  }

  void dispose() {
    batteryLimitSliderModel.dispose();
    vehicleRegistraionPlateFocusNode?.dispose();
    vehicleRegistraionPlateController?.dispose();

    batterySizeFocusNode?.dispose();
    batterySizeController?.dispose();

    averageConsumptionFocusNode?.dispose();
    averageConsumptionController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
