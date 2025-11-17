import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'golden_path_widget.dart' show GoldenPathWidget;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';

class GoldenPathModel extends FlutterFlowModel<GoldenPathWidget> {
  ///  Local state fields for this page.

  double totalMl = 0.0;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - getTotalMl] action in GoldenPath widget.
  double? totalMlResult;
  // Stores action output result for [Custom Action - undoLastDrink] action in undoButton widget.
  int? undoLog;
  // Stores action output result for [Custom Action - getTotalMl] action in undoButton widget.
  double? totalMlUndo;
  // State field(s) for Timer widget.
  final timerInitialTimeMs = 60000;
  int timerMilliseconds = 60000;
  String timerValue = StopWatchTimer.getDisplayTime(60000, milliSecond: false);
  FlutterFlowTimerController timerController =
      FlutterFlowTimerController(StopWatchTimer(mode: StopWatchMode.countDown));

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    timerController.dispose();
  }
}
