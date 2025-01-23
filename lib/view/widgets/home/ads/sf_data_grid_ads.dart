import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/home/ads/ads_management_controller.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/core/constants/assets.dart';
import 'package:promotion_dashboard/core/constants/routes.dart';
import 'package:promotion_dashboard/core/functions/snackbar.dart';
import 'package:promotion_dashboard/core/widgets/handling_data_view.dart';
import 'package:promotion_dashboard/data/data_grid_sources/contacts_data_source.dart';
import 'package:promotion_dashboard/data/model/home/contacts/contact_model.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_icon.dart';
import 'package:promotion_dashboard/view/widgets/general/responsive_sf_data_pager.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:url_launcher/url_launcher.dart';

class SfDataGridAds extends StatelessWidget {
  const SfDataGridAds({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    Get.put(AdsManagementControllerImp());
    return GetBuilder<AdsManagementControllerImp>(builder: (controller) {
      var res = HandlingDataView(
        loading: controller.loading,
        dataIsEmpty: controller.contacts.isEmpty,
      );
      if (res.isValid) {
        return res.response!;
      }
      ContactsDataSource contactsDataSource = ContactsDataSource(
        contacts: controller.filteredContacts,
        custombuildRow: (row, isEvenRow) {
          final color = isEvenRow ? const Color(0xFFF9F9F9) : Colors.white;
          return DataGridRowAdapter(
            color: color,
            cells: row.getCells().map<Widget>((cell) {
              if (cell.columnName == 'Actions') {
                return Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIcon(
                          path: Assets.imagesSvgEdit,
                          size: 16,
                          onTap: () async {
                            if (cell.columnName == 'Actions' &&
                                cell.value is ContactModel) {
                              await Get.toNamed(
                                AppRoutes.updateContact,
                                parameters: {
                                  'contact_id': cell.value.id?.toString() ?? '',
                                },
                              );
                              controller.getContactsData(
                                  pageIndex: controller
                                      .paganationDataModel.currentPage);
                            }
                          },
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        CustomIcon(
                          path: Assets.imagesSvgDelete,
                          size: 16,
                          onTap: () async {
                            if (cell.columnName == 'Actions' &&
                                cell.value is ContactModel) {
                              final contact = cell.value as ContactModel;
                              await controller.deleteContact(contact.id);
                            }
                          },
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        CustomIcon(
                          path: Assets.imagesSvgEye,
                          size: 16,
                          onTap: () {
                            if (cell.columnName == 'Actions' &&
                                cell.value is ContactModel) {
                              final category = cell.value as ContactModel;
                              controller.showCategoryDetailsDialog(category.id);
                            }
                          },
                        ),
                      ],
                    ));
              }
              // if (cell.columnName == 'URL') {
              //   return Container(
              //       alignment: Alignment.center,
              //       padding: const EdgeInsets.all(8.0),
              //       child: buildClickableLink(cell.value, context));
              // }
              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  cell.value.toString(),
                  style: MyText.appStyle.fs16.wMedium.reColorText
                      .responsiveStyle(context),
                ),
              );
            }).toList(),
          );
        },
      );
      return Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Builder(builder: (context) {
                  var res = HandlingDataView(
                    loading: controller.loading,
                    dataIsEmpty: controller.filteredContacts.isEmpty,
                  );
                  if (res.isValid) {
                    return res.response!;
                  }
                  return SfDataGrid(
                    gridLinesVisibility: GridLinesVisibility.none,
                    headerGridLinesVisibility: GridLinesVisibility.none,
                    source: contactsDataSource,
                    columnWidthMode: MediaQuery.sizeOf(context).width <= 475
                        ? ColumnWidthMode.auto
                        : ColumnWidthMode.fill,
                    columnSizer: ColumnSizer(),
                    rowsPerPage: controller.paganationDataModel.perPage,
                    columns: [
                      GridColumn(
                        columnName: 'ID',
                        label: Container(
                            color: AppColors.white,
                            alignment: Alignment.center,
                            child: Text(
                              'ID',
                              style: MyText.appStyle.fs16.wBold.reColorText
                                  .responsiveStyle(context),
                            )),
                      ),
                      GridColumn(
                        columnName: 'Name',
                        label: Container(
                            color: AppColors.white,
                            alignment: Alignment.center,
                            child: Text(
                              'Name',
                              style: MyText.appStyle.fs16.wBold.reColorText
                                  .responsiveStyle(context),
                            )),
                      ),
                      GridColumn(
                        columnName: 'URL',
                        label: Container(
                            color: AppColors.white,
                            alignment: Alignment.center,
                            child: Text(
                              'URL',
                              style: MyText.appStyle.fs16.wBold.reColorText
                                  .responsiveStyle(context),
                            )),
                      ),
                      GridColumn(
                        columnName: 'Actions',
                        label: Container(
                            color: AppColors.white,
                            alignment: Alignment.center,
                            child: Text(
                              'Actions',
                              style: MyText.appStyle.fs16.wBold.reColorText
                                  .responsiveStyle(context),
                            )),
                      ),
                    ],
                  );
                }),
              ),
              ResponsiveSfDataPager(
                  dataSource: contactsDataSource,
                  onPageNavigationStart: (pageIndex) {},
                  onPageNavigationEnd: (pageIndex) async {
                    await controller.getContactsData(pageIndex: pageIndex + 1);
                    controller.update();
                  },
                  rowsPerPage: controller.paganationDataModel.perPage,
                  total: controller.paganationDataModel.total),
            ],
          ),
          if (controller.loading)
            const Center(
              child: CircularProgressIndicator(
                color: AppColors.color_4EB7F2,
              ),
            )
        ],
      );
    });
  }
}

// Helper Method for Clickable Link Row
Widget buildClickableLink(
  String url,
  BuildContext context,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: InkWell(
      onTap: () async {
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url), mode: LaunchMode.inAppWebView);
        } else {
          customSnackBar('Error', 'Cannot open the link',
              snackType: SnackBarType.error);
        }
      },
      child: Text(
        url,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
        textAlign: TextAlign.end,
      ),
    ),
  );
}
