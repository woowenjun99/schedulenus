import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:schedulenus/src/env.dart';

part 'my_dio.g.dart';

@Riverpod(keepAlive: true)
Dio dio(ref) {
  return Dio(BaseOptions(
    baseUrl: Env.serverUrl,
    contentType: "application/json",
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
  ));
}
