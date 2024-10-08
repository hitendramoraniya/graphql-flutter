import 'package:country_picker/repository/country_repository.dart';
import 'package:get/get.dart';
import 'package:country_picker/services/graphql_service.dart';
import 'controllers/country_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GraphQLService());
    Get.lazyPut(() => CountryRepository(Get.find()));
    Get.lazyPut(() => CountryController(Get.find<CountryRepository>()));
  }
}
