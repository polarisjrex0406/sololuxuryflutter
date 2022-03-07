import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solo_luxury/app/components/expandable_container.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solo_luxury/data/model/Home/menu_model.dart';
import 'package:solo_luxury/data/model/Home/shipping_information_model.dart';
import 'package:solo_luxury/utils/repository/network_repository.dart';

import '../../../data/model/Home/estimate_shipping_method_model.dart';
import '../../../utils/get_network_service/APIRepository/home_api_repository.dart';

class HomeController extends GetxController {
  RxInt index = 0.obs;
  Rx<GlobalKey<ScaffoldState>> scaffoldKey = GlobalKey<ScaffoldState>().obs;

  Rx<ExpandableController> aboutUsExpandableController = ExpandableController().obs;
  RxObjectMixin? menuModel = MenuModel().obs;
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();
  final HomeAPIRepository homeAPIRepository;
  HomeController({required this.homeAPIRepository});

  @override
  void onInit() {
    super.onInit();
    getMenuDataFromApi();
  }

  getMenuDataFromApi() async {
    print("getMenuDataFromApi -> ");
    //menuModel!.value = await NetworkRepository().getMenu();
    menuModel!.value = await homeAPIRepository.getMenuAPIResponse();
  }
}
