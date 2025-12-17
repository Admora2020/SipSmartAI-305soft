// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

Future<double> getTotalAlcoholGrams() async {
  final uid = currentUserUid;

  debugPrint('getTotalAlcoholGrams: uid="$uid"');

  if (uid.isEmpty) {
    debugPrint('getTotalAlcoholGrams: uid empty, returning 0');
    return 0.0;
  }

  try {
    final querySnap = await FirebaseFirestore.instance
        .collection('drinkTotals')
        .where('ownerUid', isEqualTo: uid)
        .where('removed', isEqualTo: false)
        .get();

    debugPrint(
        'getTotalAlcoholGrams: totals docs found = ${querySnap.docs.length}');

    double totalGrams = 0.0;

    for (final doc in querySnap.docs) {
      final data = doc.data();

      final count = (data['count'] as num?)?.toInt() ?? 0;
      final sizeMl = (data['size_ml'] as num?)?.toDouble();
      final abv = (data['abv'] as num?)?.toDouble();

      debugPrint(
          'doc=${doc.id} count=$count size_ml=$sizeMl abv=$abv removed=${data['removed']}');

      if (count <= 0 || sizeMl == null || abv == null) continue;

      final gramsPerDrink = sizeMl * (abv / 100.0) * 0.789;
      totalGrams += gramsPerDrink * count;
    }

    debugPrint('getTotalAlcoholGrams: totalGrams=$totalGrams');
    return totalGrams;
  } catch (e, st) {
    debugPrint('getTotalAlcoholGrams ERROR: $e\n$st');
    return 0.0;
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
