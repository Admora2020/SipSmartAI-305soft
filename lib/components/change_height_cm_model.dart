import '/flutter_flow/flutter_flow_util.dart';
import 'change_height_cm_widget.dart' show ChangeHeightCmWidget;
import 'package:flutter/material.dart';

class ChangeHeightCmModel extends FlutterFlowModel<ChangeHeightCmWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
