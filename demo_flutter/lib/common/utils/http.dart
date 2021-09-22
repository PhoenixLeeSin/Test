import 'dart:convert';

import 'package:cookie_jar/cookie_jar.dart';

/// 创建时间：2021/8/20
/// 作者：liguicheng
/// 描述：网络请求封装
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:demo_flutter/common/models/user.dart';
import 'package:demo_flutter/common/utils/storage.dart';
import '../values/server.dart';
import '../values/values.dart';

class HttpUtil {
  static HttpUtil _instance = HttpUtil._internal();
  factory HttpUtil() => _instance;

  late Dio dio;
  CancelToken cancelToken = new CancelToken();

  HttpUtil._internal() {
    BaseOptions options = new BaseOptions(
        baseUrl: SERVER_API_URL,

        //连接服务器超时时间，单位是毫秒.
        connectTimeout: 10000,

        // 响应流上前后两次接受到数据的间隔，单位为毫秒。
        receiveTimeout: 5000,

        // Http请求头.
        headers: {},

        /// 请求的Content-Type，默认值是"application/json; charset=utf-8".
        /// 如果您想以"application/x-www-form-urlencoded"格式编码请求数据,
        /// 可以设置此选项为 `Headers.formUrlEncodedContentType`,  这样[Dio]
        /// 就会自动编码请求体.
        contentType: 'application/json; charset=utf-8',

        /// [responseType] 表示期望以那种格式(方式)接受响应数据。
        /// 目前 [ResponseType] 接受三种类型 `JSON`, `STREAM`, `PLAIN`.
        ///
        /// 默认值是 `JSON`, 当响应头中content-type为"application/json"时，dio 会自动将响应内容转化为json对象。
        /// 如果想以二进制方式接受响应数据，如下载一个二进制文件，那么可以使用 `STREAM`.
        ///
        /// 如果想以文本(字符串)格式接收响应数据，请使用 `PLAIN`.
        responseType: ResponseType.json);

    dio = new Dio(options);

    //Cookie管理
    CookieJar cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));

    // 添加拦截器
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      return handler.next(options);
      // 如果你想完成请求并返回一些自定义数据，你可以resolve一个Response对象 `handler.resolve(response)`。
      // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义response.
      //
      // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象,如`handler.reject(error)`，
      // 这样请求将被中止并触发异常，上层catchError会被调用。
    }, onResponse: (response, handler) {
      return handler.next(response);
      // 如果你想终止请求并触发一个错误,你可以 reject 一个`DioError`对象,如`handler.reject(error)`，
      // 这样请求将被中止并触发异常，上层catchError会被调用。
    }, onError: (DioError e, handler) {
      ErrorEntity eInfo = createErrorEntity(e);
      switch (eInfo.code) {
        case 401: // 没有权限 重新登录
          // goLoginPage(context);
          break;
        default:
      }
      return handler.next(e);
      // 如果你想完成请求并返回一些自定义数据，可以resolve 一个`Response`,如`handler.resolve(response)`。
      // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义response.
    }));
  }

/*
   * error统一处理
   */
// 错误信息
  ErrorEntity createErrorEntity(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        return ErrorEntity(code: -1, message: "请求取消");
      case DioErrorType.connectTimeout:
        return ErrorEntity(code: -1, message: "连接超时");
      case DioErrorType.sendTimeout:
        return ErrorEntity(code: -1, message: "请求超时");
      case DioErrorType.receiveTimeout:
        return ErrorEntity(code: -1, message: "响应超时");
      case DioErrorType.response:
        {
          try {
            int? errCode = error.response?.statusCode;
            switch (errCode) {
              case 400:
                return ErrorEntity(code: errCode, message: "请求语法错误");
              case 401:
                return ErrorEntity(code: errCode, message: "没有权限");
              case 403:
                return ErrorEntity(code: errCode, message: "服务器拒绝执行");
              case 404:
                return ErrorEntity(code: errCode, message: "无法连接服务器");
              case 405:
                return ErrorEntity(code: errCode, message: "请求方法被禁止");
              case 500:
                return ErrorEntity(code: errCode, message: "服务器内部错误");
              case 502:
                return ErrorEntity(code: errCode, message: "无效的请求");
              case 503:
                return ErrorEntity(code: errCode, message: "服务器挂了");
              case 505:
                return ErrorEntity(code: errCode, message: "不支持HTTP协议请求");
              default:
                return ErrorEntity(
                    code: errCode, message: error.response?.statusMessage);
            }
          } on Exception catch (e) {
            return ErrorEntity(code: -1, message: '未知错误');
          }
        }
      default:
        {
          return ErrorEntity(code: -1, message: error.message);
        }
    }
  }

/*
   * 取消请求
   *
   * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   * 所以参数可选
   */

  void cancelRequest(CancelToken token) {
    token.cancel('cancelled');
  }

  /// 读取本地配置
  Map<String, dynamic>? getAuthorizationHeader() {
    Map<String, dynamic>? map = StorageUtil().getJSON(USERKEY);
    if (map != null) {
      User user = User.fromJson(map);
      return {"Authorization": "Bear ${user.result?.accessToken}"};
    }
    return null;
  }

  /// restful get 操作
  /// refresh 是否下拉刷新 默认 false
  /// noCache 是否不缓存 默认 true
  /// list 是否列表 默认 false
  /// cacheKey 缓存key
  /// cacheDisk 是否磁盘缓存
  Future get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool refresh = false,
    bool noCache = !CACHE_ENABLE,
    bool list = false,
    String cacheKey = '',
    bool cacheDisk = false,
  }) async {
    Options requestOptions = options ?? Options();
    if (requestOptions.extra == null) {
      requestOptions.extra = Map();
    }
    requestOptions.extra!.addAll({
      "refresh": refresh,
      "noCache": noCache,
      "list": list,
      "cacheKey": cacheKey,
      "cacheDisk": cacheDisk,
    });
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers = {};
      requestOptions.headers!.addAll(authorization);
    }

    var response = await dio.get(path,
        queryParameters: getCommonBody(queryParameters),
        options: requestOptions,
        cancelToken: cancelToken);
    return response.data;
  }

  /// restful post 操作
  Future post(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options}) async {
    Options requestOptions = options ?? Options();
    Map<String, dynamic>? authorization = getAuthorizationHeader();

    if (authorization != null) {
      requestOptions.headers = {};
      requestOptions.headers!.addAll(authorization);
    }

    var response = await dio.post(path,
        data: data,
        queryParameters: getCommonBody(queryParameters),
        options: requestOptions,
        cancelToken: cancelToken);
    return response.data;
  }
}

// 异常处理
class ErrorEntity implements Exception {
  int? code;
  String? message;
  ErrorEntity({this.code, this.message});

  String toString() {
    if (message == null) return 'Exception';
    return "Exception: code $code, $message";
  }
}

///获取body公共参数 appInfo
Map<String, dynamic>? getCommonBody(Map<String, dynamic>? params) {
  Map<String, dynamic>? map = {
    "appInfo": {
      "deviceId": "ea399c4d6b60101086c764e77778ee98e0940062",
      "machineModel": "iPhone XR",
      "appVersion": "5.5.0",
      "sourceSystem": "0",
      "bundleId": "com.bsit.coband",
      "systemVersion": "14.7.1",
      "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
      "clientId": "bjqd"
    }
  };
  map.addAll(params ?? {});

  return map;
}
