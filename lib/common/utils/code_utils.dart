import 'dart:convert';
import 'package:flutter_conch_plugin/annotation/patch_exclude.dart';

///isolate 的 compute 需要静态方法
@PatchExclude()
class CodeUtils {
  static List<dynamic> decodeListResult(String? data) {
    return json.decode(data!);
  }

  static Map<String, dynamic> decodeMapResult(String? data) {
    return json.decode(data!);
  }

  static String encodeToString(String? data) {
    return json.encode(data);
  }
}
