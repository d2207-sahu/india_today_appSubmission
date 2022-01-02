import 'dart:convert';

import 'package:http/http.dart' as http;

class DailyPanchangService {
  Future fetchLocationAPI() async {
    try {
      http.Response response = await http.get(Uri.parse(
          "https://www.astrotak.com/astroapi/api/location/place?inputPlace=Delhi"));
      if (response.statusCode == 200 || response.statusCode == 201) {
        dynamic data = jsonDecode(response.body);
        List actualData = data['data'];
        return actualData;
      } else {
        // error handling
        throw jsonDecode(response.body)['message'];
      }
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }

  Future callPanchang(int date, int month, int year, String locationTag) async {
    try {
      http.Response response = await http.post(
          Uri.parse(
              "https://www.astrotak.com/astroapi/api/horoscope/daily/panchang"),
          body: jsonEncode({
            "date": date,
            "month": month,
            "year": year,
            "placeId": "${locationTag.toString()}"
          }));
      if (response.statusCode == 200 || response.statusCode == 201) {
        dynamic data = jsonDecode(response.body);
        dynamic actualData = data['data'];
        return actualData;
      } else {
        // error handling
        throw jsonDecode(response.body)['message'];
      }
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }
}
