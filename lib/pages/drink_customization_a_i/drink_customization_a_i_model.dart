import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'drink_customization_a_i_widget.dart' show DrinkCustomizationAIWidget;
import 'package:flutter/material.dart';

class DrinkCustomizationAIModel
    extends FlutterFlowModel<DrinkCustomizationAIWidget> {
  ///  Local state fields for this component.

  DrinkPresetsRecord? activeDrinkPreset;

  List<DrinkPresetsRecord> availablePresets = [];
  void addToAvailablePresets(DrinkPresetsRecord item) =>
      availablePresets.add(item);
  void removeFromAvailablePresets(DrinkPresetsRecord item) =>
      availablePresets.remove(item);
  void removeAtIndexFromAvailablePresets(int index) =>
      availablePresets.removeAt(index);
  void insertAtIndexInAvailablePresets(int index, DrinkPresetsRecord item) =>
      availablePresets.insert(index, item);
  void updateAvailablePresetsAtIndex(
          int index, Function(DrinkPresetsRecord) updateFn) =>
      availablePresets[index] = updateFn(availablePresets[index]);

  String activeDrinkSizeType = 'oz';

  bool usedDefaultValues = false;

  ///  State fields for stateful widgets in this component.

  bool isDataUploading_aiDrinkUpload = false;
  FFUploadedFile uploadedLocalFile_aiDrinkUpload =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  // State field(s) for AiPrompt widget.
  FocusNode? aiPromptFocusNode;
  TextEditingController? aiPromptTextController;
  String? Function(BuildContext, String?)? aiPromptTextControllerValidator;
  // Stores action output result for [AI Agent - Send Message to DrinkParser] action in Button widget.
  Map<String, dynamic>? agentResponse;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    aiPromptFocusNode?.dispose();
    aiPromptTextController?.dispose();
  }
}
