import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../models/country.dart';
import '../repository/country_repository.dart';

class CountryController extends GetxController {
  final CountryRepository _countryRepository;
  var countries = <Country>[].obs;
  var filteredCountries = <Country>[].obs; // For the filtered list
  var isLoading = true.obs;
  var hasError = false.obs;

  CountryController(this._countryRepository);

  @override
  void onInit() {
    fetchCountries();
    super.onInit();
  }

  void fetchCountries() async {
    try {
      isLoading(true);
      final fetchedCountries = await _countryRepository.fetchAllCountries();
      countries.assignAll(fetchedCountries);
      filteredCountries.assignAll(fetchedCountries);
    } catch (e) {
      hasError(true);
    } finally {
      isLoading(false);
    }
  }

  void searchCountryByCode(String code) async {
    try {
      isLoading(true);
      final country = await _countryRepository.fetchCountryByCode(code);
      if (country != null) {
        filteredCountries.assignAll([country]); // Show the found country
      } else {
        filteredCountries.clear(); // Clear the list if no country found
      }
    } catch (e) {
      hasError(true);
    } finally {
      isLoading(false);
    }
  }
}

//
// class CountryController extends GetxController {
//   var countryName = ''.obs;
//   var countryCapital = ''.obs;
//   var countryEmoji = ''.obs;
//   var isLoading = true.obs;
//
//   final CountryRepository repository;
//
//   CountryController(this.repository);
//
//   void fetchCountry(String code) async {
//     isLoading.value = true;
//
//     final countryData = await repository.fetchCountry(code);
//
//     if (countryData != null) {
//       countryName.value = countryData['name'];
//       countryCapital.value = countryData['capital'];
//       countryEmoji.value = countryData['emoji'];
//     } else {
//       // Handle error: Country not found
//       countryName.value = "Error";
//       countryCapital.value = "Not Found";
//       countryEmoji.value = "";
//     }
//
//     isLoading.value = false;
//   }
// }
