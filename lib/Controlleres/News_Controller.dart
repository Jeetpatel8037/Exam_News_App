import 'package:get/get.dart';

import '../Modals/Details_Modals.dart';

class HomeController extends GetxController{
  Rx<DetailModal> d1 = DetailModal().obs;
  RxList<Map> datalist = <Map>[].obs;
}
