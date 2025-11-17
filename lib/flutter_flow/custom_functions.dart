import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

String? feetAndInches(
  int? heightFeet,
  int? heightInches,
) {
  // I want the function to return a string in the format of how you display feet and inches in the Imperial system, e.g., 5'9"
  if (heightFeet == null || heightInches == null) {
    return null; // Return null if any input is null
  }
  return '${heightFeet}\'${heightInches}\"'; // Format the string as feet and inches
}

double? recalculatedTolerance(double? toleranceLevel) {
  // take the argument and return it reduced by 1
  if (toleranceLevel == null) {
    return null; // Return null if input is null
  }
  return toleranceLevel + 1; // Reduce the tolerance level by 1
}

int? is21OrOlder(DateTime? date) {
// Check if the date/time that the user picked is 21 years or older from the current date/time
  if (date == null) {
    return null; // Return null if input is null
  }
  final DateTime currentDate = DateTime.now();
  final DateTime twentyOneYearsAgo =
      DateTime(currentDate.year - 21, currentDate.month, currentDate.day);
  return date.isBefore(twentyOneYearsAgo)
      ? 1
      : 0; // Return 1 if 21 years or older, otherwise return 0
}

String totalDocsId(
  String uid,
  String drinkKey,
) {
  final safeKey = drinkKey
      .trim()
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
      .replaceAll(RegExp(r'_+'), '_')
      .replaceAll(RegExp(r'^_|_$'), '');
  return '${uid}_${safeKey}';
}

String formatProgressString(
  double totalMl,
  int goalMl,
) {
  if (totalMl < 0) totalMl = 0;
  final int t = totalMl.round();
  return '$t/$goalMl mL';
}

double progressRatio(
  double totalMl,
  int goalMl,
) {
  if (goalMl <= 0) return 0.0;

  double ratio = totalMl / goalMl;

  // Clamp to 0.0–1.0 (FlutterFlow expects this)
  if (ratio < 0.0) ratio = 0.0;
  if (ratio > 1.0) ratio = 1.0;

  return ratio;
}
