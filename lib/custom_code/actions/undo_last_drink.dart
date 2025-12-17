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

Future<int?> undoLastDrink(BuildContext context) async {
  final uid = currentUserUid;
  if (uid.isEmpty) return null;

  final firestore = FirebaseFirestore.instance;
  final totalsCol = firestore.collection('drinkTotals');
  final userRef = firestore.collection('users').doc(uid);

  try {
    // 1) Get all active totals for this user
    final qs = await totalsCol
        .where('ownerUid', isEqualTo: uid)
        .where('removed', isEqualTo: false)
        .get();

    if (qs.docs.isEmpty) return null;

    // Helper: choose a timestamp for "most recently added"
    Timestamp stampOf(QueryDocumentSnapshot<Map<String, dynamic>> d) =>
        (d.data()['lastAddedAt'] as Timestamp?) ??
        (d.data()['updatedAt'] as Timestamp?) ??
        Timestamp(0, 0);

    // 2) Pick newest doc among those with count > 0
    QueryDocumentSnapshot<Map<String, dynamic>>? newest;
    for (final d in qs.docs) {
      final c = (d.data()['count'] as num?)?.toInt() ?? 0;
      if (c <= 0) continue;
      if (newest == null || stampOf(d).compareTo(stampOf(newest!)) > 0) {
        newest = d;
      }
    }

    if (newest == null) return null;

    final ref = newest!.reference;
    final data = newest!.data();
    final current = (data['count'] as num?)?.toInt() ?? 0;

    int nextCount;

    // 3) Decrement that totals doc
    if (current <= 1) {
      nextCount = 0;
      await ref.update({
        'count': 0,
        'removed': true,
        'updatedAt': FieldValue.serverTimestamp(),
        // DON'T touch lastAddedAt on undo
      });
    } else {
      nextCount = current - 1;
      await ref.update({
        'count': nextCount,
        'removed': false, // CRITICAL FIX
        'updatedAt': FieldValue.serverTimestamp(),
      });
    }

    // 4) Recompute FIRST + LAST from remaining active totals
    final qsAfter = await totalsCol
        .where('ownerUid', isEqualTo: uid)
        .where('removed', isEqualTo: false)
        .get();

    int latestMs = 0;
    Timestamp? latestTs;

    int earliestMs = 0;
    Timestamp? earliestTs;

    for (final d in qsAfter.docs) {
      final dt = d.data();
      final count = (dt['count'] as num?)?.toInt() ?? 0;
      if (count <= 0) continue;

      final lastAddedAt = dt['lastAddedAt'] is Timestamp
          ? dt['lastAddedAt'] as Timestamp
          : null;
      final updatedAt =
          dt['updatedAt'] is Timestamp ? dt['updatedAt'] as Timestamp : null;

      // "Last" candidate = later of lastAddedAt/updatedAt
      Timestamp? candidateLastTs;
      if (lastAddedAt != null && updatedAt != null) {
        candidateLastTs =
            lastAddedAt.compareTo(updatedAt) >= 0 ? lastAddedAt : updatedAt;
      } else {
        candidateLastTs = lastAddedAt ?? updatedAt;
      }

      // "First" candidate for BAC timing:
      // earliest of lastAddedAt/updatedAt (NOT createdAt)
      Timestamp? candidateFirstTs;
      if (lastAddedAt != null && updatedAt != null) {
        candidateFirstTs =
            lastAddedAt.compareTo(updatedAt) <= 0 ? lastAddedAt : updatedAt;
      } else {
        candidateFirstTs = lastAddedAt ?? updatedAt;
      }
      candidateFirstTs ??= candidateLastTs;

      if (candidateLastTs != null) {
        final ms = candidateLastTs.millisecondsSinceEpoch;
        if (ms > latestMs) {
          latestMs = ms;
          latestTs = candidateLastTs;
        }
      }

      if (candidateFirstTs != null) {
        final ms = candidateFirstTs.millisecondsSinceEpoch;
        if (earliestMs == 0 || ms < earliestMs) {
          earliestMs = ms;
          earliestTs = candidateFirstTs;
        }
      }
    }

    final hasNoDrinks = latestMs == 0;

    // 5) Update user timestamps
    await userRef.set({
      'firstDrinkTimestampMs': hasNoDrinks ? 0 : earliestMs,
      'firstDrinkAt': hasNoDrinks ? null : earliestTs,
      'lastDrinkTimestampMs': hasNoDrinks ? 0 : latestMs,
      'lastDrinkAt': hasNoDrinks ? null : latestTs,
    }, SetOptions(merge: true));

    return nextCount;
  } catch (e) {
    debugPrint('[UNDO][ERROR] $e');
    return null;
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
