import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'dart:html';

Future<void> saveToLocalStorage(String key, String value) async {
  try {
    final Storage local = window.localStorage;

    local[key] = value;
  } catch (e) {
    if (kDebugMode) {
      log("error occurred");
      log(e.toString());
    }
  }
}

Future<dynamic> getKeyFromLocalStorage(String key) async {
  try {
    final Storage local = window.localStorage;
    var value = local[key];

    return value;
  } catch (e) {
    if (kDebugMode) {
      log("error occurred");
      log(e.toString());
    }
  }
}
