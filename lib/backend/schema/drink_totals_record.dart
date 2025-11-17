import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DrinkTotalsRecord extends FirestoreRecord {
  DrinkTotalsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "count" field.
  int? _count;
  int get count => _count ?? 0;
  bool hasCount() => _count != null;

  // "ownerUid" field.
  String? _ownerUid;
  String get ownerUid => _ownerUid ?? '';
  bool hasOwnerUid() => _ownerUid != null;

  // "drinkKey" field.
  String? _drinkKey;
  String get drinkKey => _drinkKey ?? '';
  bool hasDrinkKey() => _drinkKey != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "size_ml" field.
  double? _sizeMl;
  double get sizeMl => _sizeMl ?? 0.0;
  bool hasSizeMl() => _sizeMl != null;

  // "lastAddedAt" field.
  DateTime? _lastAddedAt;
  DateTime? get lastAddedAt => _lastAddedAt;
  bool hasLastAddedAt() => _lastAddedAt != null;

  // "removed" field.
  bool? _removed;
  bool get removed => _removed ?? false;
  bool hasRemoved() => _removed != null;

  void _initializeFields() {
    _count = castToType<int>(snapshotData['count']);
    _ownerUid = snapshotData['ownerUid'] as String?;
    _drinkKey = snapshotData['drinkKey'] as String?;
    _name = snapshotData['name'] as String?;
    _sizeMl = castToType<double>(snapshotData['size_ml']);
    _lastAddedAt = snapshotData['lastAddedAt'] as DateTime?;
    _removed = snapshotData['removed'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('drinkTotals');

  static Stream<DrinkTotalsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => DrinkTotalsRecord.fromSnapshot(s));

  static Future<DrinkTotalsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => DrinkTotalsRecord.fromSnapshot(s));

  static DrinkTotalsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      DrinkTotalsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DrinkTotalsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DrinkTotalsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DrinkTotalsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DrinkTotalsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDrinkTotalsRecordData({
  int? count,
  String? ownerUid,
  String? drinkKey,
  String? name,
  double? sizeMl,
  DateTime? lastAddedAt,
  bool? removed,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'count': count,
      'ownerUid': ownerUid,
      'drinkKey': drinkKey,
      'name': name,
      'size_ml': sizeMl,
      'lastAddedAt': lastAddedAt,
      'removed': removed,
    }.withoutNulls,
  );

  return firestoreData;
}

class DrinkTotalsRecordDocumentEquality implements Equality<DrinkTotalsRecord> {
  const DrinkTotalsRecordDocumentEquality();

  @override
  bool equals(DrinkTotalsRecord? e1, DrinkTotalsRecord? e2) {
    return e1?.count == e2?.count &&
        e1?.ownerUid == e2?.ownerUid &&
        e1?.drinkKey == e2?.drinkKey &&
        e1?.name == e2?.name &&
        e1?.sizeMl == e2?.sizeMl &&
        e1?.lastAddedAt == e2?.lastAddedAt &&
        e1?.removed == e2?.removed;
  }

  @override
  int hash(DrinkTotalsRecord? e) => const ListEquality().hash([
        e?.count,
        e?.ownerUid,
        e?.drinkKey,
        e?.name,
        e?.sizeMl,
        e?.lastAddedAt,
        e?.removed
      ]);

  @override
  bool isValidKey(Object? o) => o is DrinkTotalsRecord;
}
