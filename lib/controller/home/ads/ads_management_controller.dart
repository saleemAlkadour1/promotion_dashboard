import 'package:get/get.dart';
import 'package:promotion_dashboard/core/functions/show_delete_confirmation_dialog.dart';
import 'package:promotion_dashboard/core/functions/snackbar.dart';
import 'package:promotion_dashboard/data/model/general/paganiation_data_model.dart';
import 'package:promotion_dashboard/data/model/home/ads/ad_model.dart';
import 'package:promotion_dashboard/data/resource/remote/home/ads_data.dart';
import 'package:promotion_dashboard/view/widgets/home/ads/ads_details_dialog.dart';

abstract class AdsManagementController extends GetxController {
  String? activeValue = 'All';

  void updateActiveValue(String value);

  Future<void> getAdsData({required int pageIndex});
  Future<void> deleteAd(int id);
  void filterAds();
  showAd(int id);
  Future<void> showAdDetailsDialog(int id);
}

class AdsManagementControllerImp extends AdsManagementController {
  bool loading = false;
  AdsData adsData = AdsData();
  List<AdModel> ads = [];
  List<AdModel> filteredAds = [];
  AdModel? adModel;
  late PaganationDataModel paganationDataModel;
  @override
  void onInit() {
    super.onInit();
    getAdsData(pageIndex: 1);
    filterAds();
  }

  @override
  void updateActiveValue(String value) {
    activeValue = value;
    filterAds();
    update();
  }

  @override
  Future<void> getAdsData({required int pageIndex}) async {
    loading = true;
    update();
    var response = await adsData.get(indexPage: pageIndex);
    if (response.isSuccess) {
      ads = List.generate(response.data.length,
          (index) => AdModel.fromJson(response.data[index]));
      paganationDataModel = PaganationDataModel.fromJson(response.body['meta']);
      filterAds();
    }
    loading = false;
    update();
  }

  @override
  Future<void> showAd(int id) async {
    loading = true;
    update();
    Get.parameters.clear();
    var response = await adsData.show(id);
    if (response.isSuccess) {
      adModel = AdModel.fromJson(response.data);
    }

    loading = false;
    update();
  }

  @override
  Future<void> showAdDetailsDialog(int id) async {
    await showAd(id);
    if (adModel != null) {
      Get.dialog(
        AdDetailsDialog(
          adModel: adModel!,
        ),
      );
      update();
    } else {
      customSnackBar(
        'Error',
        'Category details not found!',
        snackType: SnackBarType.error,
      );
    }
  }

  @override
  Future<void> deleteAd(int id) async {
    showDeleteConfirmationDialog(
      title: 'Delete Confirmation',
      message: 'Are you sure you want to delete this item?',
      onConfirm: () async {
        loading = true;
        update();

        var response = await adsData.delete(id);

        if (response.isSuccess) {
          getAdsData(pageIndex: paganationDataModel.currentPage);
          customSnackBar(
            response.message!,
            '',
            snackType: SnackBarType.correct,
            snackPosition: SnackBarPosition.topEnd,
          );
          update();
        }

        loading = false;
        update();
      },
    );
  }

  @override
  void filterAds() {
    if (activeValue == 'All') {
      filteredAds = ads;
    } else {
      filteredAds = ads
          .where((ad) => (ad.isActive ? 'yes' : 'no')
              .toLowerCase()
              .contains(activeValue!.toLowerCase()))
          .toList();
    }
    update();
  }
}
