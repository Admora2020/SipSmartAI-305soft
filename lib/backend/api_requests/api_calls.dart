import 'dart:convert';
import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class BarcodeInfoFetchCall {
  static Future<ApiCallResponse> call({
    String? barcode = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'BarcodeInfoFetch',
      apiUrl: 'https://api.barcodelookup.com/v3/products',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'barcode': barcode,
        'formatted': "y",
        'key': "86p43psw86hhnp381i5fi0kk5xfovl",
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? title(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.products[:].title''',
      ));
  static String? brand(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.products[:].brand''',
      ));
  static String? description(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.products[:].description''',
      ));
  static List<String>? images(dynamic response) => (getJsonField(
        response,
        r'''$.products[:].images''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static String? barcodenumber(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.products[:].barcode_number''',
      ));
  static String? manufacturer(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.products[:].manufacturer''',
      ));
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
