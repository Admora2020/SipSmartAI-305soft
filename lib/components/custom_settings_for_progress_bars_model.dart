import '/flutter_flow/flutter_flow_util.dart';
import 'custom_settings_for_progress_bars_widget.dart'
    show CustomSettingsForProgressBarsWidget;
import 'package:flutter/material.dart';

class CustomSettingsForProgressBarsModel
    extends FlutterFlowModel<CustomSettingsForProgressBarsWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for BACLimit widget.
  FocusNode? bACLimitFocusNode;
  TextEditingController? bACLimitTextController;
  String? Function(BuildContext, String?)? bACLimitTextControllerValidator;
  // State field(s) for VolumeLimit widget.
  FocusNode? volumeLimitFocusNode;
  TextEditingController? volumeLimitTextController;
  String? Function(BuildContext, String?)? volumeLimitTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    bACLimitFocusNode?.dispose();
    bACLimitTextController?.dispose();

    volumeLimitFocusNode?.dispose();
    volumeLimitTextController?.dispose();
  }
}
