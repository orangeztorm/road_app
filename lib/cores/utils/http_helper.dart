import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:path/path.dart';

import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

// import '../navigator/navigator.dart';
// import '../shared_session/session_manager.dart';
// import 'logger.dart';

class HttpHelper {
  final Client client;
  final AppRouter appRouter;

  // final CrashLogger crashLogger;

  HttpHelper({
    required this.client,
    required this.appRouter,
    // required this.crashLogger,
  });

  Future<Map<String, String>> headers() async {
    // final token = await getIt<AuthLocalStorageDataSource>().getToken();
    final token = SessionManager.instance.getToken;
    log('token header $token');
    final body = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'version': '1.0.0',
      if (token != null) 'Authorization': 'Bearer $token',
      'platform': Platform.operatingSystem,
      // 'version': (await PackageInfo.fromPlatform()).version.substring(0, 4),
    };
    return body;
  }

  Future<Map<String, dynamic>> get(
    String url, {
    Map<String, dynamic>? query,
  }) async {
    try {
      final Map<String, String> header = await headers();

      if (query != null) {
        url += '?';

        query.forEach((key, value) {
          bool isFirst = query.keys.toList().indexOf(key) == 0;
          if (isFirst) {
            url += '$key=$value';
          } else {
            url += '&$key=$value';
          }
        });
      }

      LoggerHelper.log(url);
      LoggerHelper.log(query);
      LoggerHelper.log("header: $header");

      Response response = await client
          .get(Uri.parse(url), headers: header)
          .timeout(const Duration(seconds: 45));

      LoggerHelper.log(response.body);

      final Map<String, dynamic> result = json.decode(response.body);

      // Log Endpoint
      // crashLogger.endpointLogData(
      //   url: url,
      //   header: header,
      //   response: response.body,
      // );

      if ((response.statusCode ~/ 100) == 2) {
        return result;
      } else if (response.statusCode == 401) {
        appRouter.logOut();
        throw "Session has expired, please login";
      } else {
        throw result['message'];
      }
    } on FormatException catch (e, s) {
      LoggerHelper.log(e, s);
      if (kDebugMode) {
        throw 'Unable To Format Data!';
      }

      throw 'Something went wrong, please try again';
    } on http.ClientException catch (e, s) {
      // Specifically catch ClientException and remove the URL from the error message
      LoggerHelper.log(e, s);
      throw 'Network Error: Connection aborted. Please check your internet connection and try again.';
    } on SocketException catch (e, s) {
      LoggerHelper.log(e, s);
      throw 'No Internet Connection found, check your network and try again';
    } on TimeoutException catch (e, s) {
      LoggerHelper.log(e, s);
      throw 'Request timed out, please try again';
    } catch (e) {
      throw e.toString();
    }
  }

  /// Make an [Http] post request
  Future<Map<String, dynamic>> post({
    required String url,
    required Map<String, dynamic> body,
    Map<String, String> extraHeader = const {},
    Map<String, dynamic>? query,
    Duration? timeoutDuration,
  }) async {
    try {
      if (query != null) {
        url += '?';
        query.forEach((key, value) => url += '&$key=$value');
      }

      LoggerHelper.log(url);
      LoggerHelper.log(query);
      LoggerHelper.log(body);
      LoggerHelper.log("Extra Header: $extraHeader");

      final bodyData = json.encode(body);
      Response response = await client
          .post(
            Uri.parse(url),
            headers: {...await headers(), ...extraHeader},
            body: bodyData,
          )
          .timeout(timeoutDuration ?? const Duration(seconds: 25));

      LoggerHelper.log(response.body);

      final Map<String, dynamic> result = json.decode(response.body);

      if ((response.statusCode ~/ 100) == 2) {
        return result;
      } else {
        throw checkForError(result);
      }
    } on FormatException catch (e, s) {
      LoggerHelper.log(e, s);
      if (kDebugMode) {
        throw 'Unable To Format Data!';
      }

      throw 'Something went wrong, please try again';
    } on TimeoutException catch (e, s) {
      LoggerHelper.log(e, s);
      throw 'Request Timeout, Unable to connect to server please check your network and try again!';
    } on http.ClientException catch (e, s) {
      // Specifically catch ClientException and remove the URL from the error message
      LoggerHelper.log(e, s);
      throw 'Network Error: Connection aborted. Please check your internet connection and try again.';
    } on SocketException catch (e, s) {
      LoggerHelper.log(e, s);
      throw 'Request timed out, please try again';
    } catch (e) {
      throw e.toString();
    }
  }

  /// Make an [Http] put request
  Future<Map<String, dynamic>> put({
    required String url,
    required Map<String, dynamic> body,
    Map<String, String> extraHeader = const {},
  }) async {
    try {
      // Log Endpoint
      final Map<String, String> header = await headers();

      LoggerHelper.log(url);
      LoggerHelper.log(body);
      LoggerHelper.log("header: ${await headers()}");
      LoggerHelper.log("Extra Header: $extraHeader");

      Response response = await client
          .put(
            Uri.parse(url),
            headers: {...header, ...extraHeader},
            body: json.encode(body),
          )
          .timeout(const Duration(seconds: 25));

      LoggerHelper.log(response.body);

      final Map<String, dynamic> result = json.decode(response.body);

      // Log Endpoint
      // crashLogger.endpointLogData(
      //   url: url,
      //   header: header,
      //   body: body,
      //   response: response.body,
      // );

      if ((response.statusCode ~/ 100) == 2) {
        return result;
      } else {
        throw checkForError(result);
      }
    } on FormatException catch (e, s) {
      LoggerHelper.log(e, s);
      if (kDebugMode) {
        throw 'Unable To Format Data!';
      }

      throw 'Something went wrong, please try again';
    } on TimeoutException catch (e, s) {
      LoggerHelper.log(e, s);
      throw 'Request Timeout, Unable to connect to server please check your network and try again!';
    } on http.ClientException catch (e, s) {
      // Specifically catch ClientException and remove the URL from the error message
      LoggerHelper.log(e, s);
      throw 'Network Error: Connection aborted. Please check your internet connection and try again.';
    } on SocketException catch (e, s) {
      LoggerHelper.log(e, s);
      throw 'Request timed out, please try again';
    } catch (e) {
      throw e.toString();
    }
  }

  // Future<Map<String, dynamic>> postMultipartWithFields<T>({
  //   required String url,
  //   required List<MapEntry<String, http.MultipartFile>> files,
  //   required T fields,
  // }) async {
  //   try {
  //     final Map<String, String> header = await headers();
  //     LoggerHelper.log(url);
  //     LoggerHelper.log(fields);
  //     LoggerHelper.log(files);
  //     LoggerHelper.log("header: ${await headers()}");
  //     var request = http.MultipartRequest('POST', Uri.parse(url));

  //     if (fields is Map<String, dynamic>) {
  //       fields.forEach((key, value) {
  //         if (value is List) {
  //           request.fields[key] = value.join(',');
  //         } else if (value != null) {
  //           request.fields[key] = value.toString();
  //         }
  //       });
  //     } else {
  //       throw ArgumentError("Unsupported field type: ${fields.runtimeType}");
  //     }

  //     for (var fileEntry in files) {
  //       request.files.add(fileEntry.value);
  //     }

  //     request.headers.addAll(header);

  //     var streamedResponse = await request.send();
  //     var response = await http.Response.fromStream(streamedResponse);

  //     final Map<String, dynamic> result = json.decode(response.body);

  //     LoggerHelper.log(response.body);

  //     if ((response.statusCode ~/ 100) == 2) {
  //       return result;
  //     } else {
  //       throw 'Error: ${result['message']}';
  //     }
  //   } on FormatException catch (e) {
  //     throw 'Unable to format data: $e';
  //   } on http.ClientException catch (e) {
  //     throw 'Client Exception: $e';
  //   } on TimeoutException catch (e) {
  //     throw 'Timeout Exception: $e';
  //   } catch (e) {
  //     throw 'An unexpected error occurred: $e';
  //   }
  // }

  Future<Map<String, dynamic>> patchMultipartWithFields<T>({
    required String url,
    required List<MapEntry<String, http.MultipartFile>> files,
    required T fields,
  }) async {
    try {
      final Map<String, String> header = await headers();
      LoggerHelper.log(url);
      LoggerHelper.log(fields);
      LoggerHelper.log(files);
      LoggerHelper.log("header: ${await headers()}");
      var request = http.MultipartRequest('PATCH', Uri.parse(url));

      if (fields is Map<String, dynamic>) {
        fields.forEach((key, value) {
          if (value is List) {
            request.fields[key] = value.join(',');
          } else if (value != null) {
            request.fields[key] = value.toString();
          }
        });
      } else {
        throw ArgumentError("Unsupported field type: ${fields.runtimeType}");
      }

      for (var fileEntry in files) {
        request.files.add(fileEntry.value);
      }

      request.headers.addAll(header);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      final Map<String, dynamic> result = json.decode(response.body);

      LoggerHelper.log(response.body);

      if ((response.statusCode ~/ 100) == 2) {
        return result;
      } else {
        throw 'Error: ${result['message']}';
      }
    } on FormatException catch (e) {
      throw 'Unable to format data: $e';
    } on http.ClientException catch (e) {
      throw 'Client Exception: $e';
    } on TimeoutException catch (e) {
      throw 'Timeout Exception: $e';
    } catch (e) {
      throw 'An unexpected error occurred: $e';
    }
  }

  // Future<Map<String, dynamic>> postMultipartWithFields2<T>({
  //   required String url,
  //   required List<MapEntry<String, http.MultipartFile>> files,
  //   required T fields,
  // }) async {
  //   try {
  //     final Map<String, String> header = await headers();
  //     LoggerHelper.log(url);
  //     LoggerHelper.log(fields);
  //     LoggerHelper.log(files);
  //     LoggerHelper.log("header: ${await headers()}");
  //     var request = http.MultipartRequest('POST', Uri.parse(url));

  //     // Add the fields to the request
  //     if (fields is Map<String, dynamic>) {
  //       fields.forEach((key, value) {
  //         if (value is List) {
  //           request.fields[key] = value.join(',');
  //         } else if (value != null) {
  //           request.fields[key] = value.toString();
  //         }
  //       });
  //     } else {
  //       throw ArgumentError("Unsupported field type: ${fields.runtimeType}");
  //     }

  //     // Add files to the request
  //     for (var fileEntry in files) {
  //       request.files.add(fileEntry.value);
  //     }

  //     // Add headers
  //     request.headers.addAll(header);

  //     // Send the request
  //     var streamedResponse = await request.send();
  //     var response = await http.Response.fromStream(streamedResponse);

  //     // Decode the response
  //     final Map<String, dynamic> result = json.decode(response.body);

  //     LoggerHelper.log(response.body);

  //     if ((response.statusCode ~/ 100) == 2) {
  //       return result;
  //     } else {
  //       throw 'Error: ${result['message']}';
  //     }
  //   } on FormatException catch (e) {
  //     throw 'Unable to format data: $e';
  //   } on http.ClientException catch (e, s) {
  //     // Specifically catch ClientException and remove the URL from the error message
  //     LoggerHelper.log(e, s);
  //     throw 'Network Error: Connection aborted. Please check your internet connection and try again.';
  //   } on TimeoutException catch (e) {
  //     throw 'Timeout Exception: $e';
  //   } catch (e) {
  //     throw 'An unexpected error occurred: $e';
  //   }
  // }

  Future<Map<String, dynamic>> postMultipartWithFields2({
    required String url,
    required File imageFile, // Ensure image is a valid File
    required double longitude,
    required double latitude,
    required String address,
  }) async {
    try {
      // ✅ Ensure file exists before sending
      if (!imageFile.existsSync()) {
        throw "❌ File does not exist: ${imageFile.path}";
      } else {
        print(
            "📂 File exists: ${imageFile.path}, Size: ${imageFile.lengthSync()} bytes");
      }

      // ✅ Move file to app storage if needed (especially for Android)
      imageFile = await moveToAppStorage(imageFile);

      final Map<String, String> headers = {
        'Authorization':
            'Bearer ${SessionManager.instance.getToken}', // Replace with actual token
        'Accept': 'application/json',
        'version': '1.0.0',
        'platform': 'android',
      };

      // ✅ Construct full URL with query parameters
      String fullUrl =
          "$url?longitude=$longitude&latitude=$latitude&address=${Uri.encodeComponent(address)}";
      var request = http.MultipartRequest('POST', Uri.parse(fullUrl));

      // ✅ Remove 'Content-Type' (Flutter sets it automatically)
      headers.remove('Content-Type');
      request.headers.addAll(headers);

      // ✅ Add fields correctly
      request.fields['longitude'] = longitude.toString();
      request.fields['latitude'] = latitude.toString();
      request.fields['address'] = address;

      // ✅ Convert File to Multipart with Correct MIME Type
      final mimeTypeData = lookupMimeType(imageFile.path)?.split('/');
      final fileMultipart = await http.MultipartFile.fromPath(
        'image', // Make sure 'image' is the correct field name based on Swagger!
        imageFile.path,
        contentType: mimeTypeData != null
            ? MediaType(
                mimeTypeData[0], mimeTypeData[1]) // ✅ Fixes MediaType error
            : null,
      );
      request.files.add(fileMultipart);

      // ✅ Debugging Logs
      print("🔍 Sending Multipart Request...");
      print("🟢 URL: $fullUrl");
      print("🟢 Headers: ${request.headers}");
      print("🟢 Fields: ${request.fields}");
      print("🟢 Files: ${request.files}");
      print("📂 File Path: ${imageFile.path}");
      print("📂 File Size: ${imageFile.lengthSync()} bytes");

      // ✅ Send request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      // ✅ Print API Response
      print("🔵 Response Status Code: ${response.statusCode}");
      print("🔵 Response Headers: ${response.headers}");
      print("🔵 Response Body: ${response.body}");

      final result = json.decode(response.body);

      if ((response.statusCode ~/ 100) == 2) {
        return result;
      } else {
        throw checkForError(result);
      }
    } on FormatException catch (e, s) {
      LoggerHelper.log(e, s);
      if (kDebugMode) {
        throw 'Unable To Format Data!';
      }

      throw 'Something went wrong, please try again';
    } on TimeoutException catch (e, s) {
      LoggerHelper.log(e, s);
      throw 'Request Timeout, Unable to connect to server please check your network and try again!';
    } on SocketException catch (e, s) {
      LoggerHelper.log(e, s);
      throw 'Request timed out, please try again';
    } on http.ClientException catch (e, s) {
      // Specifically catch ClientException and remove the URL from the error message
      LoggerHelper.log(e, s);
      throw 'Network Error: Connection aborted. Please check your internet connection and try again.';
    } catch (e) {
      throw e.toString();
    }
  }

// ✅ Move File to App Storage (Fix for Android Cache Issue)
  Future<File> moveToAppStorage(File imageFile) async {
    final Directory appDir = await getApplicationDocumentsDirectory();
    final String newPath = '${appDir.path}/${imageFile.path.split('/').last}';
    return imageFile.copy(newPath);
  }

  /// Make an [Http] patch request
  Future<Map<String, dynamic>> patch({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    try {
      // Log Endpoint
      final Map<String, String> header = await headers();

      LoggerHelper.log(url);
      LoggerHelper.log(body);
      LoggerHelper.log("header: ${await headers()}");

      Response response = await client
          .patch(Uri.parse(url), headers: header, body: json.encode(body))
          .timeout(const Duration(seconds: 25));

      LoggerHelper.log(response.body);

      final Map<String, dynamic> result = json.decode(response.body);

      if ((response.statusCode ~/ 100) == 2) {
        return result;
      } else {
        throw checkForError(result);
      }
    } on FormatException catch (e, s) {
      LoggerHelper.log(e, s);
      if (kDebugMode) {
        throw 'Unable To Format Data!';
      }

      throw 'Something went wrong, please try again';
    } on TimeoutException catch (e, s) {
      LoggerHelper.log(e, s);
      throw 'Request Timeout, Unable to connect to server please check your network and try again!';
    } on SocketException catch (e, s) {
      LoggerHelper.log(e, s);
      throw 'Request timed out, please try again';
    } on http.ClientException catch (e, s) {
      // Specifically catch ClientException and remove the URL from the error message
      LoggerHelper.log(e, s);
      throw 'Network Error: Connection aborted. Please check your internet connection and try again.';
    } catch (e) {
      throw e.toString();
    }
  }

  /// Make an [Http] delete request
  Future<Map<String, dynamic>> delete({
    required String url,
    required Map<String, dynamic> body,
    Map<String, dynamic>? query,
  }) async {
    try {
      final Map<String, String> header = await headers();

      if (query != null) {
        url += '?';
        query.forEach((key, value) => url += '&$key=$value');
      }

      LoggerHelper.log(url);
      LoggerHelper.log(query);
      LoggerHelper.log(body);
      LoggerHelper.log("header: ${await headers()}");

      Response response = await client
          .delete(Uri.parse(url), headers: header, body: json.encode(body))
          .timeout(const Duration(seconds: 25));

      LoggerHelper.log(response.body);

      final Map<String, dynamic> result = json.decode(response.body);

      // Log Endpoint
      // crashLogger.endpointLogData(
      //   url: url,
      //   header: header,
      //   body: body,
      //   response: response.body,
      // );

      if ((response.statusCode ~/ 100) == 2) {
        return result;
      } else {
        throw checkForError(result);
      }
    } on FormatException catch (e, s) {
      LoggerHelper.log(e, s);
      if (kDebugMode) {
        throw 'Unable To Format Data!';
      }

      throw 'Something went wrong, please try again';
    } on TimeoutException catch (e, s) {
      LoggerHelper.log(e, s);
      throw 'Request Timeout, Unable to connect to server please check your network and try again!';
    } on SocketException catch (e, s) {
      LoggerHelper.log(e, s);
      throw 'Request timed out, please try again';
    } on http.ClientException catch (e, s) {
      // Specifically catch ClientException and remove the URL from the error message
      LoggerHelper.log(e, s);
      throw 'Network Error: Connection aborted. Please check your internet connection and try again.';
    } catch (e) {
      throw e.toString();
    }
  }

  //! Todo: Refactor this method to use status code
  static String checkForError(Map data) {
    if (data['error'] != null ||
        data['state'] == "error" ||
        (data['httpStatusCode'] != null && data['httpStatusCode'] ~/ 2 != 1) ||
        (data['httpStatusCode'] != null && data['httpStatusCode'] ~/ 2 != 1)) {
      if (data['httpStatusCode'] == 402) {
        // AppRouter.instance.clearRouteAndPush(LoginPage.routeName);
      }
      if (data['message'] is List<dynamic>) {
        throw data['message'].join(', ');
      }
      final String? message = data['message'] ?? data['msg'];

      if (message != null) throw message;
      final Map<String, dynamic> errorMap = Map.from(data['error']);
      return errorMap.values.join('\n');
    }

    return 'Something went wrong, Please try again';
  }
}

T? castParam<T>(dynamic param) {
  if (param is T) return param;
  return null;
}
