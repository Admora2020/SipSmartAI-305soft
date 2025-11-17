// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Additional Imports (set these in FF → Custom Action → Additional Imports)
//

import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

Future<double?> getTotalMl(BuildContext context) async {
  final uid = currentUserUid;
  if (uid.isEmpty) {
    debugPrint('[getTotalMl] No user signed in');
    return null;
  }

  final col = FirebaseFirestore.instance.collection('drinkTotals');

  double totalMl = 0.0;
  const pageSize = 500;
  DocumentSnapshot<Map<String, dynamic>>? last;

  try {
    while (true) {
      Query<Map<String, dynamic>> q = col
          .where('ownerUid', isEqualTo: uid)
          .where('removed', isEqualTo: false)
          .limit(pageSize);

      if (last != null) {
        q = q.startAfterDocument(last);
      }

      final snap = await q.get();
      if (snap.docs.isEmpty) break;

      for (final d in snap.docs) {
        final data = d.data();
        final count = (data['count'] as num?)?.toDouble() ?? 0.0;
        final sizeMl = (data['size_ml'] as num?)?.toDouble() ?? 0.0;

        totalMl += count * sizeMl;
      }

      last = snap.docs.last;
      if (snap.docs.length < pageSize) break;
    }

    debugPrint('[getTotalMl] Total = $totalMl mL');
    return totalMl;
  } catch (e) {
    debugPrint('[getTotalMl][ERROR] $e');
    return null;
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
