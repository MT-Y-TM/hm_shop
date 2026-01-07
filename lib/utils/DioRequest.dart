import 'package:dio/dio.dart';
import 'package:hm_shop/contants/index.dart';

class Diorequest {
  final _dio = Dio();
  Diorequest() {
    _dio.options
      ..baseUrl = GlobalConstans.BASE_URL
      ..connectTimeout = Duration(seconds: GlobalConstans.TIME_OUT)
      ..sendTimeout = Duration(seconds: GlobalConstans.TIME_OUT)
      ..receiveTimeout = Duration(seconds: GlobalConstans.TIME_OUT);

    //拦截器
    _addInterceptor();
  }
  void _addInterceptor() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          handler.next(options);
        },
        onResponse: (response, handler) {
          if (response.statusCode! >= 200 && response.statusCode! < 300) {
            handler.next(response);
            return;
          }
          handler.reject(DioException(requestOptions: response.requestOptions));
        },
        onError: (error, handler) {
          handler.reject(
            DioException(
              requestOptions: error.requestOptions,
              message: error.response?.data["msg"] ?? "",
            ),
          );
        },
      ),
    );
  }

  get(String url, {Map<String, dynamic>? params}) {
    return _hanldResponse(_dio.get(url, queryParameters: params));
  }

  Future<dynamic> post(String url, {Map<String, dynamic>? data}) {
    return _hanldResponse(_dio.post(url, data: data));
  }

  //进一步处理返回结果
  //把所有的data的业务状态码提出来
  Future<dynamic> _hanldResponse(Future<Response<dynamic>> task) async {
    try {
      Response<dynamic> res = await task;
      final data = res.data as Map<String, dynamic>;
      //业务成功就返回result数据
      if (data["code"] == GlobalConstans.SUCCESS_CODE) {
        return data["result"];
      }
      throw DioException(
        requestOptions: res.requestOptions,
        message: data["msg"] ?? "数据加载异常",
      );
    } catch (e) {
      rethrow; //不改变原来的输出
    }
  }
}

// 单例对象
final dioRequest = Diorequest();
