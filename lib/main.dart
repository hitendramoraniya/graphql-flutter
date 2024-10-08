import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:country_picker/services/graphql_service.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:country_picker/view/country_screen.dart';
import 'controllers/country_controller.dart'; // Import your ViewModel
import 'repository/country_repository.dart'; // Import your ViewModel

import 'bindings.dart';

void main() {
  Get.put(GraphQLService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
      // GraphQLProvider(
      // client: ValueNotifier(
      //   GraphQLClient(
      //     cache: GraphQLCache(),
      //     link: HttpLink('https://countries.trevorblades.com/'),
      //   ),
      // ),
      // child:
    GetMaterialApp(
        initialBinding: AppBindings(),
        title: 'country picker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: false,
        ),
        home: CountryListView(),
      // ),
    );
  }
}
