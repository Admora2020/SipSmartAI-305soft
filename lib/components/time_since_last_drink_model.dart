import '/flutter_flow/flutter_flow_util.dart';
import 'time_since_last_drink_widget.dart' show TimeSinceLastDrinkWidget;
import 'package:flutter/material.dart';

class TimeSinceLastDrinkModel
    extends FlutterFlowModel<TimeSinceLastDrinkWidget> {
  ///  Local state fields for this component.

  String timerText = '00:00:00';

  int? loopCount = 86400;

  int? timeSinceLastDrinkInMs;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
