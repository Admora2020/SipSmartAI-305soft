import '/flutter_flow/flutter_flow_util.dart';
import 'progress_page_widget.dart' show ProgressPageWidget;
import 'package:flutter/material.dart';

class ProgressPageModel extends FlutterFlowModel<ProgressPageWidget> {
  ///  Local state fields for this page.

  double totalMLWeek = 0.0;

  double avgMLPerDay = 0.0;

  int safeDaysCount = 0;

  int safeStreak = 0;

  DateTime? currentWeekStart;

  DateTime? currentMonthStart;

  DateTime? currentYearStart;

  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
  }
}
