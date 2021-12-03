import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:zealth_assignment/Models/ImageModel.dart';

class ApiServices {
  Future<ImageModel> getImages(DateTime date) async {
    // ?api_key=HcqImNpixLX1bmqKQ5IMf61GgBrrM9J2VxqcjaIQ
    try {
      String day = date.day < 10 ? "0${date.day}" : "${date.day}";
      String month = date.month < 10 ? "0${date.month}" : "${date.month}";
      final response = await http.get(
        Uri.parse(
            'https://api.nasa.gov/planetary/apod?api_key=HcqImNpixLX1bmqKQ5IMf61GgBrrM9J2VxqcjaIQ&date=${date.year}-$month-$day'),
      );
      dynamic data = jsonDecode(response.body);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        ImageModel imageData = ImageModel.fromJson(data);
        return imageData;
      } else {
        /// NASA Apod API dose not elaborate various status codes.
        /// So I used the 200 one for success, and for the rest took it as error.
        // for cases with 400..,500..
        return ImageModel(
            "${data['msg']}",
            "Failed to Load Data",
            "",
            "https://www.nasa.gov/sites/default/files/styles/side_image/public/thumbnails/image/nasa-logo-web-rgb.png?itok=uDhKSTb1",
            "",
            "${date.year}-$month-$day",
            "",
            "");
      }

      /// JUST IN-CASE Connectivity Package fails, this will make the user experience
      /// a little better.
    } on SocketException {
      return ImageModel(
          "", "No Internet Connection", "", "noInternet", "", "", "", "");
    } catch (e) {
      print(e);
      return ImageModel("", "", "", "", "", "", "", "");
    }
  }
}
