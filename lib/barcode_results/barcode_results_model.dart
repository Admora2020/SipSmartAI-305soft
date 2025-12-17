import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'barcode_results_widget.dart' show BarcodeResultsWidget;
import 'package:flutter/material.dart';

class BarcodeResultsModel extends FlutterFlowModel<BarcodeResultsWidget> {
  ///  Local state fields for this page.

  DrinkCatalogRecord? drinkRecord;

  String drinkName = 'drinkName';

  String drinkBrand = 'Brand Name';

  String? drinkDescription;

  String? imageURL;

  String? drinkABV;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (BarcodeInfoFetch)] action in BarcodeResults widget.
  ApiCallResponse? apiResultk40;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
