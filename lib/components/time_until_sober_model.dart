import '/flutter_flow/flutter_flow_util.dart';
import 'time_until_sober_widget.dart' show TimeUntilSoberWidget;
import 'package:flutter/material.dart';

class TimeUntilSoberModel extends FlutterFlowModel<TimeUntilSoberWidget> {
  ///  Local state fields for this component.

  double? totalAlcGrams;

  int? elapsedTime;

  double? currentBAC;

  int? loopCount = 86400;

  String timerSoberText = '00:00:00';

  int? weight;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - getTotalAlcoholGrams] action in timeUntilSober widget.
  double? totalGrams1;
  // Stores action output result for [Custom Action - getTotalAlcoholGrams] action in timeUntilSober widget.
  double? totalGrams2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
