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
  String goalMl,
) {
  if (totalMl < 0) totalMl = 0;
  final int t = totalMl.round();
  return '$t/$goalMl mL';
}

double calculateBac(
  double totalGrams,
  int weightKg,
  String sex,
  int timeSinceStart,
) {
  final hoursSinceStart = timeSinceStart / 3600000.0;

  if (totalGrams <= 0 || weightKg <= 0) return 0.0;

  double r;
  final s = sex.toLowerCase();
  if (s == 'Male') {
    r = 0.68;
  } else if (s == 'Female') {
    r = 0.55;
  } else {
    r = 0.63; // fallback
  }

  const beta = 0.015; // BAC per hour

  double bac =
      (totalGrams / (r * (weightKg * 1000))) * 100 - (beta * hoursSinceStart);
  if (bac < 0) bac = 0.0;
  return bac;
}

int currentTimeMs() {
  return DateTime.now().millisecondsSinceEpoch;
}

int? timeSinceLastDrinkMs(int? lastDrinkTimestampMs) {
  if (lastDrinkTimestampMs == null || lastDrinkTimestampMs <= 0) {
    return null; // FlutterFlow will treat this as "no value"
  }

  final nowMs = DateTime.now().millisecondsSinceEpoch;

  int diffMs = nowMs - lastDrinkTimestampMs;

  if (diffMs < 0) {
    diffMs = 0; // Should never be negative, but safe guard
  }

  return diffMs;
}

String? timeSinceLastDrinkFormatted(int? lastDrinkTimestampMs) {
// If no drink recorded yet
  // If no timestamp exists → return null
  if (lastDrinkTimestampMs == null || lastDrinkTimestampMs <= 0) {
    return '00:00:00';
  }

  // Current time in ms
  final nowMs = DateTime.now().millisecondsSinceEpoch;

  // Difference in ms
  int diffMs = nowMs - lastDrinkTimestampMs;
  if (diffMs < 0) diffMs = 0;

  // Convert to Duration
  final d = Duration(milliseconds: diffMs);

  // Format helper
  String two(int v) => v.toString().padLeft(2, '0');

  final hours = two(d.inHours);
  final minutes = two(d.inMinutes.remainder(60));
  final seconds = two(d.inSeconds.remainder(60));

  return '$hours:$minutes:$seconds';
}

String? timeUntilSoberFormatted(double? currentBAC) {
// If BAC is not known or already 0, no countdown needed
  if (currentBAC == null || currentBAC <= 0.0) {
    return '00:00:00';
  }

  const double eliminationRatePerHour = 0.015;

  // Hours until BAC hits 0
  double hoursRemaining = currentBAC / eliminationRatePerHour;

  if (hoursRemaining <= 0) {
    return null;
  }

  // Convert to whole seconds for display
  int totalSeconds = (hoursRemaining * 3600).round();

  final d = Duration(seconds: totalSeconds);

  String two(int v) => v.toString().padLeft(2, '0');

  final hours = two(d.inHours);
  final minutes = two(d.inMinutes.remainder(60));
  final seconds = two(d.inSeconds.remainder(60));

  return '$hours:$minutes:$seconds';
}

int? lbsToKg(int? lbs) {
  if (lbs == null) return null;
  // 1 lb = 0.45359237 kg
  double kgDecimal = lbs * 0.45359237;
  return kgDecimal.toInt();
}

int? elapseSinceFirstDrinkMs(int? firstDrinkTimestampMs) {
  if (firstDrinkTimestampMs == null || firstDrinkTimestampMs <= 0) {
    return 0;
  }

  final nowMs = DateTime.now().millisecondsSinceEpoch;
  int diffMs = nowMs - firstDrinkTimestampMs;

  if (diffMs < 0) {
    diffMs = 0;
  }

  return diffMs;
}

double progressRatio(
  double totalMl,
  String goalMl,
) {
  final parsed = double.tryParse(goalMl);
  if (parsed == null || parsed <= 0) {
    return 0.0; // invalid input â prevent crashes
  }

  final goal = parsed;

  double ratio = totalMl / goal;

  // Clamp to 0.0â1.0
  if (ratio < 0.0) ratio = 0.0;
  if (ratio > 1.0) ratio = 1.0;

  return ratio;
}

double? bacProgressRatio(
  double currentBAC,
  String bacLimit,
) {
  final limit = double.tryParse(bacLimit); // BAC limit for the bar
  if (limit == null || limit <= 0) return 0.0;
  if (currentBAC == null || currentBAC <= 0) {
    return 0.0;
  }

  final ratio = currentBAC / limit;

  if (ratio >= 1.0) return 1.0;
  if (ratio <= 0.0) return 0.0;
  return ratio;
}

String? bacProgressLabel(
  double? currentBAC,
  String limit,
) {
  final bacLimit = double.tryParse(limit);
  final bac = (currentBAC == null || currentBAC < 0) ? 0.0 : currentBAC;
  if (bacLimit == null || bacLimit <= 0) return "0.0";
  String fmt(double v) => v.toStringAsFixed(3);

  return '${fmt(bac)} / ${fmt(bacLimit)} %';
}

DateTime? oneHour(DateTime currentTime) {
  // get current time and return a time an hour later
  return currentTime.add(Duration(hours: 1));
}

List<DrinkPresetsRecord>? combineDrinkPresetLists(
  List<DrinkPresetsRecord>? a,
  List<DrinkPresetsRecord>? b,
) {
  final combinedList = [...?a, ...?b];
  combinedList.sort((x, y) => x.drinkName.compareTo(y.drinkName));
  return combinedList;
}

DrinkPresetsRecord? getDrinkPreset(
  List<DrinkPresetsRecord> presets,
  String name,
) {
  for (var preset in presets) {
    if (preset.drinkName == name) {
      return preset;
    }
  }
  return null;
}

List<String> getDrinkPresetListNames(List<DrinkPresetsRecord>? presets) {
  if (presets == null) return [];
  return presets.map((preset) => preset.drinkName).toList();
}

bool doesPresetExist(
  List<DrinkPresetsRecord>? presets,
  String name,
) {
  if (presets == null) return false;

  final target = name.toLowerCase();

  for (final p in presets) {
    if (p == null) continue;

    final presetName = p.drinkName?.toLowerCase();

    if (presetName != null && presetName == target) {
      return true;
    }
  }

  return false;
}

double convertToMl(
  double amount,
  String unit,
) {
  final u = unit.trim().toLowerCase();

  // direct mL
  if (u == 'ml' || u == 'milliliter' || u == 'milliliters') {
    return amount;
  }

  // ounces
  if (u == 'oz' || u == 'ounce' || u == 'ounces') {
    return amount * 29.5735;
  }

  // cups (US standard)
  if (u == 'cup' || u == 'cups') {
    return amount * 240.0;
  }

  // fallback, no change
  return amount;
}

String toLowerCase(String a) {
  return a.toLowerCase();
}

DateTime startOfDay(DateTime date) {
  return DateTime(date.year, date.month, date.day);
}

DateTime startOfWeek(DateTime date) {
  final d = DateTime(date.year, date.month, date.day);
  final weekday = d.weekday % 7; // Sunday = 0
  return d.subtract(Duration(days: weekday));
}

DateTime addDays(
  DateTime date,
  int days,
) {
  return date.add(Duration(days: days));
}

String formatDayLabel(DateTime date) {
  return DateFormat('EEE').format(date);
}

DateTime startOfMonth(DateTime date) {
  return DateTime(date.year, date.month, 1);
}

DateTime addMonths(
  DateTime date,
  int months,
) {
  final totalMonths = date.year * 12 + (date.month - 1) + months;
  final year = totalMonths ~/ 12;
  final month = totalMonths % 12 + 1;

  // Keep the day inside the new month's valid days
  final lastDayOfNewMonth = DateTime(year, month + 1, 0).day;
  final day = date.day.clamp(1, lastDayOfNewMonth);

  return DateTime(year, month, day);
}

int daysInMonth(DateTime date) {
  final firstDayThisMonth = DateTime(date.year, date.month, 1);
  final firstDayNextMonth = DateTime(date.year, date.month + 1, 1);
  return firstDayNextMonth.difference(firstDayThisMonth).inDays;
}

String safeDaysLabel(
  int safeCount,
  int totalDays,
) {
  return '$safeCount/$totalDays days';
}

double safeDaysProgress(
  int safeCount,
  int totalDays,
) {
  if (totalDays <= 0) {
    return 0.0;
  }
  return safeCount / totalDays;
}

double totalIntakeThisMonth(List<DailyLogsRecord> logs) {
  double total = 0;

  for (var item in logs) {
    final ml = item.totalMlConsumed ?? 0;
    total += ml;
  }

  return total;
}

String highestIntakeThisMonth(List<DailyLogsRecord> logs) {
  if (logs.isEmpty) {
    return 'No data';
  }

  DailyLogsRecord? best;

  for (final log in logs) {
    final current = log.totalMlConsumed ?? 0;
    if (best == null) {
      best = log;
    } else {
      final bestVal = best!.totalMlConsumed ?? 0;
      if (current > bestVal) {
        best = log;
      }
    }
  }

  if (best == null || best!.date == null) {
    return 'No data';
  }

  final date = best!.date!;
  final ml = (best!.totalMlConsumed ?? 0).round();
  final dateStr = DateFormat('MMMM d').format(date); // e.g. "June 12"

  return '$dateStr ($ml mL)';
}

String formatMonthYear(DateTime date) {
  // Example: Dec 2025
  return DateFormat('MMM yyyy').format(date);
}

DateTime startOfYear(DateTime date) {
  return DateTime(date.year, 1, 1);
}

String yearlyControlMessage(List<DailyLogsRecord> logs) {
  int safeCount = 0;

  for (var item in logs) {
    // If you use within_safe_limit instead, change this line
    if (item.safeDay == true) {
      safeCount++;
    }
  }

  return 'You stayed in control for $safeCount days this year 🍷';
}

String bestMonthThisYear(List<DailyLogsRecord> logs) {
  double _safeTotalMl(DailyLogsRecord log) => log.totalMlConsumed ?? 0.0;

  if (logs.isEmpty) {
    return 'No data yet';
  }

  // Sum total_ml_consumed per month (1–12)
  final Map<int, double> monthTotals = {};

  for (final log in logs) {
    final date = log.date;
    if (date == null) continue;

    final month = date.month; // 1..12
    final ml = _safeTotalMl(log);

    monthTotals[month] = (monthTotals[month] ?? 0) + ml;
  }

  if (monthTotals.isEmpty) {
    return 'No data yet';
  }

  // Find month with **lowest** total
  int bestMonth = monthTotals.keys.first;
  double bestTotal = monthTotals[bestMonth]!;

  monthTotals.forEach((m, total) {
    if (total < bestTotal) {
      bestMonth = m;
      bestTotal = total;
    }
  });

  // Convert month number → name
  final monthName = DateFormat('MMMM').format(DateTime(2000, bestMonth, 1));

  // Round mL so it looks nice
  final roundedMl = bestTotal.round();

  return '$monthName ($roundedMl mL)';
}

String longestSafeStreakThisYear(List<DailyLogsRecord> logs) {
  if (logs.isEmpty) {
    return 'Longest safe streak: 0 days';
  }

  // Sort by date ascending
  logs.sort(
      (a, b) => (a.date ?? DateTime(2000)).compareTo(b.date ?? DateTime(2000)));

  int current = 0;
  int best = 0;

  for (final log in logs) {
    final bool isSafe =
        (log.safeDay ?? false) || (log.withinSafeLimit ?? false);

    if (isSafe) {
      current += 1;
      if (current > best) best = current;
    } else {
      current = 0;
    }
  }

  if (best <= 0) {
    return 'Longest safe streak: 0 days';
  }

  final suffix = best == 1 ? 'day' : 'days';
  return 'Longest safe streak: $best $suffix';
}

String safeDaysThisYearLabel(List<DailyLogsRecord> logs) {
  // If there are no logs, show a simple message.
  if (logs.isEmpty) {
    return 'Safe days: 0/0 (0%)';
  }

  // Assume logs are already filtered to a single year (this year).
  // Get the year from the first log, fall back to now if missing.
  final year = (logs.first.date ?? DateTime.now()).year;

  // Handle leap years.
  final isLeapYear = DateTime(year, 2, 29).month == 2;
  final totalDaysInYear = isLeapYear ? 366 : 365;

  int safeDays = 0;

  for (final log in logs) {
    final bool isSafe =
        (log.safeDay ?? false) || (log.withinSafeLimit ?? false);
    if (isSafe) {
      safeDays += 1;
    }
  }

  final percent = totalDaysInYear == 0 ? 0 : (safeDays * 100 / totalDaysInYear);
  final percentStr = percent.toStringAsFixed(0); // whole number %

  return 'Safe days: $safeDays/$totalDaysInYear ($percentStr%)';
}

String improvementThisYearLabel(List<DailyLogsRecord> logs) {
  // Not enough data → neutral message.
  if (logs.length < 6) {
    return 'Improvement: keep logging and we\'ll show trends soon';
  }

  // Sort logs by date ascending.
  final sorted = [...logs]..sort(
      (a, b) => (a.date ?? DateTime(1970)).compareTo(b.date ?? DateTime(1970)));

  final mid = sorted.length ~/ 2;
  final early = sorted.sublist(0, mid);
  final recent = sorted.sublist(mid);

  double _safePercent(List<DailyLogsRecord> list) {
    if (list.isEmpty) return 0.0;

    int safeDays = 0;
    for (final log in list) {
      final isSafe = (log.safeDay ?? false) || (log.withinSafeLimit ?? false);
      if (isSafe) safeDays += 1;
    }
    return safeDays * 100.0 / list.length;
  }

  final earlyPct = _safePercent(early);
  final recentPct = _safePercent(recent);
  final diff = recentPct - earlyPct;

  // If change is tiny, call it "about the same".
  if (diff.abs() < 2.0) {
    return 'Improvement: about the same as earlier this year';
  }

  final diffStr = diff.abs().toStringAsFixed(0);

  if (diff > 0) {
    return 'Improvement: $diffStr% safer than earlier this year';
  } else {
    return 'Improvement: $diffStr% more drinking than earlier this year';
  }
}

String yearlyEncouragementLabel(List<DailyLogsRecord> logs) {
  // No data at all
  if (logs.isEmpty) {
    return 'Once you start logging, we\'ll show your yearly progress here.';
  }

  final totalDays = logs.length;
  int safeDays = 0;

  for (final log in logs) {
    // 👇 Use the SAME getters you already used in your other functions
    final isSafe = (log.safeDay ?? false) || (log.withinSafeLimit ?? false);
    if (isSafe) safeDays += 1;
  }

  final pct = safeDays * 100.0 / totalDays;

  // Very small dataset → gentle message
  if (totalDays < 10) {
    return 'Nice start! Keep logging and we\'ll show your trends soon.';
  }

  if (pct >= 85.0) {
    return 'You\'re mastering moderation – most days are safe. Amazing work 🎯';
  } else if (pct >= 65.0) {
    return 'You\'re doing well – more safe days than not. Keep building the habit 💪';
  } else if (pct >= 45.0) {
    return 'You\'re on your way. A few more safe days each month will make a big difference 👍';
  } else {
    return 'This year looks tough, but every safe day matters. Be kind to yourself and keep going 💛';
  }
}

String formatYearLabel(DateTime date) {
  return DateFormat('y').format(date); // e.g. 2025
}

String formatWeekLabel(DateTime weekStart) {
  final start = weekStart;
  final end = weekStart.add(const Duration(days: 6));

  final startFmt = DateFormat('MMM d').format(start);
  final endFmt = DateFormat('MMM d').format(end);

  // Example: "Dec 8 – Dec 14"
  return '$startFmt – $endFmt';
}

List<String> weekDayLabels(DateTime weekStart) {
  // Normalise to midnight so we don't get weird off-by-one issues
  final start = DateTime(weekStart.year, weekStart.month, weekStart.day);

  final labels = <String>[];

  for (var i = 0; i < 7; i++) {
    final d = start.add(Duration(days: i));
    // Example: "Nov 30"
    labels.add(DateFormat('MMM d').format(d));
  }

  return labels;
}

List<double> weeklyTotalsForChart(
  List<DailyLogsRecord> logs,
  DateTime weekStart,
) {
  // Normalise weekStart to midnight
  final start = DateTime(weekStart.year, weekStart.month, weekStart.day);
  final end = start.add(const Duration(days: 7));

  // One slot per day: Sun..Sat (or whatever your weekStart is)
  final totals = List<double>.filled(7, 0.0);

  for (final log in logs) {
    final dt = log.date;
    if (dt == null) continue;

    final day = DateTime(dt.year, dt.month, dt.day);

    // Only include logs inside this week window
    if (day.isBefore(start) || !day.isBefore(end)) continue;

    final index = day.difference(start).inDays;
    if (index < 0 || index >= 7) continue;

    // Use the field we've been saving from Golden Path
    final ml = log.totalMlConsumed ?? 0.0;

    totals[index] += ml;
  }

  return totals;
}

dynamic weeklySummary(
  List<DailyLogsRecord> logs,
  DateTime weekStart,
) {
  // Normalize week start to midnight
  final start = DateTime(weekStart.year, weekStart.month, weekStart.day);
  final end = start.add(const Duration(days: 7));

  double totalMl = 0.0;
  int safeDays = 0;
  int streak = 0;
  int longestStreak = 0;

  for (final log in logs) {
    final dt = log.date;
    if (dt == null) continue;

    final logDay = DateTime(dt.year, dt.month, dt.day);

    // Only include logs inside this week window
    if (logDay.isBefore(start) || logDay.isAfter(end)) continue;

    final ml = log.totalMlConsumed ?? 0.0;
    totalMl += ml;

    // safe day = 0 drink day
    if (ml == 0) {
      streak++;
      if (streak > longestStreak) longestStreak = streak;
      safeDays++;
    } else {
      streak = 0; // reset on drinking day
    }
  }

// After the loop:
  final rawAvgPerDay = totalMl / 7.0;

// Option A: round to whole number
  final avgPerDay = rawAvgPerDay.round();

// (If you prefer 1 decimal place instead, use this instead of .round()):
// final avgPerDay = double.parse(rawAvgPerDay.toStringAsFixed(1));

  return {
    'total': totalMl, // still an int
    'average': avgPerDay, // now pretty
    'safeDays': safeDays,
    'safeStreak': longestStreak,
  };
}

int? ouncesToMl(double? ounces) {
  if (ounces == null || ounces == 0) {
    return 0;
  }
  return (ounces * 29.5735).toInt();
}

int? cupsToMl(double? cups) {
  if (cups == null || cups == 0) {
    return 0;
  }
  return (cups * 236.588).toInt();
}

int? toInt(double? drinkSize) {
  if (drinkSize == null || drinkSize == 0) {
    return 0;
  }
  return drinkSize.toInt();
}

int? drinkSizeStringToInt(String? drinkSize) {
  int? drinkSizeToMlInt(String? drinkSize) {
    if (drinkSize == null || drinkSize.isEmpty) return null;

    final input = drinkSize.trim().toLowerCase();

    // Match numeric value and unit (e.g., 750ml, 12oz)
    final match = RegExp(r'^([\d.]+)(ml|oz)$').firstMatch(input);
    if (match == null) return null;

    final value = double.tryParse(match.group(1)!);
    final unit = match.group(2);

    if (value == null) return null;

    double mlValue;
    if (unit == 'ml') {
      mlValue = value;
    } else {
      // oz → mL
      mlValue = value * 29.5735;
    }

    return mlValue.round(); // Integer result
  }
}
