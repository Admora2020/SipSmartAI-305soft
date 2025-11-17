import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SurveyreponseRecord extends FirestoreRecord {
  SurveyreponseRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "rating" field.
  int? _rating;
  int get rating => _rating ?? 0;
  bool hasRating() => _rating != null;

  // "ratin_des" field.
  String? _ratinDes;
  String get ratinDes => _ratinDes ?? '';
  bool hasRatinDes() => _ratinDes != null;

  // "rating_back" field.
  int? _ratingBack;
  int get ratingBack => _ratingBack ?? 0;
  bool hasRatingBack() => _ratingBack != null;

  // "ratin_back2" field.
  int? _ratinBack2;
  int get ratinBack2 => _ratinBack2 ?? 0;
  bool hasRatinBack2() => _ratinBack2 != null;

  // "rating_back3" field.
  int? _ratingBack3;
  int get ratingBack3 => _ratingBack3 ?? 0;
  bool hasRatingBack3() => _ratingBack3 != null;

  // "rating_back4" field.
  int? _ratingBack4;
  int get ratingBack4 => _ratingBack4 ?? 0;
  bool hasRatingBack4() => _ratingBack4 != null;

  void _initializeFields() {
    _rating = castToType<int>(snapshotData['rating']);
    _ratinDes = snapshotData['ratin_des'] as String?;
    _ratingBack = castToType<int>(snapshotData['rating_back']);
    _ratinBack2 = castToType<int>(snapshotData['ratin_back2']);
    _ratingBack3 = castToType<int>(snapshotData['rating_back3']);
    _ratingBack4 = castToType<int>(snapshotData['rating_back4']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('surveyreponse');

  static Stream<SurveyreponseRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SurveyreponseRecord.fromSnapshot(s));

  static Future<SurveyreponseRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SurveyreponseRecord.fromSnapshot(s));

  static SurveyreponseRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SurveyreponseRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SurveyreponseRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SurveyreponseRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SurveyreponseRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SurveyreponseRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSurveyreponseRecordData({
  int? rating,
  String? ratinDes,
  int? ratingBack,
  int? ratinBack2,
  int? ratingBack3,
  int? ratingBack4,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'rating': rating,
      'ratin_des': ratinDes,
      'rating_back': ratingBack,
      'ratin_back2': ratinBack2,
      'rating_back3': ratingBack3,
      'rating_back4': ratingBack4,
    }.withoutNulls,
  );

  return firestoreData;
}

class SurveyreponseRecordDocumentEquality
    implements Equality<SurveyreponseRecord> {
  const SurveyreponseRecordDocumentEquality();

  @override
  bool equals(SurveyreponseRecord? e1, SurveyreponseRecord? e2) {
    return e1?.rating == e2?.rating &&
        e1?.ratinDes == e2?.ratinDes &&
        e1?.ratingBack == e2?.ratingBack &&
        e1?.ratinBack2 == e2?.ratinBack2 &&
        e1?.ratingBack3 == e2?.ratingBack3 &&
        e1?.ratingBack4 == e2?.ratingBack4;
  }

  @override
  int hash(SurveyreponseRecord? e) => const ListEquality().hash([
        e?.rating,
        e?.ratinDes,
        e?.ratingBack,
        e?.ratinBack2,
        e?.ratingBack3,
        e?.ratingBack4
      ]);

  @override
  bool isValidKey(Object? o) => o is SurveyreponseRecord;
}
