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
          }
        },
        onError: (error, handler) {
          handler.reject(error);
        },
      ),
    );
  }

  get(String url, {Map<String, dynamic>? params}) {
    return _hanldResponse(_dio.get(url, queryParameters: params));
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
      throw Exception(data["msg"]);
    } catch (e) {
      throw Exception(e);
    }
  }
}

// 单例对象
final dioRequest = Diorequest();
