// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Automatic FlutterFlow importssize

import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

Future<int?> undoLastDrink(BuildContext context) async {
  final uid = currentUserUid;
  if (uid.isEmpty) return null;

  final col = FirebaseFirestore.instance.collection('drinkTotals');

  try {
    // Equality filters only (no orderBy => no composite index needed)
    final qs = await col
        .where('ownerUid', isEqualTo: uid)
        .where('removed', isEqualTo: false)
        .orderBy('lastAddedAt', descending: true)
        .limit(1)
        .get();

    if (qs.docs.isEmpty) return null;

    // Pick the newest by lastAddedAt (fallback to updatedAt/createdAt)
    QueryDocumentSnapshot<Map<String, dynamic>> newest = qs.docs.first;
    Timestamp stampOf(d) =>
        (d.data()['lastAddedAt'] as Timestamp?) ??
        (d.data()['updatedAt'] as Timestamp?) ??
        (d.data()['createdAt'] as Timestamp?) ??
        Timestamp(0, 0);

    for (final d in qs.docs) {
      if (stampOf(d).compareTo(stampOf(newest)) > 0) newest = d;
    }

    final ref = newest.reference;
    final data = newest.data();
    final current = (data['count'] as num?)?.toInt() ?? 0;

    if (current <= 1) {
      await ref.update({
        'count': 0,
        'removed': true,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      return 0;
    } else {
      final next = current - 1;
      await ref.update({
        'count': next,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      return next;
    }
  } catch (e) {
    debugPrint('[UNDO][ERROR] $e');
    return null;
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
