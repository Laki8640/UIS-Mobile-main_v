import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;

enum APIType { aGet, aPost, aImageForm }

class ApiService {
  var response;
  Future<dynamic> getResponse({
    required APIType apiType,
    required String url,
    Map<String, dynamic>? body,
    Map<String, String>? header,
  }) async {
    try {
      if (apiType == APIType.aGet) {
        final result = await http.get(Uri.parse(url), headers: header);
        response = returnResponse(result.statusCode, result.body);
        print("REQUEST PARAMETER url  $url");

        log("resp${result.body}");
      } else if (apiType == APIType.aPost) {
        final result =
            await http.post(Uri.parse(url), body: body, headers: header);

        log("resp${result.body}");

        response = returnResponse(result.statusCode, result.body);
        log('result.statusCode-------->>>>>>${result.statusCode}');
      } else if (apiType == APIType.aImageForm) {
        final dio1 = dio.Dio();
        final formData = dio.FormData.fromMap(body!);
        log('formData------${body}');
        final result = await dio1.postUri(Uri.parse(url),
            data: formData, options: dio.Options(headers: header));

        response = returnResponse(result.statusCode!, jsonEncode(result.data));
        log('result.statusCode-------->>>>>>${result.statusCode}');
      }
    } catch (error) {
      return print('ERROR====>[$error]');
    }
    return response;
  }

  returnResponse(int status, String result) {
    switch (status) {
      case 200:
        return jsonDecode(result);
      case 201:
        return jsonDecode(result);
      case 400:
        return jsonDecode(result);
      // throw BadRequestException('Bad Request');
      //   case 401:
      //     return Get.offAll(AskForLogin());
      //   case 403:
      //     return Get.offAll(AskForLogin());
      // case 404:
      // throw ServerException('Server Error');
      case 500:
      default:
      // throw FetchDataException('Internal Server Error');
    }
  }
}
