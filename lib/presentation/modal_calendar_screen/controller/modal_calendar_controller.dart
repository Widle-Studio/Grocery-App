import '/core/app_export.dart';import 'package:grocery_app/presentation/modal_calendar_screen/models/modal_calendar_model.dart';class ModalCalendarController extends GetxController {Rx<ModalCalendarModel> modalCalendarModelObj = ModalCalendarModel().obs;

SelectionPopupModel? selectedDropDownValue;

@override void onReady() { super.onReady(); } 
@override void onClose() { super.onClose(); } 
onSelected(dynamic value) { selectedDropDownValue = value as SelectionPopupModel; modalCalendarModelObj.value.dropdownItemList.forEach((element) {element.isSelected = false; if (element.id == value.id) {element.isSelected = true;}}); modalCalendarModelObj.value.dropdownItemList.refresh(); } 
 }
