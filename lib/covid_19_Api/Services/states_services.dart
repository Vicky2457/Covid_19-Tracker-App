import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:covid_19/covid_19_Api/model/world_states_model.dart';
import 'package:covid_19/covid_19_Api/utilities/app_url.dart';

class StatesServices {
  Future<WorldStatesModel> fetchWorldStatesRcords() async {
    final responce = await http.get(Uri.parse(AppUrl.worldStateApi));

    if (responce.statusCode == 200) {
      var data = jsonDecode(responce.body);
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }
  Future<List<dynamic>> countriesListApi() async {
    final response = await http.get(Uri.parse(AppUrl.countriesList));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load countries data');
    }
  }
}
