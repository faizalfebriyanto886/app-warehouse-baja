import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sologwarehouseapp/static/api_url.dart';
import 'package:sologwarehouseapp/static/app_information.dart';
import '../static/shared_preferences_key.dart';

class ApiServices {
  Future<Response> getData({
    required String url,
    Map<String, dynamic>? parameters,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String tokenType = preferences.getString(SharedPreferencesKey.tokenType)!;
    String accessToken =
        preferences.getString(SharedPreferencesKey.accessToken)!;
    String tokenTypeWithAccessToken = "$tokenType $accessToken";
    print(tokenTypeWithAccessToken);

    //initializing Dio
    Dio dio = Dio();

    //add header dio authorization
    dio.options.baseUrl = ApiUrl.baseUrl;
    dio.options.connectTimeout = AppInformation.connectTimeout;
    dio.options.receiveTimeout = AppInformation.receiveTimeout;
    dio.options.headers["Authorization"] = tokenTypeWithAccessToken;
    Response response = await dio.get(
      url,
      queryParameters:
          parameters == null || parameters.isEmpty ? {} : Map.from(parameters),
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 600;
        },
      ),
    );
    return response;
  }

  Future<Response> postData({
    required String url,
    required Map<String, dynamic> parameters,
    required bool isJson,
  }) async {
    //initializing Dio
    Dio dio = Dio();

    //initializing response
    Response response = await dio.post(
      url,
      data: isJson ? parameters : FormData.fromMap(parameters),
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 600;
        },
      ),
    );
    return response;
  }

  Future<Response> postDataParameter({
    required String url,
    Map<String, dynamic>? parameters,
  }) async {
    //initializing Dio
    Dio dio = Dio();

    //initializing response
    Response response = await dio.post(
      url,
      queryParameters: parameters,
    );
    return response;
  }

  Future<Response> postDataWithToken(
      {required String url,
      required Map<String, dynamic> parameters,
      required bool isJson}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String tokenType = preferences.getString(SharedPreferencesKey.tokenType)!;
    String accessToken =
        preferences.getString(SharedPreferencesKey.accessToken)!;
    String tokenTypeWithAccessToken = "$tokenType $accessToken";
    // print(tokenTypeWithAccessToken);

    //initializing Dio
    Dio dio = Dio();

    //add header dio authorization
    dio.options.baseUrl = ApiUrl.baseUrl;
    dio.options.connectTimeout = AppInformation.connectTimeout;
    dio.options.receiveTimeout = AppInformation.receiveTimeout;
    dio.options.headers["Authorization"] = tokenTypeWithAccessToken;

    //initializing response
    Response response = await dio.post(
      url,
      data: isJson ? parameters : FormData.fromMap(parameters),
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 600;
        },
      ),
    );
    return response;
  }

  Future<Response> putDataWithToken(
      {required String url,
      required Map<String, dynamic> parameters,
      required bool isJson}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String tokenType = preferences.getString(SharedPreferencesKey.tokenType)!;
    String accessToken =
        preferences.getString(SharedPreferencesKey.accessToken)!;
    String tokenTypeWithAccessToken = "$tokenType $accessToken";
    // print(tokenTypeWithAccessToken);

    //initializing Dio
    Dio dio = Dio();

    dio.options.baseUrl = ApiUrl.baseUrl;
    dio.options.connectTimeout = AppInformation.connectTimeout;
    dio.options.receiveTimeout = AppInformation.receiveTimeout;
    dio.options.headers["Authorization"] = tokenTypeWithAccessToken;

    //initializing response
    Response response = await dio.put(
      url,
      data: isJson ? parameters : FormData.fromMap(parameters),
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 600;
        },
      ),
    );
    return response;
  }
}
