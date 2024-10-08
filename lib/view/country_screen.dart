import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/country_controller.dart';
import '../repository/country_repository.dart';

class CountryListView extends StatelessWidget {
  final CountryRepository countryRepository =
      Get.put(CountryRepository(Get.find()));
  final CountryController controller = Get.put(CountryController(Get.find()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Countries'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              style: TextStyle(color: Colors.white),
              onChanged: (code) {
                if(code.isEmpty){
                  controller.fetchCountries();
                }else {
                  controller.searchCountryByCode(code);
                }
              },
              decoration: InputDecoration(
                hintText: 'Enter country code...',
                hintStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.white,
                )),
              ),
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (controller.hasError.value) {
          return Center(child: Text('Failed to fetch countries'));
        }
        if (controller.filteredCountries.isEmpty) {
          return Center(child: Text('No countries found'));
        }
        return ListView.builder(
          itemCount: controller.filteredCountries.length,
          itemBuilder: (context, index) {
            final country = controller.filteredCountries[index];
            return ListTile(
              title: Text("${country.phone ?? ""} ${country.name ?? ""} (${country.code ?? ""})"),
              subtitle: Text('Capital: ${country.capital ?? "N/A"}'),
              trailing: Text(country.emoji ?? "🌍"),
            );
          },
        );
      }),
    );
  }
}

// class CountryScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final GraphQLService graphqlService = GraphQLService();
//     final CountryController viewModel = Get.put(CountryController(graphqlService));
//
//     return Scaffold(
//       appBar: AppBar(title: Text("Country Info")),
//       body: Obx(() {
//         if (viewModel.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         }
//
//         return Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text('Country: ${viewModel.countryName.value} ${viewModel.countryEmoji.value}'),
//               Text('Capital: ${viewModel.countryCapital.value}'),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   viewModel.fetchCountry('BR'); // Fetch data for Brazil as an example
//                 },
//                 child: Text("Get Country Info"),
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }

//
// class CountryScreen extends StatelessWidget {
//   final CountryController controller = Get.put(CountryController(Get.find<GraphQLClient>()));
//
//   @override
//   Widget build(BuildContext context) {
//     final GraphQLClient client = GraphQLProvider.of(context).value;
//     final CountryRepository repository = CountryRepository(client);
//     final CountryController viewModel = Get.put(CountryController(repository));
//
//     return Scaffold(
//       appBar: AppBar(title: Text("Country Info")),
//       body: Obx(() {
//         if (viewModel.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         }
//
//         return Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text('Country: ${viewModel.countryName.value} ${viewModel.countryEmoji.value}'),
//               Text('Capital: ${viewModel.countryCapital.value}'),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   viewModel.fetchCountry('BR'); // Fetch data for Brazil as an example
//                 },
//                 child: Text("Get Country Info"),
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }
