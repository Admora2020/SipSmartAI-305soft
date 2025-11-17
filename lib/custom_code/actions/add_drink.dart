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

Future<int?> addDrink(
  BuildContext context,
  String drinkKey,
  String name,
  int? sizeMl,
) async {
  final uid = currentUserUid;
  if (uid.isEmpty) {
    debugPrint('incrementDrinkTotal: no user');
    return null;
  }

  String _slug(String s) => s
      .trim()
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
      .replaceAll(RegExp(r'_+'), '_')
      .replaceAll(RegExp(r'^_|_$'), '');

  final safeKey = _slug(drinkKey);
  final docId = '${uid}_${safeKey}';

  final totalsRef =
      FirebaseFirestore.instance.collection('drinkTotals').doc(docId);

  // Optional: keep the log for history/analytics
  final logsRef = FirebaseFirestore.instance.collection('drinks');

  int? newCount;

  await FirebaseFirestore.instance.runTransaction((tx) async {
    // 1) Read or create totals (ensure removed=false, bump lastAddedAt)
    final snap = await tx.get(totalsRef);
    if (!snap.exists) {
      tx.set(totalsRef, {
        'docId': docId,
        'ownerUid': uid,
        'drinkKey': safeKey,
        'name': name,
        if (sizeMl != null) 'size_ml': sizeMl,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'lastAddedAt': FieldValue.serverTimestamp(), // <—
        'removed': false, // <—
        'count': 1,
      });
      newCount = 1;
    } else {
      final data = (snap.data() as Map<String, dynamic>? ?? {});
      final current = (data['count'] as num?)?.toInt() ?? 0;
      final next = current + 1;
      tx.update(totalsRef, {
        'updatedAt': FieldValue.serverTimestamp(),
        'lastAddedAt': FieldValue.serverTimestamp(), // <—
        'removed': false, // revive if it was true
        'count': next,
      });
      newCount = next;
    }

    // 2) (Optional) Append log row for Undo/history
    final logRef = logsRef.doc(); // auto id
    tx.set(logRef, {
      'user': uid,
      'name': name,
      if (sizeMl != null) 'size_ml': sizeMl,
      'drinkKey': safeKey,
      'totalsDocId': docId,
      'currentTime': FieldValue.serverTimestamp(),
      'removed': false,
    });
  });

  debugPrint('incrementDrinkTotal → $docId = $newCount');
  return newCount;
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
