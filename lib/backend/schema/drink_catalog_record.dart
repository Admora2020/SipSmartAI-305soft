import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DrinkCatalogRecord extends FirestoreRecord {
  DrinkCatalogRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "barcode" field.
  String? _barcode;
  String get barcode => _barcode ?? '';
  bool hasBarcode() => _barcode != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "standardDrinks" field.
  int? _standardDrinks;
  int get standardDrinks => _standardDrinks ?? 0;
  bool hasStandardDrinks() => _standardDrinks != null;

  // "AlcoholPercent" field.
  int? _alcoholPercent;
  int get alcoholPercent => _alcoholPercent ?? 0;
  bool hasAlcoholPercent() => _alcoholPercent != null;

  // "VolumeML" field.
  int? _volumeML;
  int get volumeML => _volumeML ?? 0;
  bool hasVolumeML() => _volumeML != null;

  // "riskLevel" field.
  String? _riskLevel;
  String get riskLevel => _riskLevel ?? '';
  bool hasRiskLevel() => _riskLevel != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "ImageURL" field.
  String? _imageURL;
  String get imageURL => _imageURL ?? '';
  bool hasImageURL() => _imageURL != null;

  void _initializeFields() {
    _barcode = snapshotData['barcode'] as String?;
    _name = snapshotData['name'] as String?;
    _standardDrinks = castToType<int>(snapshotData['standardDrinks']);
    _alcoholPercent = castToType<int>(snapshotData['AlcoholPercent']);
    _volumeML = castToType<int>(snapshotData['VolumeML']);
    _riskLevel = snapshotData['riskLevel'] as String?;
    _description = snapshotData['description'] as String?;
    _imageURL = snapshotData['ImageURL'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('drinkCatalog');

  static Stream<DrinkCatalogRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => DrinkCatalogRecord.fromSnapshot(s));

  static Future<DrinkCatalogRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => DrinkCatalogRecord.fromSnapshot(s));

  static DrinkCatalogRecord fromSnapshot(DocumentSnapshot snapshot) =>
      DrinkCatalogRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DrinkCatalogRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DrinkCatalogRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DrinkCatalogRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DrinkCatalogRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDrinkCatalogRecordData({
  String? barcode,
  String? name,
  int? standardDrinks,
  int? alcoholPercent,
  int? volumeML,
  String? riskLevel,
  String? description,
  String? imageURL,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'barcode': barcode,
      'name': name,
      'standardDrinks': standardDrinks,
      'AlcoholPercent': alcoholPercent,
      'VolumeML': volumeML,
      'riskLevel': riskLevel,
      'description': description,
      'ImageURL': imageURL,
    }.withoutNulls,
  );

  return firestoreData;
}

class DrinkCatalogRecordDocumentEquality
    implements Equality<DrinkCatalogRecord> {
  const DrinkCatalogRecordDocumentEquality();

  @override
  bool equals(DrinkCatalogRecord? e1, DrinkCatalogRecord? e2) {
    return e1?.barcode == e2?.barcode &&
        e1?.name == e2?.name &&
        e1?.standardDrinks == e2?.standardDrinks &&
        e1?.alcoholPercent == e2?.alcoholPercent &&
        e1?.volumeML == e2?.volumeML &&
        e1?.riskLevel == e2?.riskLevel &&
        e1?.description == e2?.description &&
        e1?.imageURL == e2?.imageURL;
  }

  @override
  int hash(DrinkCatalogRecord? e) => const ListEquality().hash([
        e?.barcode,
        e?.name,
        e?.standardDrinks,
        e?.alcoholPercent,
        e?.volumeML,
        e?.riskLevel,
        e?.description,
        e?.imageURL
      ]);

  @override
  bool isValidKey(Object? o) => o is DrinkCatalogRecord;
}
