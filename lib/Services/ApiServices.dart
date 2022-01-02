import 'dart:convert';
import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart';
import 'package:india_today/Models/ImageModel.dart';

class ApiServices {
  final String _api_key = 'HcqImNpixLX1bmqKQ5IMf61GgBrrM9J2VxqcjaIQ';

  //  final response = await http.get(
  //     Uri.parse(
  //      'https://api.nasa.gov/planetary/apod?api_key=HcqImNpixLX1bmqKQ5IMf61GgBrrM9J2VxqcjaIQ&date=${date.year}-$month-$day'),
  //  );
  //  dynamic data = jsonDecode(response.body);
  //  print(response.statusCode);
  //  print(response.body);

  Future<ImageModel> getImages(DateTime date) async {
    String day = date.day < 10 ? "0${date.day}" : "${date.day}";
    String month = date.month < 10 ? "0${date.month}" : "${date.month}";
    String url =
        'https://api.nasa.gov/planetary/apod?api_key=${_api_key}&date=${date.year}-$month-$day';
    try {
      final cacheResponse = await getData(url);
      dynamic data = jsonDecode(cacheResponse.body);
      if (cacheResponse.statusCode == 200) {
        try {
          ImageModel imageData = ImageModel.fromJson(data);
          return imageData;
        } catch (e) {
          print(e);
          return ImageModel.ofError(
            explain: "Failed to Load Data",
            date: "${date.year}-$month-$day",
          );
        }
      } else {
        /// NASA Apod API dose not elaborate various status codes.
        /// So I used the 200 one for success, and for the rest took it as error.
        // for cases with 400..,500..
        return ImageModel.ofError(
          explain: "${data['msg']}",
          date: "${date.year}-$month-$day",
        );
      }

      /// JUST IN-CASE Connectivity Package fails, this will make the user experience
      /// a little better.
    } on SocketException {
      return ImageModel.ofError(
        explain: "No Internet Connection",
        date: "${date.year}-$month-$day",
      );
    } on HttpException {
      return ImageModel.ofError(
        explain: "HTTP Exception. Picture for the date not available.",
        date: "${date.year}-$month-$day",
      );
    } catch (e) {
      print(e);
      return ImageModel.ofError(
        explain: "$e",
        date: "${date.year}-$month-$day",
      );
    }
  }

  Future<Response> getData(String url) async {
    dynamic file = await DefaultCacheManager().getSingleFile(url);
    if (file != null && await file.exists()) {
      var res = await file.readAsString();
      print(res);
      return Response(res, 200);
    }
    return Response("{msg:Error}", 404);
  }
}
