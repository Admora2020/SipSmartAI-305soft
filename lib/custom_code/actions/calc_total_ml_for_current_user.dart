// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<double> calcTotalMlForCurrentUser(
  BuildContext context,
  List<DrinkTotalsRecord>? docs,
) async {
  if (docs == null || docs.isEmpty) return 0.0;

  double total = 0.0;
  for (final r in docs) {
    if ((r.removed ?? false) == true) continue;

    final int count = r.count ?? 0;
    final double sizeMl = (r.sizeMl ?? 0).toDouble();

    if (count <= 0 || sizeMl <= 0) continue;

    total += count * sizeMl;
  }
  return total;
}
