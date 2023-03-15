import 'package:dio/dio.dart';
import 'package:flutter_conch_plugin/annotation/patch_exclude.dart';

/**
 * header拦截器
 * Created by guoshuyu
 * on 2019/3/23.
 */
@PatchExclude()
class HeaderInterceptors extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options, handler) async {
    ///超时
    options.connectTimeout = 30000;
    options.receiveTimeout = 30000;

    return super.onRequest(options, handler);
  }
}
