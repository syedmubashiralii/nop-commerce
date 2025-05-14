import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nop_commerce/app/controllers/settings_controller.dart';
import 'package:nop_commerce/app/models/country_model.dart';
import 'package:nop_commerce/app/utils/extensions.dart';
import 'package:nop_commerce/app/views/settings/widgets/common_widgets.dart';

class CountryListView extends GetView<SettingsController> {
  bool shouldUpdate = false;
  CountryListView({super.key,required this.shouldUpdate});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (controller.countryList.isEmpty) {
      controller.fetchAllCountries();
    }
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppBarWidget(
              text: 'Settings',
            ),
            7.SpaceX,
            const SubTitle(text: 'Country'),
            Expanded(
              child: Obx(() {
                // Grouping countries by their first letter
                Map<String, List<CountryModel>> groupedCountries = {};
                for (var country in controller.countryList) {
                  String firstLetter = country.name[0].toUpperCase();
                  if (!groupedCountries.containsKey(firstLetter)) {
                    groupedCountries[firstLetter] = [];
                  }
                  groupedCountries[firstLetter]!.add(country);
                }

                // Sorting the keys (alphabets)
                List<String> sortedKeys = groupedCountries.keys.toList()
                  ..sort();

                return ListView.builder(
                  itemCount: sortedKeys.length,
                  itemBuilder: (context, index) {
                    String letter = sortedKeys[index];
                    List<CountryModel> countries = groupedCountries[letter]!;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        19.SpaceX,
                        Container(
                          height: 27,
                          decoration: BoxDecoration(
                              color: Color(0xffF9F9F9),
                              borderRadius: BorderRadius.circular(12)),
                          alignment: Alignment.center,
                          width: 52,
                          child: Text(
                            letter,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                        19.SpaceX,
                        ...countries.map((country) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 16),
                            child: GestureDetector(
                              onTap: () async {
                                controller.selectedCountry.value=country.name;
                                controller.selectedCountryID.value=country.id;
                                if(shouldUpdate){
                                //  await controller.updateCustomerCountry();
                                }
                                Get.back();
                              },
                              child: SizedBox(
                                width: Get.width,
                                child: Text(
                                  country.name ?? "",
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w300),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    );
                  },
                );
              }),
            ),
          ],
        ),
      )),
    );
  }
}
