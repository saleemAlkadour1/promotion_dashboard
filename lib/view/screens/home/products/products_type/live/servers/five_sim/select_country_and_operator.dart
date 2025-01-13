// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/home/products/products_type/live/servers/five_sim_controller.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/core/widgets/handling_data_view.dart';

class SelectCountryAndOperator extends StatelessWidget {
  const SelectCountryAndOperator({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<FiveSimControllerImp>();

    return GetBuilder<FiveSimControllerImp>(builder: (controller) {
      var res = HandlingDataView(
        loading: controller.loading,
        dataIsEmpty: controller.countries == null,
      );
      if (res.isValid) {
        return res.response!;
      }
      return Scaffold(
        appBar: AppBar(
            backgroundColor: AppColors.color_F7F9FA,
            elevation: 0,
            scrolledUnderElevation: 0,
            shadowColor: AppColors.transparent,
            title: Text(
              'Select country and operator',
              style: MyText.appStyle.fs16.wBold.reColorText.style,
            ),
            automaticallyImplyLeading: false,
            leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.black,
                ),
              ),
            )),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.countries!.length,
                    itemBuilder: (context, index) {
                      final country = controller.countries![index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Card(
                          elevation: 5,
                          margin: EdgeInsets.only(bottom: 16),
                          child: ExpansionTile(
                            shape:
                                RoundedRectangleBorder(side: BorderSide.none),
                            title: Text(
                              country.countryName,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            children: country.operators.map((operator) {
                              return GestureDetector(
                                onTap: () {
                                  controller.selectCountry(country);
                                  controller.selectOperator(operator);
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color:
                                        controller.selectedOperator == operator
                                            ? Colors.blue.shade100
                                            : Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 4,
                                        offset: Offset(2, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(operator.name),
                                      Text(
                                          "${operator.price.amount.toStringAsFixed(3)} ${operator.price.currency}"),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: controller.backToCreateProduct,
                        child: Text('<<< واجهة إنشاء منتج')),
                    SizedBox(
                      width: 20,
                    ),
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text('الواجهة السابقة >>>')),
                  ],
                ),
              ],
            )),
      );
    });
  }
}
