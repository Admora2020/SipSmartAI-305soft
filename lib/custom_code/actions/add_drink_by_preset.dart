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
import '/flutter_flow/custom_functions.dart';

Future addDrinkByPreset(
  BuildContext context,
  String presetName,
) async {
  final uid = currentUserUid;
  if (uid.isEmpty) {
    debugPrint('[addDrinkByPreset] No user signed in');
    return;
  }

  final userRef = FirebaseFirestore.instance.collection('users').doc(uid);
  final presetsRef = FirebaseFirestore.instance.collection('drinkPresets');

  try {
    // Query 1: user-owned preset (priority)
    final userSnap = await presetsRef
        .where('drink_name', isEqualTo: presetName)
        .where('user', isEqualTo: userRef)
        .limit(1)
        .get();

    // Query 2: global preset (fallback)
    final globalSnap = await presetsRef
        .where('drink_name', isEqualTo: presetName)
        .where('user', isNull: true)
        .limit(1)
        .get();

    DocumentSnapshot<Map<String, dynamic>>? presetDoc;

    if (userSnap.docs.isNotEmpty) {
      presetDoc = userSnap.docs.first;
    } else if (globalSnap.docs.isNotEmpty) {
      presetDoc = globalSnap.docs.first;
    } else {
      debugPrint('[addDrinkByPreset] No preset found for "$presetName"');
      return;
    }

    final preset = presetDoc.data();
    if (preset == null) return;

    final size = preset['drink_size'] as num?;
    final abv = preset['drink_abv'] as num?;
    final sizeType = preset['drink_size_type'] as String?;

    if (size == null || abv == null) {
      debugPrint('[addDrinkByPreset] Missing size or ABV');
      return;
    }

    // Convert to mL if needed
    double sizeMl = size.toDouble();
    if (sizeType != null) {
      sizeMl = convertToMl(sizeMl, sizeType);
    }

    final drinkRef = FirebaseFirestore.instance.collection('drinks').doc();

    await drinkRef.set({
      'drink_name': presetName,
      'drink_size': sizeMl,
      'drink_abv': abv.toDouble(),
      'counter': 1,
      'currentTime': FieldValue.serverTimestamp(),
      'removed': false,
      'user': userRef,
    });

    debugPrint('[addDrinkByPreset] Added drink from preset "$presetName"');
  } catch (e) {
    debugPrint('[addDrinkByPreset][ERROR] $e');
  }
}
