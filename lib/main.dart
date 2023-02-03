import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_conch_plugin/annotation/conch_scope.dart';
import 'package:flutter_conch_plugin/conch_dispatch.dart';
import 'package:gsy_github_app_flutter/app.dart';
import 'package:gsy_github_app_flutter/env/config_wrapper.dart';
import 'package:gsy_github_app_flutter/env/env_config.dart';
import 'package:gsy_github_app_flutter/page/error_page.dart';

import 'env/dev.dart';

bool useConch = true;

@ConchScope()
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (useConch) {
    var source = await rootBundle.load('static/conch_build/patch_dat/conch_result.dat');
    ConchDispatch.instance.loadByteSource(source);
    // ConchDispatch.instance.setLogger(LogLevel.Debug);
    ConchDispatch.instance.callStaticFun(library: 'package:gsy_github_app_flutter/main.dart', funcName: 'mainInner');
    return;
  }

  mainInner();
}

mainInner() {
  runZonedGuarded(() {
    ErrorWidget.builder = (FlutterErrorDetails details) {
      Zone.current.handleUncaughtError(details.exception, details.stack!);

      ///此处仅为展示，正规的实现方式参考 _defaultErrorWidgetBuilder 通过自定义 RenderErrorBox 实现
      return ErrorPage(details.exception.toString() + "\n " + details.stack.toString(), details);
    };
    runApp(ConfigWrapper(
      child: FlutterReduxApp(),
      config: EnvConfig.fromJson(config),
    ));

    ///屏幕刷新率和显示率不一致时的优化，必须挪动到 runApp 之后
    GestureBinding.instance.resamplingEnabled = true;
  }, (Object obj, StackTrace stack) {
    print(obj);
    print(stack);
  });
}
