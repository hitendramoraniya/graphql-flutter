import 'package:graphql_flutter/graphql_flutter.dart';
import '../models/country.dart';

class GraphQLService {
  final GraphQLClient client;

  GraphQLService()
      : client = GraphQLClient(
    link: HttpLink('https://countries.trevorblades.com/graphql'),
    cache: GraphQLCache(store: InMemoryStore()),
  );

  Future<List<Country>> fetchAllCountries() async {
    const String query = r'''
      query {
        countries {
          name
          phone
          capital
          emoji
          currency
          code
        }
      }
    ''';

    final QueryOptions options = QueryOptions(
      document: gql(query),
    );

    final result = await client.query(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final List countriesJson = result.data!['countries'] as List;
    return countriesJson.map((json) => Country.fromJson(json)).toList();
  }

  Future<Country?> fetchCountryByCode(String code) async {
    const String query = r'''
      query GetCountryByCode($code: ID!) {
        country(code: $code) {
          name
          phone
          capital
          emoji
          currency
          code
          languages {
            code
            name
          }
        }
      }
    ''';

    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: {'code': code}, // Pass the code variable
    );

    final result = await client.query(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final countryJson = result.data!['country'];
    if (countryJson == null) {
      return null; // No country found for the provided code
    }
    return Country.fromJson(countryJson);
  }

}
