import 'dart:convert';

import 'package:breed_list/data_provider/data_provider.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class BreedProvider extends DataProvider {
  final http.Client httpClient;
  final _apiKey = "67fb664e-05eb-4334-9464-7207250a44b5";
  final _baseAPIUrl = "https://api.thedogapi.com/v1/breeds";

  BreedProvider({@required this.httpClient});

  @override
  Future<List> readData(int page, int limit) async {
    final response = await httpClient
        .get(_baseAPIUrl + "/?x-api-key=$_apiKey&page=$page&limit=$limit");
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data;
    } else {
      throw Exception('Error fetching breeds');
    }
  }
}
