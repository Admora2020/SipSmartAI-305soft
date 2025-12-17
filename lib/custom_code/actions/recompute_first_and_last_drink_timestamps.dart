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

Future<void> recomputeFirstAndLastDrinkTimestamps() async {
  final uid = currentUserUid;
  if (uid.isEmpty) {
    debugPrint('recomputeFirstAndLastDrinkTimestamps: no user');
    return;
  }

  final firestore = FirebaseFirestore.instance;
  final totalsRef = firestore.collection('drinkTotals');
  final userRef = firestore.collection('users').doc(uid);

  try {
    // Only active drinkTotals docs
    final qSnap = await totalsRef
        .where('ownerUid', isEqualTo: uid)
        .where('removed', isEqualTo: false)
        .get();

    debugPrint(
        'recomputeFirstAndLastDrinkTimestamps: found ${qSnap.docs.length} active drinkTotals docs for $uid');

    int latestMs = 0;
    Timestamp? latestTs;

    int earliestMs = 0;
    Timestamp? earliestTs;

    for (final doc in qSnap.docs) {
      final data = doc.data();

      final count = (data['count'] as num?)?.toInt() ?? 0;
      if (count <= 0) {
        continue; // nothing active of this type
      }

      // ----- LAST (most recent drink) -----
      final Timestamp? lastAddedAt = data['lastAddedAt'] is Timestamp
          ? data['lastAddedAt'] as Timestamp
          : null;
      final Timestamp? updatedAt = data['updatedAt'] is Timestamp
          ? data['updatedAt'] as Timestamp
          : null;

      Timestamp? candidateLastTs;
      if (lastAddedAt != null && updatedAt != null) {
        candidateLastTs =
            lastAddedAt.compareTo(updatedAt) >= 0 ? lastAddedAt : updatedAt;
      } else {
        candidateLastTs = lastAddedAt ?? updatedAt;
      }

      if (candidateLastTs != null) {
        final candidateLastMs = candidateLastTs.millisecondsSinceEpoch;
        if (candidateLastMs > latestMs) {
          latestMs = candidateLastMs;
          latestTs = candidateLastTs;
        }
      }

      // ----- FIRST (earliest remaining drink) -----
      // Best approximation with drinkTotals = createdAt (first time this type existed)
      // Fall back to lastAddedAt/updatedAt if createdAt missing.
      final Timestamp? createdAt = data['createdAt'] is Timestamp
          ? data['createdAt'] as Timestamp
          : null;

      Timestamp? candidateFirstTs = createdAt ?? candidateLastTs;

      if (candidateFirstTs != null) {
        final candidateFirstMs = candidateFirstTs.millisecondsSinceEpoch;

        if (earliestMs == 0 || candidateFirstMs < earliestMs) {
          earliestMs = candidateFirstMs;
          earliestTs = candidateFirstTs;
        }
      }
    }

    // If no active drinks remain, reset everything
    final hasNoDrinks = latestMs == 0;

    await userRef.update({
      'lastDrinkTimestampMs': hasNoDrinks ? 0 : latestMs,
      'lastDrinkAt': hasNoDrinks ? null : latestTs,
      'firstDrinkTimestampMs': hasNoDrinks ? 0 : earliestMs,
      'firstDrinkAt': hasNoDrinks ? null : earliestTs,
    });

    debugPrint('recomputeFirstAndLastDrinkTimestamps: updated user → '
        'lastMs=$latestMs, lastTs=$latestTs, '
        'firstMs=$earliestMs, firstTs=$earliestTs');
  } catch (e, st) {
    debugPrint('recomputeFirstAndLastDrinkTimestamps ERROR: $e\n$st');
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
