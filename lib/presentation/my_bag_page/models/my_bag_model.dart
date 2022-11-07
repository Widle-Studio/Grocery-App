import 'package:get/get.dart';import 'package:grocery_app/data/models/selectionPopupModel/selection_popup_model.dart';import 'listtime_item_model.dart';import 'listrectangleone_item_model.dart';class MyBagModel {RxList<SelectionPopupModel> dropdownItemList = [SelectionPopupModel(id:1,title:"test",isSelected:true,),SelectionPopupModel(id:2,title:"test1",),SelectionPopupModel(id:3,title:"test2",)].obs;

RxList<ListtimeItemModel> listtimeItemList = RxList.filled(2,ListtimeItemModel());

RxList<ListrectangleoneItemModel> listrectangleoneItemList = RxList.filled(2,ListrectangleoneItemModel());

 }
