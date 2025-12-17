import 'package:flutter/material.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  double _totalMl = 0.0;
  double get totalMl => _totalMl;
  set totalMl(double value) {
    _totalMl = value;
  }

  int _lastDrinkTimeStampMs = 0;
  int get lastDrinkTimeStampMs => _lastDrinkTimeStampMs;
  set lastDrinkTimeStampMs(int value) {
    _lastDrinkTimeStampMs = value;
  }

  double _currentBAC = 0.0;
  double get currentBAC => _currentBAC;
  set currentBAC(double value) {
    _currentBAC = value;
  }

  double _bacRatio = 0.0;
  double get bacRatio => _bacRatio;
  set bacRatio(double value) {
    _bacRatio = value;
  }

  double _ratioMl = 0.0;
  double get ratioMl => _ratioMl;
  set ratioMl(double value) {
    _ratioMl = value;
  }

  bool _backgroundBlur = false;
  bool get backgroundBlur => _backgroundBlur;
  set backgroundBlur(bool value) {
    _backgroundBlur = value;
  }

  String _drinkName = '';
  String get drinkName => _drinkName;
  set drinkName(String value) {
    _drinkName = value;
  }

  String _drinkBrand = '';
  String get drinkBrand => _drinkBrand;
  set drinkBrand(String value) {
    _drinkBrand = value;
  }

  String _drinkDescription = '';
  String get drinkDescription => _drinkDescription;
  set drinkDescription(String value) {
    _drinkDescription = value;
  }

  String _imageURL = '';
  String get imageURL => _imageURL;
  set imageURL(String value) {
    _imageURL = value;
  }

  String _drinkABV = '';
  String get drinkABV => _drinkABV;
  set drinkABV(String value) {
    _drinkABV = value;
  }

  String _drinkSize = '';
  String get drinkSize => _drinkSize;
  set drinkSize(String value) {
    _drinkSize = value;
  }
}
