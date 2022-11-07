import '/core/app_export.dart';import 'package:grocery_app/presentation/payment_screen/models/payment_model.dart';class PaymentController extends GetxController {Rx<PaymentModel> paymentModelObj = PaymentModel().obs;

@override void onReady() { super.onReady(); } 
@override void onClose() { super.onClose(); } 
 }
