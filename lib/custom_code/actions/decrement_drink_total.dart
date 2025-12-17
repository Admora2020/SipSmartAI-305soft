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

Future<int?> decrementDrinkTotal(
  BuildContext context,
  String totalsDocId,
) async {
  final uid = currentUserUid;
  if (uid.isEmpty) return null;

  final firestore = FirebaseFirestore.instance;
  final totalsCol = firestore.collection('drinkTotals');
  final totalsRef = totalsCol.doc(totalsDocId);
  final userRef = firestore.collection('users').doc(uid);

  int? nextCount;
  bool removedNow = false;

  try {
    // 1) Decrement this totals doc
    await firestore.runTransaction((tx) async {
      final snap = await tx.get(totalsRef);
      if (!snap.exists) {
        nextCount = 0;
        return;
      }

      final data = snap.data() as Map<String, dynamic>? ?? {};
      final owner = data['ownerUid'] as String? ?? '';
      if (owner != uid) {
        nextCount = (data['count'] as num?)?.toInt() ?? 0;
        return;
      }

      final current = (data['count'] as num?)?.toInt() ?? 0;

      if (current <= 1) {
        removedNow = true;
        nextCount = 0;
        tx.update(totalsRef, {
          'count': 0,
          'removed': true,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      } else {
        nextCount = current - 1;
        tx.update(totalsRef, {
          'count': nextCount,
          'removed': false,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
    });

    if (nextCount == null) return null;

    // 2) Only adjust timestamps if we REMOVED a drink (count hit 0)
    if (removedNow) {
      // Check if any active drinks remain
      final remaining = await totalsCol
          .where('ownerUid', isEqualTo: uid)
          .where('removed', isEqualTo: false)
          .limit(50)
          .get();

      bool hasAnyActive = false;
      for (final d in remaining.docs) {
        final c = (d.data()['count'] as num?)?.toInt() ?? 0;
        if (c > 0) {
          hasAnyActive = true;
          break;
        }
      }

      if (!hasAnyActive) {
        // Nothing left: reset to zero / null
        await userRef.set({
          'firstDrinkTimestampMs': 0,
          'lastDrinkTimestampMs': 0,
          'firstDrinkAt': null,
          'lastDrinkAt': null,
        }, SetOptions(merge: true));
      } else {
        // Still have drinks: reset timer to now
        final nowMs = DateTime.now().millisecondsSinceEpoch;
        await userRef.set({
          'firstDrinkTimestampMs': nowMs,
          'lastDrinkTimestampMs': nowMs,
          'firstDrinkAt': FieldValue.serverTimestamp(),
          'lastDrinkAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }
    }

    return nextCount;
  } catch (e) {
    debugPrint('[decrementDrinkTotal][ERROR] $e');
    return null;
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
