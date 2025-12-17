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
  double? abv, // ABV percentage (e.g. 5.0 for 5%)
  int? count,
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

  final logsRef = FirebaseFirestore.instance.collection('drinks');
  final userRef = FirebaseFirestore.instance.collection('users').doc(uid);

  int incrementAmount = 1;
  if (count != null) incrementAmount = count;

  int? newCount;

  await FirebaseFirestore.instance.runTransaction((tx) async {
    // Current time in ms
    final nowMs = DateTime.now().millisecondsSinceEpoch;

    // 🔹 Read user doc once inside the transaction
    final userSnap = await tx.get(userRef);
    final userData = userSnap.data() as Map<String, dynamic>?;
    final existingFirstMs =
        (userData?['firstDrinkTimestampMs'] as num?)?.toInt();
    final bool shouldSetFirst = existingFirstMs == null || existingFirstMs <= 0;

    // 1) totals doc
    final snap = await tx.get(totalsRef);
    if (!snap.exists) {
      tx.set(totalsRef, {
        'docId': docId,
        'ownerUid': uid,
        'drinkKey': safeKey,
        'name': name,
        if (sizeMl != null) 'size_ml': sizeMl,
        if (abv != null) 'abv': abv,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'lastAddedAt': FieldValue.serverTimestamp(),
        'lastDrinkTimestampMs': nowMs, // optional per-drink info
        'removed': false,
        'count': incrementAmount,
      });
      newCount = incrementAmount;
    } else {
      final data = (snap.data() as Map<String, dynamic>? ?? {});
      final current = (data['count'] as num?)?.toInt() ?? 0;
      final next = current + incrementAmount;

      final updateData = <String, dynamic>{
        'updatedAt': FieldValue.serverTimestamp(),
        'lastAddedAt': FieldValue.serverTimestamp(),
        'lastDrinkTimestampMs': nowMs,
        'removed': false,
        'count': next,
      };

      if (abv != null) {
        updateData['abv'] = abv;
      }
      if (sizeMl != null) {
        updateData['size_ml'] = sizeMl;
      }

      tx.update(totalsRef, updateData);
      newCount = next;
    }

    // 2) user-level drink timestamps
    final userUpdate = <String, dynamic>{
      // always update "last" for your time-since-last-drink timer
      'lastDrinkTimestampMs': nowMs,
      'lastDrinkAt': FieldValue.serverTimestamp(),
    };

    if (shouldSetFirst) {
      // only set "first" once, on the very first drink in the session/history
      userUpdate['firstDrinkTimestampMs'] = nowMs;
      userUpdate['firstDrinkAt'] = FieldValue.serverTimestamp();
    }

    tx.set(userRef, userUpdate, SetOptions(merge: true));

    // 3) log row (optional)
    final logRef = logsRef.doc();
    tx.set(logRef, {
      'user': uid,
      'name': name,
      if (sizeMl != null) 'size_ml': sizeMl,
      if (abv != null) 'abv': abv,
      'drinkKey': safeKey,
      'totalsDocId': docId,
      'currentTime': FieldValue.serverTimestamp(),
      'currentTimeMs': nowMs,
      'removed': false,
    });
  });

  debugPrint('incrementDrinkTotal → $docId = $newCount');
  return newCount;
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
