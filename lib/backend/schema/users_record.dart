import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "gender" field.
  String? _gender;
  String get gender => _gender ?? '';
  bool hasGender() => _gender != null;

  // "location" field.
  String? _location;
  String get location => _location ?? '';
  bool hasLocation() => _location != null;

  // "drinking_frequency" field.
  String? _drinkingFrequency;
  String get drinkingFrequency => _drinkingFrequency ?? '';
  bool hasDrinkingFrequency() => _drinkingFrequency != null;

  // "usual_drink_type" field.
  String? _usualDrinkType;
  String get usualDrinkType => _usualDrinkType ?? '';
  bool hasUsualDrinkType() => _usualDrinkType != null;

  // "goals" field.
  String? _goals;
  String get goals => _goals ?? '';
  bool hasGoals() => _goals != null;

  // "hydration_preference" field.
  String? _hydrationPreference;
  String get hydrationPreference => _hydrationPreference ?? '';
  bool hasHydrationPreference() => _hydrationPreference != null;

  // "Rating" field.
  int? _rating;
  int get rating => _rating ?? 0;
  bool hasRating() => _rating != null;

  // "Rating_description" field.
  String? _ratingDescription;
  String get ratingDescription => _ratingDescription ?? '';
  bool hasRatingDescription() => _ratingDescription != null;

  // "weight_kg" field.
  int? _weightKg;
  int get weightKg => _weightKg ?? 0;
  bool hasWeightKg() => _weightKg != null;

  // "weight_lbs" field.
  int? _weightLbs;
  int get weightLbs => _weightLbs ?? 0;
  bool hasWeightLbs() => _weightLbs != null;

  // "heightfeet" field.
  int? _heightfeet;
  int get heightfeet => _heightfeet ?? 0;
  bool hasHeightfeet() => _heightfeet != null;

  // "height_cm" field.
  int? _heightCm;
  int get heightCm => _heightCm ?? 0;
  bool hasHeightCm() => _heightCm != null;

  // "height_in" field.
  int? _heightIn;
  int get heightIn => _heightIn ?? 0;
  bool hasHeightIn() => _heightIn != null;

  // "tolerance_level" field.
  double? _toleranceLevel;
  double get toleranceLevel => _toleranceLevel ?? 0.0;
  bool hasToleranceLevel() => _toleranceLevel != null;

  // "birthday" field.
  DateTime? _birthday;
  DateTime? get birthday => _birthday;
  bool hasBirthday() => _birthday != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _gender = snapshotData['gender'] as String?;
    _location = snapshotData['location'] as String?;
    _drinkingFrequency = snapshotData['drinking_frequency'] as String?;
    _usualDrinkType = snapshotData['usual_drink_type'] as String?;
    _goals = snapshotData['goals'] as String?;
    _hydrationPreference = snapshotData['hydration_preference'] as String?;
    _rating = castToType<int>(snapshotData['Rating']);
    _ratingDescription = snapshotData['Rating_description'] as String?;
    _weightKg = castToType<int>(snapshotData['weight_kg']);
    _weightLbs = castToType<int>(snapshotData['weight_lbs']);
    _heightfeet = castToType<int>(snapshotData['heightfeet']);
    _heightCm = castToType<int>(snapshotData['height_cm']);
    _heightIn = castToType<int>(snapshotData['height_in']);
    _toleranceLevel = castToType<double>(snapshotData['tolerance_level']);
    _birthday = snapshotData['birthday'] as DateTime?;
    _createdTime = snapshotData['created_time'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  String? phoneNumber,
  String? gender,
  String? location,
  String? drinkingFrequency,
  String? usualDrinkType,
  String? goals,
  String? hydrationPreference,
  int? rating,
  String? ratingDescription,
  int? weightKg,
  int? weightLbs,
  int? heightfeet,
  int? heightCm,
  int? heightIn,
  double? toleranceLevel,
  DateTime? birthday,
  DateTime? createdTime,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'phone_number': phoneNumber,
      'gender': gender,
      'location': location,
      'drinking_frequency': drinkingFrequency,
      'usual_drink_type': usualDrinkType,
      'goals': goals,
      'hydration_preference': hydrationPreference,
      'Rating': rating,
      'Rating_description': ratingDescription,
      'weight_kg': weightKg,
      'weight_lbs': weightLbs,
      'heightfeet': heightfeet,
      'height_cm': heightCm,
      'height_in': heightIn,
      'tolerance_level': toleranceLevel,
      'birthday': birthday,
      'created_time': createdTime,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.gender == e2?.gender &&
        e1?.location == e2?.location &&
        e1?.drinkingFrequency == e2?.drinkingFrequency &&
        e1?.usualDrinkType == e2?.usualDrinkType &&
        e1?.goals == e2?.goals &&
        e1?.hydrationPreference == e2?.hydrationPreference &&
        e1?.rating == e2?.rating &&
        e1?.ratingDescription == e2?.ratingDescription &&
        e1?.weightKg == e2?.weightKg &&
        e1?.weightLbs == e2?.weightLbs &&
        e1?.heightfeet == e2?.heightfeet &&
        e1?.heightCm == e2?.heightCm &&
        e1?.heightIn == e2?.heightIn &&
        e1?.toleranceLevel == e2?.toleranceLevel &&
        e1?.birthday == e2?.birthday &&
        e1?.createdTime == e2?.createdTime;
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.phoneNumber,
        e?.gender,
        e?.location,
        e?.drinkingFrequency,
        e?.usualDrinkType,
        e?.goals,
        e?.hydrationPreference,
        e?.rating,
        e?.ratingDescription,
        e?.weightKg,
        e?.weightLbs,
        e?.heightfeet,
        e?.heightCm,
        e?.heightIn,
        e?.toleranceLevel,
        e?.birthday,
        e?.createdTime
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
