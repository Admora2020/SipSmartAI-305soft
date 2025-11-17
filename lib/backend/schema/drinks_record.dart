import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DrinksRecord extends FirestoreRecord {
  DrinksRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "drink_name" field.
  String? _drinkName;
  String get drinkName => _drinkName ?? '';
  bool hasDrinkName() => _drinkName != null;

  // "drink_size" field.
  double? _drinkSize;
  double get drinkSize => _drinkSize ?? 0.0;
  bool hasDrinkSize() => _drinkSize != null;

  // "counter" field.
  int? _counter;
  int get counter => _counter ?? 0;
  bool hasCounter() => _counter != null;

  // "currentTime" field.
  DateTime? _currentTime;
  DateTime? get currentTime => _currentTime;
  bool hasCurrentTime() => _currentTime != null;

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  bool hasUser() => _user != null;

  // "removed" field.
  bool? _removed;
  bool get removed => _removed ?? false;
  bool hasRemoved() => _removed != null;

  void _initializeFields() {
    _drinkName = snapshotData['drink_name'] as String?;
    _drinkSize = castToType<double>(snapshotData['drink_size']);
    _counter = castToType<int>(snapshotData['counter']);
    _currentTime = snapshotData['currentTime'] as DateTime?;
    _user = snapshotData['user'] as DocumentReference?;
    _removed = snapshotData['removed'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('drinks');

  static Stream<DrinksRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => DrinksRecord.fromSnapshot(s));

  static Future<DrinksRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => DrinksRecord.fromSnapshot(s));

  static DrinksRecord fromSnapshot(DocumentSnapshot snapshot) => DrinksRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DrinksRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DrinksRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DrinksRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DrinksRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDrinksRecordData({
  String? drinkName,
  double? drinkSize,
  int? counter,
  DateTime? currentTime,
  DocumentReference? user,
  bool? removed,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'drink_name': drinkName,
      'drink_size': drinkSize,
      'counter': counter,
      'currentTime': currentTime,
      'user': user,
      'removed': removed,
    }.withoutNulls,
  );

  return firestoreData;
}

class DrinksRecordDocumentEquality implements Equality<DrinksRecord> {
  const DrinksRecordDocumentEquality();

  @override
  bool equals(DrinksRecord? e1, DrinksRecord? e2) {
    return e1?.drinkName == e2?.drinkName &&
        e1?.drinkSize == e2?.drinkSize &&
        e1?.counter == e2?.counter &&
        e1?.currentTime == e2?.currentTime &&
        e1?.user == e2?.user &&
        e1?.removed == e2?.removed;
  }

  @override
  int hash(DrinksRecord? e) => const ListEquality().hash([
        e?.drinkName,
        e?.drinkSize,
        e?.counter,
        e?.currentTime,
        e?.user,
        e?.removed
      ]);

  @override
  bool isValidKey(Object? o) => o is DrinksRecord;
}
