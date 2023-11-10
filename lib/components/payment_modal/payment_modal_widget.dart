import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/stripe/payment_manager.dart';
import '/flutter_flow/flutter_flow_credit_card_form.dart';
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
import 'payment_modal_model.dart';
export 'payment_modal_model.dart';

class PaymentModalWidget extends StatefulWidget {
  const PaymentModalWidget({
    Key? key,
    required this.paymentSum,
    bool? isParkingPayment,
  })  : this.isParkingPayment = isParkingPayment ?? false,
        super(key: key);

  final double? paymentSum;
  final bool isParkingPayment;

  @override
  _PaymentModalWidgetState createState() => _PaymentModalWidgetState();
}

class _PaymentModalWidgetState extends State<PaymentModalWidget> {
  late PaymentModalModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PaymentModalModel());

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
        color: FlutterFlowTheme.of(context).customColor1,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      valueOrDefault<String>(
                        'Pay for ${valueOrDefault<String>(
                          widget.isParkingPayment
                              ? 'Parking and Charging'
                              : 'Reservation',
                          'Parking',
                        )}',
                        'Parking',
                      ),
                      style: FlutterFlowTheme.of(context).headlineMedium,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                child: Text(
                  'Your Payment',
                  style: FlutterFlowTheme.of(context).bodySmall,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                child: Text(
                  valueOrDefault<String>(
                    formatNumber(
                      widget.paymentSum,
                      formatType: FormatType.decimal,
                      decimalType: DecimalType.automatic,
                      currency: '\$',
                    ),
                    '0',
                  ),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.getFont(
                    'Lexend Deca',
                    color: FlutterFlowTheme.of(context).dark400,
                    fontWeight: FontWeight.w100,
                    fontSize: 56.0,
                  ),
                ),
              ),
              Divider(
                height: 4.0,
                thickness: 1.0,
                indent: 20.0,
                endIndent: 20.0,
                color: FlutterFlowTheme.of(context).grayLighter,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12.0, 8.0, 12.0, 0.0),
                child: FlutterFlowCreditCardForm(
                  formKey: _model.creditCardFormKey,
                  creditCardModel: _model.creditCardInfo,
                  obscureNumber: false,
                  obscureCvv: false,
                  spacing: 10.0,
                  textStyle: FlutterFlowTheme.of(context).bodyMedium,
                  inputDecoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).grayLighter,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).grayLighter,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 40.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    final paymentResponse = await processStripePayment(
                      context,
                      amount: widget.paymentSum! < 0.5
                          ? 50
                          : functions
                              .convertPriceForPayment(widget.paymentSum!),
                      currency: 'USD',
                      customerEmail: currentUserEmail,
                      customerName: currentUserDisplayName,
                      description: 'Parking payment',
                      allowGooglePay: false,
                      allowApplePay: false,
                    );
                    if (paymentResponse.paymentId == null &&
                        paymentResponse.errorMessage != null) {
                      showSnackbar(
                        context,
                        'Error: ${paymentResponse.errorMessage}',
                      );
                    }
                    _model.paymentId = paymentResponse.paymentId ?? '';

                    if (_model.paymentId != null && _model.paymentId != '') {
                      await PaymentsRecord.collection
                          .doc()
                          .set(createPaymentsRecordData(
                            paymentUser: currentUserReference,
                            paymentDate: getCurrentTimestamp,
                            paymentStatus: 'Complete',
                            paymentAmount: widget.paymentSum,
                            paymentId: _model.paymentId,
                          ));

                      context.goNamed(
                        'paymentComplete',
                        queryParameters: {
                          'isParkingPayment': serializeParam(
                            widget.isParkingPayment,
                            ParamType.bool,
                          ),
                          'payedPrice': serializeParam(
                            widget.paymentSum,
                            ParamType.double,
                          ),
                        }.withoutNulls,
                        extra: <String, dynamic>{
                          kTransitionInfoKey: TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.bottomToTop,
                            duration: Duration(milliseconds: 250),
                          ),
                        },
                      );
                    }

                    setState(() {});
                  },
                  text: 'Pay Now',
                  options: FFButtonOptions(
                    width: 300.0,
                    height: 50.0,
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).secondary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Outfit',
                          color: Colors.white,
                        ),
                    elevation: 2.0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
