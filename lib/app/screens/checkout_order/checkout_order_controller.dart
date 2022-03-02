// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solo_luxury/data/model/Home/menu_model.dart';
import 'package:solo_luxury/data/model/Home/shipping_information_model.dart';
import 'package:solo_luxury/utils/repository/network_repository.dart';

import '../../../data/model/Home/estimate_shipping_method_model.dart';
import '../home/home_controller.dart';

class CheckoutOrderController extends GetxController {
  Rx<EstimateShippingMethodModel>? estimateShipModel = EstimateShippingMethodModel().obs;
  Rx<ShippingInformationModel>? shipInfoModel = ShippingInformationModel().obs;
  RxList? estimatesList = [].obs;
  RxInt selectedShippingIndex= 0.obs;
  RxInt selectedPaymentIndex= 0.obs;
  RxBool isShowItems= true.obs;
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();

  @override
  void onInit() {
    super.onInit();
    getEstimateAndShipInformationFromApi();
  }

  getEstimateAndShipInformationFromApi() async {
    if(estimatesList!=null){
      estimatesList?.value = [];
      estimatesList?.value = await NetworkRepository().postEstimateShippingMethod()??[];
    }

    shipInfoModel!.value = await NetworkRepository().postShippingInformation();
  }

}
