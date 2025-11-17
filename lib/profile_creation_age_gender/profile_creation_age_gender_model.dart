import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'profile_creation_age_gender_widget.dart'
    show ProfileCreationAgeGenderWidget;
import 'package:flutter/material.dart';

class ProfileCreationAgeGenderModel
    extends FlutterFlowModel<ProfileCreationAgeGenderWidget> {
  ///  State fields for stateful widgets in this page.

  DateTime? datePicked;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Additional helper methods.
  String? get radioButtonValue => radioButtonValueController?.value;
}
