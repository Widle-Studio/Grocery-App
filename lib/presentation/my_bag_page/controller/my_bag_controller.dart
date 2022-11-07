import '/core/app_export.dart';import 'package:grocery_app/presentation/my_bag_page/models/my_bag_model.dart';class MyBagController extends GetxController {MyBagController(this.myBagModelObj);

Rx<MyBagModel> myBagModelObj;

SelectionPopupModel? selectedDropDownValue;

@override void onReady() { super.onReady(); } 
@override void onClose() { super.onClose(); } 
onSelected(dynamic value) { selectedDropDownValue = value as SelectionPopupModel; myBagModelObj.value.dropdownItemList.forEach((element) {element.isSelected = false; if (element.id == value.id) {element.isSelected = true;}}); myBagModelObj.value.dropdownItemList.refresh(); } 
 }
