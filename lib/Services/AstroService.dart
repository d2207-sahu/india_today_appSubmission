import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:india_today/Models/AstroModel.dart';

class AstroService {
  Future<List<AstroModel>?> astroAPICall() async {
    try {
      http.Response response = await http
          .get(Uri.parse("https://www.astrotak.com/astroapi/api/agent/all"));
      if (response.statusCode == 200 || response.statusCode == 201) {
        dynamic data = jsonDecode(response.body);
        List dataList = data['data'];
        List<AstroModel> returnList =
            dataList.map((e) => AstroModel.fromJson(e)).toList();
        //TODO use Isolate
        print(returnList);
        return returnList;
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
