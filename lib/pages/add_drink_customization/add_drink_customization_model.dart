import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'add_drink_customization_widget.dart' show AddDrinkCustomizationWidget;
import 'package:flutter/material.dart';

class AddDrinkCustomizationModel
    extends FlutterFlowModel<AddDrinkCustomizationWidget> {
  ///  Local state fields for this component.

  DrinkPresetsRecord? activePreset;

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

  List<String> availablePresetNames = [];
  void addToAvailablePresetNames(String item) => availablePresetNames.add(item);
  void removeFromAvailablePresetNames(String item) =>
      availablePresetNames.remove(item);
  void removeAtIndexFromAvailablePresetNames(int index) =>
      availablePresetNames.removeAt(index);
  void insertAtIndexInAvailablePresetNames(int index, String item) =>
      availablePresetNames.insert(index, item);
  void updateAvailablePresetNamesAtIndex(
          int index, Function(String) updateFn) =>
      availablePresetNames[index] = updateFn(availablePresetNames[index]);

  String? activePresetName;

  DocumentReference? activePresetReference;

  double? drinkSize;

  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Custom Action - getAvailableDrinkPresets] action in addDrinkCustomization widget.
  List<DrinkPresetsRecord>? initAvailablePresets;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Stores action output result for [Custom Action - getAvailableDrinkPresets] action in IconButton widget.
  List<DrinkPresetsRecord>? trashPresetAvailableDrinks;
  // State field(s) for DrinkName widget.
  FocusNode? drinkNameFocusNode;
  TextEditingController? drinkNameTextController;
  String? Function(BuildContext, String?)? drinkNameTextControllerValidator;
  String? _drinkNameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Drink Name is required';
    }

    if (val.length < 1) {
      return 'Requires at least 1 characters.';
    }
    if (val.length > 20) {
      return 'Maximum 20 characters allowed, currently ${val.length}.';
    }

    return null;
  }

  // State field(s) for DrinkSize widget.
  FocusNode? drinkSizeFocusNode;
  TextEditingController? drinkSizeTextController;
  String? Function(BuildContext, String?)? drinkSizeTextControllerValidator;
  String? _drinkSizeTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Drink Size is required';
    }

    return null;
  }

  // State field(s) for DrinkSizeType widget.
  String? drinkSizeTypeValue;
  FormFieldController<String>? drinkSizeTypeValueController;
  // State field(s) for DrinkABV widget.
  FocusNode? drinkABVFocusNode;
  TextEditingController? drinkABVTextController;
  String? Function(BuildContext, String?)? drinkABVTextControllerValidator;
  String? _drinkABVTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Drink ABV is required';
    }

    return null;
  }

  // State field(s) for DrinkCount widget.
  int? drinkCountValue;
  // Stores action output result for [Custom Action - getAvailableDrinkPresets] action in Button widget.
  List<DrinkPresetsRecord>? savePresetAvailableDrinks;
  // Stores action output result for [Custom Action - getTotalMl] action in Button widget.
  double? totalMlOther;

  @override
  void initState(BuildContext context) {
    drinkNameTextControllerValidator = _drinkNameTextControllerValidator;
    drinkSizeTextControllerValidator = _drinkSizeTextControllerValidator;
    drinkABVTextControllerValidator = _drinkABVTextControllerValidator;
  }

  @override
  void dispose() {
    drinkNameFocusNode?.dispose();
    drinkNameTextController?.dispose();

    drinkSizeFocusNode?.dispose();
    drinkSizeTextController?.dispose();

    drinkABVFocusNode?.dispose();
    drinkABVTextController?.dispose();
  }
}
