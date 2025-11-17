import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'profile_editing_widget.dart' show ProfileEditingWidget;
import 'package:flutter/material.dart';

class ProfileEditingModel extends FlutterFlowModel<ProfileEditingWidget> {
  ///  State fields for stateful widgets in this page.

  bool isDataUploading_uploadDataJ7p = false;
  FFUploadedFile uploadedLocalFile_uploadDataJ7p =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_uploadDataJ7p = '';

  bool isDataUploading_profilePhoto = false;
  FFUploadedFile uploadedLocalFile_profilePhoto =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_profilePhoto = '';

  // State field(s) for Name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // State field(s) for birthdayField widget.
  FocusNode? birthdayFieldFocusNode;
  TextEditingController? birthdayFieldTextController;
  String? Function(BuildContext, String?)? birthdayFieldTextControllerValidator;
  // State field(s) for weightField widget.
  FocusNode? weightFieldFocusNode;
  TextEditingController? weightFieldTextController;
  String? Function(BuildContext, String?)? weightFieldTextControllerValidator;
  // State field(s) for WeightDropDown widget.
  String? weightDropDownValue;
  FormFieldController<String>? weightDropDownValueController;
  // State field(s) for heightField widget.
  FocusNode? heightFieldFocusNode;
  TextEditingController? heightFieldTextController;
  String? Function(BuildContext, String?)? heightFieldTextControllerValidator;
  // State field(s) for HeightDropDown widget.
  String? heightDropDownValue;
  FormFieldController<String>? heightDropDownValueController;
  // State field(s) for toleranceField widget.
  double? toleranceFieldValue;
  FormFieldController<double>? toleranceFieldValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nameFocusNode?.dispose();
    nameTextController?.dispose();

    birthdayFieldFocusNode?.dispose();
    birthdayFieldTextController?.dispose();

    weightFieldFocusNode?.dispose();
    weightFieldTextController?.dispose();

    heightFieldFocusNode?.dispose();
    heightFieldTextController?.dispose();
  }
}
