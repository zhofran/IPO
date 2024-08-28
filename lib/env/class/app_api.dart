part of '../class/app_env.dart';

class AppApi {
  // production / live
  static const String baseURL = 'https://service.tandycom.online/api';
  static const String imageURL = 'https://service.tandycom.online/storage';

  // staging / dev
  static const String eBaseURL = 'https://api-elinet.edoindo.com/api';
  static const String vBaseURL = 'https://veea-tandi.edoindo.com/api';
  // static const String eBaseURL = 'http://192.168.1.74:8000/api';
  // static const String baseURL = 'https://staging.tandycom.online/api';
  // static const String imageURL = 'https://staging.tandycom.online/storage';

  static Future<bool> keepVeeaToken({required String veeaToken}) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.setString("veea_token", veeaToken);
  }

  static Future<String?> getVeeaToken() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.getString("veea_token");
  }

  static Future<bool> keepElinetToken(
      {required String elinetToken, required String idUser}) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setString('id_user', idUser);
    return storage.setString("access_token", elinetToken);
  }

  static Future<String?> getAccessToken() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.getString("access_token");
  }

  static Future<bool> keepToken({
    required String token,
    required String nik,
    required String password,
  }) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setString('nik', nik);
    storage.setString('password', password);
    return storage.setString("token", token);
  }

  static Future<bool> removeToken() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.remove("nik");
    storage.remove("password");
    storage.remove("access_token");
    Response response = await AppApi.post(path: '/logout');

    log('logout : ${response.data}', name: 'AppApi');

    return storage.remove("token");
  }

  static Future<bool> removeTokenElinet() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.remove('access_token');
  }

  static Future<bool> removeTokenVeea() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.remove('veea_token');
  }

  static setAuth({required String value}) async {
    (await SharedPreferences.getInstance())
        .setString('DATA_CURRENT_USER', value);
  }

  static Future getCurrentUser() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String? currentAuth = storage.getString("DATA_CURRENT_USER");
    // log('curAuth : $currentAuth');
    return UserModel.fromJson(
      jsonDecode(
        currentAuth ??
            '{"id": "","name": "","email": ","nik": "","email_verified_at": "0000-00-00","referral_code": "","created_at": "0000-00-00","updated_at": "0000-00-00","deleted_at": "0000-00-00}',
      ),
    );
  }

  static Future getCurrentUserApi() async {
    try {
      Response response = await AppApi.get(path: '/me');

      log('response : $response', name: 'getCurrentUserApi-AppApi');

      if (response.statusCode == 200) {
        // save data user
        UserModel dataCurrentUser =
            UserModel.fromJson(response.data['data'] ?? {});

        await AppApi.setAuth(value: jsonEncode(dataCurrentUser));

        return dataCurrentUser;
      }
    } catch (e) {
      log('err : $e', name: 'getCurrentUserApi');
    }
    return AppApi.getCurrentUser();
  }

  // static Future<Response<dynamic>?> getHistoryProduct(
  //     {required String product, int page = 1}) async {
  //   // List<HistoryTransactionData> historyModels = [];
  //   try {
  //     Response response = await AppApi.get(
  //       path: '/ppob/shortcut',
  //       param: {
  //         "category": 'PPOB',
  //         "product": product,
  //         "page": page,
  //         "limit": 5,
  //       },
  //     );

  //     log('response : $response', name: 'getHistoryProduct');

  //     if (response.statusCode == 200) {
  //       // historyModels = (response.data['data']['data'] as List? ?? [])
  //       //     .map((e) => HistoryTransactionData.fromJson(e))
  //       //     .toList();
  //       return response;
  //     }
  //   } catch (e) {
  //     log('err : $e', name: 'getCurrentUserApi');
  //   }

  //   return null;
  // }

  static Future get<T extends Object>(
      {required String path,
      bool withToken = true,
      Map<String, dynamic>? param}) async {
    if (withToken) {
      SharedPreferences storage = await SharedPreferences.getInstance();
      String? token = storage.getString("token");
      // log('token : $token', name: 'AppApi');
      try {
        final response = await Dio().get<T>(
          baseURL + path,
          queryParameters: param,
          options: Options(
            headers: {
              "Authorization": "Bearer ${token!}",
              "Accept": "application/json"
            },
            // receiveTimeout: AppConstant.timeout,
            // sendTimeout: AppConstant.timeout,
          ),
        );
        return _returnResponse(response);
      } on DioError catch (e) {
        if (e.response!.statusCode! >= 500) {
          return _returnResponse(e.response!);
        } else {
          return e.response!;
        }
      }
    } else {
      try {
        final response = await Dio().get<T>(
          baseURL + path,
          queryParameters: param,
          options: Options(
            headers: {
              "Accept": "application/json",
            },
            // receiveTimeout: AppConstant.timeout,
            // sendTimeout: AppConstant.timeout,
          ),
        );
        return _returnResponse(response);
      } on DioError catch (e) {
        return _returnResponse(e.response!);
      }
    }
  }

  static Future eGet<T extends Object>(
      {required String path,
      bool withToken = true,
      Map<String, dynamic>? param}) async {
    if (withToken) {
      SharedPreferences storage = await SharedPreferences.getInstance();
      String? token = storage.getString("access_token");
      // log('token : $token', name: 'AppApi');
      try {
        final response = await Dio().get<T>(
          eBaseURL + path,
          queryParameters: param,
          options: Options(
            headers: {
              "Authorization": "Bearer ${token!}",
              "Accept": "application/json"
            },
            // receiveTimeout: AppConstant.timeout,
            // sendTimeout: AppConstant.timeout,
          ),
        );
        return _returnResponse(response);
      } on DioError catch (e) {
        if (e.response!.statusCode! >= 500) {
          return _returnResponse(e.response!);
        } else {
          return e.response!;
        }
      }
    } else {
      try {
        final response = await Dio().get<T>(
          eBaseURL + path,
          queryParameters: param,
          options: Options(
            headers: {
              "Accept": "application/json",
            },
            // receiveTimeout: AppConstant.timeout,
            // sendTimeout: AppConstant.timeout,
          ),
        );
        return _returnResponse(response);
      } on DioError catch (e) {
        return _returnResponse(e.response!);
      }
    }
  }

  static Future ePost<T extends Object>(
      {required String path,
      bool withToken = true,
      int minute = 1,
      dynamic formdata,
      Map<String, dynamic>? param}) async {
    log('start', name: 'AppApi-post');
    if (withToken) {
      SharedPreferences storage = await SharedPreferences.getInstance();
      String? token = storage.getString("access_token");
      // log('token : $token', name: 'AppApi');
      try {
        final response = await Dio().post<T>(eBaseURL + path,
            queryParameters: param,
            options: Options(
              receiveDataWhenStatusError: true,
              headers: {
                "Authorization": "Bearer ${token!}",
                "Accept": "application/json"
              },
              // receiveTimeout: AppConstant.timeout,
              // sendTimeout: AppConstant.timeout,
            ),
            data: formdata);
        return _returnResponse(response);
      } on DioError catch (e) {
        if (e.response!.statusCode! >= 500) {
          return _returnResponse(e.response!);
        } else {
          return e.response;
        }
      }
    } else {
      try {
        log('try', name: 'AppApi-post');
        final response = await Dio().post<T>(
          eBaseURL + path,
          data: formdata,
          options: Options(
            receiveDataWhenStatusError: true,
            headers: {
              "Accept": "application/json",
            },
            // receiveTimeout: AppConstant.timeout,
            // sendTimeout: AppConstant.timeout,
          ),
        );

        log('response : $response', name: 'AppApi-post');

        return _returnResponse(response);
      } on DioError catch (e) {
        if (e.response!.statusCode! >= 500) {
          return _returnResponse(e.response!);
        } else {
          return e.response;
        }
      }
    }
  }

  static Future post<T extends Object>(
      {required String path,
      bool withToken = true,
      int minute = 1,
      dynamic formdata,
      Map<String, dynamic>? param}) async {
    log('start', name: 'AppApi-post');
    if (withToken) {
      SharedPreferences storage = await SharedPreferences.getInstance();
      String? token = storage.getString("token");
      // log('token : $token', name: 'AppApi');
      try {
        final response = await Dio().post<T>(baseURL + path,
            queryParameters: param,
            options: Options(
              receiveDataWhenStatusError: true,
              headers: {
                "Authorization": "Bearer ${token!}",
                "Accept": "application/json"
              },
              // receiveTimeout: AppConstant.timeout,
              // sendTimeout: AppConstant.timeout,
            ),
            data: formdata);
        return _returnResponse(response);
      } on DioError catch (e) {
        if (e.response!.statusCode! >= 500) {
          return _returnResponse(e.response!);
        } else {
          return e.response;
        }
      }
    } else {
      try {
        log('try', name: 'AppApi-post');
        final response = await Dio().post<T>(
          baseURL + path,
          data: formdata,
          options: Options(
            receiveDataWhenStatusError: true,
            headers: {
              "Accept": "application/json",
            },
            // receiveTimeout: AppConstant.timeout,
            // sendTimeout: AppConstant.timeout,
          ),
        );

        log('response : $response', name: 'AppApi-post');

        return _returnResponse(response);
      } on DioError catch (e) {
        if (e.response!.statusCode! >= 500) {
          return _returnResponse(e.response!);
        } else {
          return e.response;
        }
      }
    }
  }

  static Future put<T extends Object>(
      {required String path,
      bool withToken = true,
      dynamic formdata,
      Map<String, dynamic>? param}) async {
    if (withToken) {
      SharedPreferences storage = await SharedPreferences.getInstance();
      String? token = storage.getString("token");
      try {
        final response = await Dio().put<T>(baseURL + path,
            queryParameters: param,
            options: Options(
              headers: {
                "Authorization": "Bearer ${token!}",
                "Accept": "application/json"
              },
              // receiveTimeout: AppConstant.timeout,
              // sendTimeout: AppConstant.timeout,
            ),
            data: formdata);
        return _returnResponse(response);
      } on DioError catch (e) {
        if (e.response!.statusCode! >= 500) {
          return _returnResponse(e.response!);
        } else {
          return e.response!;
        }
      }
    } else {
      try {
        final response = await Dio().put<T>(
          baseURL + path,
          queryParameters: param,
          data: formdata != null ? FormData.fromMap(formdata) : null,
          options: Options(
            headers: {
              "Accept": "application/json",
            },
            // receiveTimeout: AppConstant.timeout,
            // sendTimeout: AppConstant.timeout,
          ),
        );
        return _returnResponse(response);
      } on DioError catch (e) {
        if (e.response!.statusCode! >= 500) {
          return _returnResponse(e.response!);
        } else {
          return e.response!;
        }
      }
    }
  }

  static delete<T extends Object>(
      {required String path, bool withToken = true}) async {
    if (withToken) {
      SharedPreferences storage = await SharedPreferences.getInstance();
      String? token = storage.getString("token");
      try {
        final response = await Dio().delete<T>(
          baseURL + path,
          options: Options(
            headers: {
              "Authorization": "Bearer ${token!}",
              "Accept": "application/json",
            },
            // receiveTimeout: AppConstant.timeout,
            // sendTimeout: AppConstant.timeout,
          ),
        );
        return _returnResponse(response);
      } on DioError catch (e) {
        return _returnResponse(e.response!);
      }
    } else {
      try {
        final response = await Dio().delete<T>(
          baseURL + path,
          options: Options(
            headers: {
              "Accept": "application/json",
            },
            // receiveTimeout: AppConstant.timeout,
            // sendTimeout: AppConstant.timeout,
          ),
        );
        return _returnResponse(response);
      } on DioError catch (e) {
        return _returnResponse(e.response!);
      }
    }
  }

  static Future vGet<T extends Object>(
      {required String path,
      bool withToken = true,
      Map<String, dynamic>? param}) async {
    if (withToken) {
      SharedPreferences storage = await SharedPreferences.getInstance();
      String? token = storage.getString("veea_token");
      // log('token : $token', name: 'AppApi');
      try {
        final response = await Dio().get<T>(
          vBaseURL + path,
          queryParameters: param,
          options: Options(
            headers: {
              "Authorization": "Bearer ${token!}",
              "Accept": "application/json"
            },
            // receiveTimeout: AppConstant.timeout,
            // sendTimeout: AppConstant.timeout,
          ),
        );
        return _returnResponse(response);
      } on DioError catch (e) {
        if (e.response!.statusCode! == 401) {
          storage.remove('veea_token');
          return 'no_token';
          // context.toReplacementNamed(route: AppRoute.)
        }
        if (e.response!.statusCode! >= 500) {
          return _returnResponse(e.response!);
        } else {
          return e.response!;
        }
      }
    } else {
      try {
        final response = await Dio().get<T>(
          vBaseURL + path,
          queryParameters: param,
          options: Options(
            headers: {
              "Accept": "application/json",
            },
            // receiveTimeout: AppConstant.timeout,
            // sendTimeout: AppConstant.timeout,
          ),
        );
        return _returnResponse(response);
      } on DioError catch (e) {
        return _returnResponse(e.response!);
      }
    }
  }

  static Future vPost<T extends Object>(
      {required String path,
      bool withToken = true,
      int minute = 1,
      dynamic formdata,
      Map<String, dynamic>? param}) async {
    log('start', name: 'AppApi-post');
    if (withToken) {
      SharedPreferences storage = await SharedPreferences.getInstance();
      String? token = storage.getString("veea_token");
      log('token : $token', name: 'AppApi');
      try {
        final response = await Dio().post<T>(vBaseURL + path,
            queryParameters: param,
            options: Options(
              receiveDataWhenStatusError: true,
              headers: {
                "Authorization": "Bearer ${token!}",
                "Accept": "application/json"
              },
              // receiveTimeout: AppConstant.timeout,
              // sendTimeout: AppConstant.timeout,
            ),
            data: formdata);
        return _returnResponse(response);
      } on DioError catch (e) {
        if (e.response!.statusCode! == 401) {
          storage.remove('veea_token');
        }
        if (e.response!.statusCode! >= 500) {
          return _returnResponse(e.response!);
        } else {
          return e.response;
        }
      }
    } else {
      try {
        log('try', name: 'AppApi-post');
        final response = await Dio().post<T>(
          vBaseURL + path,
          data: formdata,
          options: Options(
            receiveDataWhenStatusError: true,
            headers: {
              "Accept": "application/json",
            },
            // receiveTimeout: AppConstant.timeout,
            // sendTimeout: AppConstant.timeout,
          ),
        );

        log('response : $response', name: 'AppApi-post');

        return _returnResponse(response);
      } on DioError catch (e) {
        if (e.response!.statusCode! >= 500) {
          return _returnResponse(e.response!);
        } else {
          return e.response;
        }
      }
    }
  }
}

dynamic _returnResponse(Response<dynamic> response) {
  switch (response.statusCode) {
    case 200:
      return response;
    case 201:
      return response;
    case 400:
      throw BadRequestException(response.data['message']);
    case 401:
      throw UnauthorizedException(response.data['message']);
    case 403:
      throw ForbiddenException(response.data['message']);
    case 404:
      throw BadRequestException(response.data['message']);
    case 500:
      throw FetchDataException(response.data['message']);
    default:
      throw FetchDataException(response.data['message']);
    //   throw FetchDataException(
    //       'Error occured while Communication with Server with StatusCode: ${response.statusCode}');
  }
}

class AppException implements Exception {
  final String? details;

  AppException({this.details});

  @override
  String toString() {
    return '$details';
  }
}

class FetchDataException extends AppException {
  FetchDataException(String? details) : super(details: details);
}

class BadRequestException extends AppException {
  BadRequestException(String? details) : super(details: details);
}

class UnauthorizedException extends AppException {
  UnauthorizedException(String? details) : super(details: details);
}

class ForbiddenException extends AppException {
  ForbiddenException(String? details) : super(details: details);
}

class InvalidInputException extends AppException {
  InvalidInputException(String? details) : super(details: details);
}

class AuthenticationException extends AppException {
  AuthenticationException(String? details) : super(details: details);
}

class TimeOutException extends AppException {
  TimeOutException(String? details) : super(details: details);
}
