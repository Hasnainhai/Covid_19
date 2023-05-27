import 'dart:convert';

import 'package:covid_19/model/world_state_model.dart';
import 'package:covid_19/services/utilities/app_Url.dart';
import 'package:http/http.dart' as http;

class StatesServices {
  Future<worldStateModel> fetchWorldStateData() async {
    final response = await http.get(Uri.parse(AppUrl.worldStateApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return worldStateModel.fromJson(data);
    } else {
      throw Exception('error');
    }
  }
}
