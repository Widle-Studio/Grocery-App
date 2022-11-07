import 'package:get/get.dart';import 'package:grocery_app/data/models/selectionPopupModel/selection_popup_model.dart';import 'listlabel_eight_item_model.dart';class ModalCalendarModel {RxList<SelectionPopupModel> dropdownItemList = [SelectionPopupModel(id:1,title:"test",isSelected:true,),SelectionPopupModel(id:2,title:"test1",),SelectionPopupModel(id:3,title:"test2",)].obs;

RxList<ListlabelEightItemModel> listlabelEightItemList = RxList.filled(4,ListlabelEightItemModel());

 }
