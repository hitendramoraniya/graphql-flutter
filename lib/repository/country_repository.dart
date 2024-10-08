import 'package:graphql_flutter/graphql_flutter.dart';

import '../models/country.dart';
import '../services/graphql_service.dart';


class CountryRepository {
  final GraphQLService graphqlService;

  CountryRepository(this.graphqlService);

  Future<List<Country>> fetchAllCountries() async {
    return await graphqlService.fetchAllCountries();
  }


  Future<Country?> fetchCountryByCode(String code) async {
    return await graphqlService.fetchCountryByCode(code);
  }

}
