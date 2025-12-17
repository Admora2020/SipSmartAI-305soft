import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DailyLogsRecord extends FirestoreRecord {
  DailyLogsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "userRef" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "total_drinks" field.
  int? _totalDrinks;
  int get totalDrinks => _totalDrinks ?? 0;
  bool hasTotalDrinks() => _totalDrinks != null;

  // "max_bac" field.
  double? _maxBac;
  double get maxBac => _maxBac ?? 0.0;
  bool hasMaxBac() => _maxBac != null;

  // "within_safe_limit" field.
  bool? _withinSafeLimit;
  bool get withinSafeLimit => _withinSafeLimit ?? false;
  bool hasWithinSafeLimit() => _withinSafeLimit != null;

  // "smart_points" field.
  int? _smartPoints;
  int get smartPoints => _smartPoints ?? 0;
  bool hasSmartPoints() => _smartPoints != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "total_ml_consumed" field.
  double? _totalMlConsumed;
  double get totalMlConsumed => _totalMlConsumed ?? 0.0;
  bool hasTotalMlConsumed() => _totalMlConsumed != null;

  // "highest_ml_day" field.
  bool? _highestMlDay;
  bool get highestMlDay => _highestMlDay ?? false;
  bool hasHighestMlDay() => _highestMlDay != null;

  // "safe_day" field.
  bool? _safeDay;
  bool get safeDay => _safeDay ?? false;
  bool hasSafeDay() => _safeDay != null;

  // "streak_count" field.
  int? _streakCount;
  int get streakCount => _streakCount ?? 0;
  bool hasStreakCount() => _streakCount != null;

  void _initializeFields() {
    _userRef = snapshotData['userRef'] as DocumentReference?;
    _date = snapshotData['date'] as DateTime?;
    _totalDrinks = castToType<int>(snapshotData['total_drinks']);
    _maxBac = castToType<double>(snapshotData['max_bac']);
    _withinSafeLimit = snapshotData['within_safe_limit'] as bool?;
    _smartPoints = castToType<int>(snapshotData['smart_points']);
    _createdTime = snapshotData['created_time'] as DateTime?;
    _totalMlConsumed = castToType<double>(snapshotData['total_ml_consumed']);
    _highestMlDay = snapshotData['highest_ml_day'] as bool?;
    _safeDay = snapshotData['safe_day'] as bool?;
    _streakCount = castToType<int>(snapshotData['streak_count']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('dailyLogs');

  static Stream<DailyLogsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => DailyLogsRecord.fromSnapshot(s));

  static Future<DailyLogsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => DailyLogsRecord.fromSnapshot(s));

  static DailyLogsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      DailyLogsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DailyLogsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DailyLogsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DailyLogsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DailyLogsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDailyLogsRecordData({
  DocumentReference? userRef,
  DateTime? date,
  int? totalDrinks,
  double? maxBac,
  bool? withinSafeLimit,
  int? smartPoints,
  DateTime? createdTime,
  double? totalMlConsumed,
  bool? highestMlDay,
  bool? safeDay,
  int? streakCount,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'userRef': userRef,
      'date': date,
      'total_drinks': totalDrinks,
      'max_bac': maxBac,
      'within_safe_limit': withinSafeLimit,
      'smart_points': smartPoints,
      'created_time': createdTime,
      'total_ml_consumed': totalMlConsumed,
      'highest_ml_day': highestMlDay,
      'safe_day': safeDay,
      'streak_count': streakCount,
    }.withoutNulls,
  );

  return firestoreData;
}

class DailyLogsRecordDocumentEquality implements Equality<DailyLogsRecord> {
  const DailyLogsRecordDocumentEquality();

  @override
  bool equals(DailyLogsRecord? e1, DailyLogsRecord? e2) {
    return e1?.userRef == e2?.userRef &&
        e1?.date == e2?.date &&
        e1?.totalDrinks == e2?.totalDrinks &&
        e1?.maxBac == e2?.maxBac &&
        e1?.withinSafeLimit == e2?.withinSafeLimit &&
        e1?.smartPoints == e2?.smartPoints &&
        e1?.createdTime == e2?.createdTime &&
        e1?.totalMlConsumed == e2?.totalMlConsumed &&
        e1?.highestMlDay == e2?.highestMlDay &&
        e1?.safeDay == e2?.safeDay &&
        e1?.streakCount == e2?.streakCount;
  }

  @override
  int hash(DailyLogsRecord? e) => const ListEquality().hash([
        e?.userRef,
        e?.date,
        e?.totalDrinks,
        e?.maxBac,
        e?.withinSafeLimit,
        e?.smartPoints,
        e?.createdTime,
        e?.totalMlConsumed,
        e?.highestMlDay,
        e?.safeDay,
        e?.streakCount
      ]);

  @override
  bool isValidKey(Object? o) => o is DailyLogsRecord;
}
