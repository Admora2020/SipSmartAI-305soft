// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

//
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

Future<List<DrinkPresetsRecord>> getAvailableDrinkPresets(
    BuildContext context) async {
  final uid = currentUserUid;

  if (uid.isEmpty) {
    debugPrint('[getAvailableDrinkPresets] No user signed in');
    return [];
  }

  final userRef = FirebaseFirestore.instance.collection('users').doc(uid);

  final presetsRef = FirebaseFirestore.instance.collection('drinkPresets');

  try {
    // Query 1: user-owned presets
    final userSnap = await presetsRef.where('user', isEqualTo: userRef).get();

    // Query 2: global presets (user field is null)
    final globalSnap = await presetsRef.where('user', isNull: true).get();

    // Convert both to DrinkPresetsRecord
    final userPresets =
        userSnap.docs.map((d) => DrinkPresetsRecord.fromSnapshot(d));
    final globalPresets =
        globalSnap.docs.map((d) => DrinkPresetsRecord.fromSnapshot(d));

    // Merge
    final all = <DrinkPresetsRecord>[];
    all.addAll(userPresets);
    all.addAll(globalPresets);

    debugPrint(
        '[getAvailableDrinkPresets] loaded ${all.length} presets (user + global)');

    return all;
  } catch (e) {
    debugPrint('[getAvailableDrinkPresets][ERROR] $e');
    return [];
  }
}
