import '/backend/api_requests/api_calls.dart';
import '/components/time_since_last_drink_widget.dart';
import '/components/time_until_sober_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'golden_path_widget.dart' show GoldenPathWidget;
import 'package:flutter/material.dart';

class GoldenPathModel extends FlutterFlowModel<GoldenPathWidget> {
  ///  Local state fields for this page.

  double? totalMl;

  bool timerOn = true;

  bool timersON = true;

  bool progressBarBAC = true;

  bool customDrinkVisibility = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - getTotalMl] action in GoldenPath widget.
  double? totalMlResult;
  // Stores action output result for [Custom Action - getTotalAlcoholGrams] action in GoldenPath widget.
  double? totGrams;
  // Stores action output result for [Custom Action - getTotalAlcoholGrams] action in GoldenPath widget.
  double? totGrams2;
  // Stores action output result for [Custom Action - getTotalMl] action in GoldenPath widget.
  double? totalMil;
  // Model for timeUntilSober component.
  late TimeUntilSoberModel timeUntilSoberModel;
  // Model for TimeSinceLastDrink component.
  late TimeSinceLastDrinkModel timeSinceLastDrinkModel;
  var barcode = '';
  // Stores action output result for [Backend Call - API (BarcodeInfoFetch)] action in Container widget.
  ApiCallResponse? apiResultfi4;

  @override
  void initState(BuildContext context) {
    timeUntilSoberModel = createModel(context, () => TimeUntilSoberModel());
    timeSinceLastDrinkModel =
        createModel(context, () => TimeSinceLastDrinkModel());
  }

  @override
  void dispose() {
    timeUntilSoberModel.dispose();
    timeSinceLastDrinkModel.dispose();
  }
}
