import 'dart:convert';

import 'package:greenzone_medical/src/utils/app_input/countries_model.dart';

import '../app_pkg.dart';

class LocationService {
  final ApiService _apiService;
  final StorageService _storageService;

  LocationService(this._apiService, this._storageService);

  Future<List<CountryModel>> getCountry() async {
    final String cachedCountries =
        _storageService.getString(StorageConstants.countries);
    if (cachedCountries.isNotEmpty) {
      final List<dynamic> cachedData = jsonDecode(cachedCountries);
      return cachedData.map((e) => CountryModel.fromJson(e)).toList();
    }
    final response = await _apiService.get(ApiUrl.getCountry);
    if (response.statusCode == 200) {
      final countries = (response.data as List)
          .map(
            (e) => CountryModel.fromJson(e),
          )
          .toList();
      _storageService.setString(
        StorageConstants.countries,
        jsonEncode(response.data),
      );
      return countries;
    } else {
      return [];
    }
  }  

  Future<List<CountryModel>> getState() async {
    final String cachedCountries =
        _storageService.getString(StorageConstants.countries);
    if (cachedCountries.isNotEmpty) {
      final List<dynamic> cachedData = jsonDecode(cachedCountries);
      return cachedData.map((e) => CountryModel.fromJson(e)).toList();
    }
    final response = await _apiService.get(ApiUrl.getCountry);
    if (response.statusCode == 200) {
      final countries = (response.data as List)
          .map(
            (e) => CountryModel.fromJson(e),
          )
          .toList();
      _storageService.setString(
        StorageConstants.countries,
        jsonEncode(response.data),
      );
      return countries;
    } else {
      return [];
    }
  } 
}
