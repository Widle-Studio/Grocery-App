import 'package:grocery_app/presentation/delivery_details_screen/delivery_details_screen.dart';
import 'package:grocery_app/presentation/delivery_details_screen/binding/delivery_details_binding.dart';
import 'package:grocery_app/presentation/splash_screen/splash_screen.dart';
import 'package:grocery_app/presentation/splash_screen/binding/splash_binding.dart';
import 'package:grocery_app/presentation/home_container_screen/home_container_screen.dart';
import 'package:grocery_app/presentation/home_container_screen/binding/home_container_binding.dart';
import 'package:grocery_app/presentation/product_details_screen/product_details_screen.dart';
import 'package:grocery_app/presentation/product_details_screen/binding/product_details_binding.dart';
import 'package:grocery_app/presentation/products_screen/products_screen.dart';
import 'package:grocery_app/presentation/products_screen/binding/products_binding.dart';
import 'package:grocery_app/presentation/orders_history_screen/orders_history_screen.dart';
import 'package:grocery_app/presentation/orders_history_screen/binding/orders_history_binding.dart';
import 'package:grocery_app/presentation/more_wishlist_screen/more_wishlist_screen.dart';
import 'package:grocery_app/presentation/more_wishlist_screen/binding/more_wishlist_binding.dart';
import 'package:grocery_app/presentation/notifications_screen/notifications_screen.dart';
import 'package:grocery_app/presentation/notifications_screen/binding/notifications_binding.dart';
import 'package:grocery_app/presentation/wishlist_screen/wishlist_screen.dart';
import 'package:grocery_app/presentation/wishlist_screen/binding/wishlist_binding.dart';
import 'package:grocery_app/presentation/wishlist_filled_screen/wishlist_filled_screen.dart';
import 'package:grocery_app/presentation/wishlist_filled_screen/binding/wishlist_filled_binding.dart';
import 'package:grocery_app/presentation/more_wishlist_details_screen/more_wishlist_details_screen.dart';
import 'package:grocery_app/presentation/more_wishlist_details_screen/binding/more_wishlist_details_binding.dart';
import 'package:grocery_app/presentation/edit_profile_screen/edit_profile_screen.dart';
import 'package:grocery_app/presentation/edit_profile_screen/binding/edit_profile_binding.dart';
import 'package:grocery_app/presentation/my_addresses_screen/my_addresses_screen.dart';
import 'package:grocery_app/presentation/my_addresses_screen/binding/my_addresses_binding.dart';
import 'package:grocery_app/presentation/select_loaction_screen/select_loaction_screen.dart';
import 'package:grocery_app/presentation/select_loaction_screen/binding/select_loaction_binding.dart';
import 'package:grocery_app/presentation/splash_phone_number_screen/splash_phone_number_screen.dart';
import 'package:grocery_app/presentation/splash_phone_number_screen/binding/splash_phone_number_binding.dart';
import 'package:grocery_app/presentation/splash_phone_number_preregisterd_screen/splash_phone_number_preregisterd_screen.dart';
import 'package:grocery_app/presentation/splash_phone_number_preregisterd_screen/binding/splash_phone_number_preregisterd_binding.dart';
import 'package:grocery_app/presentation/splash_phone_number_otp_screen/splash_phone_number_otp_screen.dart';
import 'package:grocery_app/presentation/splash_phone_number_otp_screen/binding/splash_phone_number_otp_binding.dart';
import 'package:grocery_app/presentation/new_registration_screen/new_registration_screen.dart';
import 'package:grocery_app/presentation/new_registration_screen/binding/new_registration_binding.dart';
import 'package:grocery_app/presentation/new_registration_password_screen/new_registration_password_screen.dart';
import 'package:grocery_app/presentation/new_registration_password_screen/binding/new_registration_password_binding.dart';
import 'package:grocery_app/presentation/orders_category_screen/orders_category_screen.dart';
import 'package:grocery_app/presentation/orders_category_screen/binding/orders_category_binding.dart';
import 'package:grocery_app/presentation/search_screen/search_screen.dart';
import 'package:grocery_app/presentation/search_screen/binding/search_binding.dart';
import 'package:grocery_app/presentation/search_search_result_screen/search_search_result_screen.dart';
import 'package:grocery_app/presentation/search_search_result_screen/binding/search_search_result_binding.dart';
import 'package:grocery_app/presentation/search_search_result_not_availabale_screen/search_search_result_not_availabale_screen.dart';
import 'package:grocery_app/presentation/search_search_result_not_availabale_screen/binding/search_search_result_not_availabale_binding.dart';
import 'package:grocery_app/presentation/payment_screen/payment_screen.dart';
import 'package:grocery_app/presentation/payment_screen/binding/payment_binding.dart';
import 'package:grocery_app/presentation/customer_support_screen/customer_support_screen.dart';
import 'package:grocery_app/presentation/customer_support_screen/binding/customer_support_binding.dart';
import 'package:grocery_app/presentation/customer_support_chat_screen/customer_support_chat_screen.dart';
import 'package:grocery_app/presentation/customer_support_chat_screen/binding/customer_support_chat_binding.dart';
import 'package:grocery_app/presentation/customer_support_chat_keyboard_screen/customer_support_chat_keyboard_screen.dart';
import 'package:grocery_app/presentation/customer_support_chat_keyboard_screen/binding/customer_support_chat_keyboard_binding.dart';
import 'package:grocery_app/presentation/modal_calendar_screen/modal_calendar_screen.dart';
import 'package:grocery_app/presentation/modal_calendar_screen/binding/modal_calendar_binding.dart';
import 'package:grocery_app/presentation/modal_filter_screen/modal_filter_screen.dart';
import 'package:grocery_app/presentation/modal_filter_screen/binding/modal_filter_binding.dart';
import 'package:grocery_app/presentation/modal_confirmation_screen/modal_confirmation_screen.dart';
import 'package:grocery_app/presentation/modal_confirmation_screen/binding/modal_confirmation_binding.dart';
import 'package:grocery_app/presentation/order_processing_collapsed_screen/order_processing_collapsed_screen.dart';
import 'package:grocery_app/presentation/order_processing_collapsed_screen/binding/order_processing_collapsed_binding.dart';
import 'package:grocery_app/presentation/order_scheduled_expanded_screen/order_scheduled_expanded_screen.dart';
import 'package:grocery_app/presentation/order_scheduled_expanded_screen/binding/order_scheduled_expanded_binding.dart';
import 'package:grocery_app/presentation/order_scheduled_expanded_two_screen/order_scheduled_expanded_two_screen.dart';
import 'package:grocery_app/presentation/order_scheduled_expanded_two_screen/binding/order_scheduled_expanded_two_binding.dart';
import 'package:grocery_app/presentation/order_scheduled_expanded_three_screen/order_scheduled_expanded_three_screen.dart';
import 'package:grocery_app/presentation/order_scheduled_expanded_three_screen/binding/order_scheduled_expanded_three_binding.dart';
import 'package:grocery_app/presentation/order_scheduled_expanded_one_screen/order_scheduled_expanded_one_screen.dart';
import 'package:grocery_app/presentation/order_scheduled_expanded_one_screen/binding/order_scheduled_expanded_one_binding.dart';
import 'package:grocery_app/presentation/full_package_details_screen/full_package_details_screen.dart';
import 'package:grocery_app/presentation/full_package_details_screen/binding/full_package_details_binding.dart';
import 'package:grocery_app/presentation/modal_rating_screen/modal_rating_screen.dart';
import 'package:grocery_app/presentation/modal_rating_screen/binding/modal_rating_binding.dart';
import 'package:grocery_app/presentation/order_completed_screen/order_completed_screen.dart';
import 'package:grocery_app/presentation/order_completed_screen/binding/order_completed_binding.dart';
import 'package:grocery_app/presentation/app_navigation_screen/app_navigation_screen.dart';
import 'package:grocery_app/presentation/app_navigation_screen/binding/app_navigation_binding.dart';
import 'package:get/get.dart';

class AppRoutes {
  static String deliveryDetailsScreen = '/delivery_details_screen';

  static String splashScreen = '/splash_screen';

  static String homeContainerScreen = '/home_container_screen';

  static String productDetailsScreen = '/product_details_screen';

  static String productsScreen = '/products_screen';

  static String ordersHistoryScreen = '/orders_history_screen';

  static String moreWishlistScreen = '/more_wishlist_screen';

  static String notificationsScreen = '/notifications_screen';

  static String wishlistScreen = '/wishlist_screen';

  static String wishlistFilledScreen = '/wishlist_filled_screen';

  static String moreWishlistDetailsScreen = '/more_wishlist_details_screen';

  static String editProfileScreen = '/edit_profile_screen';

  static String myAddressesScreen = '/my_addresses_screen';

  static String selectLoactionScreen = '/select_loaction_screen';

  static String splashPhoneNumberScreen = '/splash_phone_number_screen';

  static String splashPhoneNumberPreregisterdScreen =
      '/splash_phone_number_preregisterd_screen';

  static String splashPhoneNumberOtpScreen = '/splash_phone_number_otp_screen';

  static String newRegistrationScreen = '/new_registration_screen';

  static String newRegistrationPasswordScreen =
      '/new_registration_password_screen';

  static String ordersCategoryScreen = '/orders_category_screen';

  static String searchScreen = '/search_screen';

  static String searchSearchResultScreen = '/search_search_result_screen';

  static String searchSearchResultNotAvailabaleScreen =
      '/search_search_result_not_availabale_screen';

  static String paymentScreen = '/payment_screen';

  static String customerSupportScreen = '/customer_support_screen';

  static String customerSupportChatScreen = '/customer_support_chat_screen';

  static String customerSupportChatKeyboardScreen =
      '/customer_support_chat_keyboard_screen';

  static String modalCalendarScreen = '/modal_calendar_screen';

  static String modalFilterScreen = '/modal_filter_screen';

  static String modalConfirmationScreen = '/modal_confirmation_screen';

  static String orderProcessingCollapsedScreen =
      '/order_processing_collapsed_screen';

  static String orderScheduledExpandedScreen =
      '/order_scheduled_expanded_screen';

  static String orderScheduledExpandedTwoScreen =
      '/order_scheduled_expanded_two_screen';

  static String orderScheduledExpandedThreeScreen =
      '/order_scheduled_expanded_three_screen';

  static String orderScheduledExpandedOneScreen =
      '/order_scheduled_expanded_one_screen';

  static String fullPackageDetailsScreen = '/full_package_details_screen';

  static String modalRatingScreen = '/modal_rating_screen';

  static String orderCompletedScreen = '/order_completed_screen';

  static String appNavigationScreen = '/app_navigation_screen';

  static String initialRoute = '/initialRoute';

  static List<GetPage> pages = [
    GetPage(
      name: deliveryDetailsScreen,
      page: () => DeliveryDetailsScreen(),
      bindings: [
        DeliveryDetailsBinding(),
      ],
    ),
    GetPage(
      name: splashScreen,
      page: () => SplashScreen(),
      bindings: [
        SplashBinding(),
      ],
    ),
    GetPage(
      name: homeContainerScreen,
      page: () => HomeContainerScreen(),
      bindings: [
        HomeContainerBinding(),
      ],
    ),
    GetPage(
      name: productDetailsScreen,
      page: () => ProductDetailsScreen(),
      bindings: [
        ProductDetailsBinding(),
      ],
    ),
    GetPage(
      name: productsScreen,
      page: () => ProductsScreen(),
      bindings: [
        ProductsBinding(),
      ],
    ),
    GetPage(
      name: ordersHistoryScreen,
      page: () => OrdersHistoryScreen(),
      bindings: [
        OrdersHistoryBinding(),
      ],
    ),
    GetPage(
      name: moreWishlistScreen,
      page: () => MoreWishlistScreen(),
      bindings: [
        MoreWishlistBinding(),
      ],
    ),
    GetPage(
      name: notificationsScreen,
      page: () => NotificationsScreen(),
      bindings: [
        NotificationsBinding(),
      ],
    ),
    GetPage(
      name: wishlistScreen,
      page: () => WishlistScreen(),
      bindings: [
        WishlistBinding(),
      ],
    ),
    GetPage(
      name: wishlistFilledScreen,
      page: () => WishlistFilledScreen(),
      bindings: [
        WishlistFilledBinding(),
      ],
    ),
    GetPage(
      name: moreWishlistDetailsScreen,
      page: () => MoreWishlistDetailsScreen(),
      bindings: [
        MoreWishlistDetailsBinding(),
      ],
    ),
    GetPage(
      name: editProfileScreen,
      page: () => EditProfileScreen(),
      bindings: [
        EditProfileBinding(),
      ],
    ),
    GetPage(
      name: myAddressesScreen,
      page: () => MyAddressesScreen(),
      bindings: [
        MyAddressesBinding(),
      ],
    ),
    GetPage(
      name: selectLoactionScreen,
      page: () => SelectLoactionScreen(),
      bindings: [
        SelectLoactionBinding(),
      ],
    ),
    GetPage(
      name: splashPhoneNumberScreen,
      page: () => SplashPhoneNumberScreen(),
      bindings: [
        SplashPhoneNumberBinding(),
      ],
    ),
    GetPage(
      name: splashPhoneNumberPreregisterdScreen,
      page: () => SplashPhoneNumberPreregisterdScreen(),
      bindings: [
        SplashPhoneNumberPreregisterdBinding(),
      ],
    ),
    GetPage(
      name: splashPhoneNumberOtpScreen,
      page: () => SplashPhoneNumberOtpScreen(),
      bindings: [
        SplashPhoneNumberOtpBinding(),
      ],
    ),
    GetPage(
      name: newRegistrationScreen,
      page: () => NewRegistrationScreen(),
      bindings: [
        NewRegistrationBinding(),
      ],
    ),
    GetPage(
      name: newRegistrationPasswordScreen,
      page: () => NewRegistrationPasswordScreen(),
      bindings: [
        NewRegistrationPasswordBinding(),
      ],
    ),
    GetPage(
      name: ordersCategoryScreen,
      page: () => OrdersCategoryScreen(),
      bindings: [
        OrdersCategoryBinding(),
      ],
    ),
    GetPage(
      name: searchScreen,
      page: () => SearchScreen(),
      bindings: [
        SearchBinding(),
      ],
    ),
    GetPage(
      name: searchSearchResultScreen,
      page: () => SearchSearchResultScreen(),
      bindings: [
        SearchSearchResultBinding(),
      ],
    ),
    GetPage(
      name: searchSearchResultNotAvailabaleScreen,
      page: () => SearchSearchResultNotAvailabaleScreen(),
      bindings: [
        SearchSearchResultNotAvailabaleBinding(),
      ],
    ),
    GetPage(
      name: paymentScreen,
      page: () => PaymentScreen(),
      bindings: [
        PaymentBinding(),
      ],
    ),
    GetPage(
      name: customerSupportScreen,
      page: () => CustomerSupportScreen(),
      bindings: [
        CustomerSupportBinding(),
      ],
    ),
    GetPage(
      name: customerSupportChatScreen,
      page: () => CustomerSupportChatScreen(),
      bindings: [
        CustomerSupportChatBinding(),
      ],
    ),
    GetPage(
      name: customerSupportChatKeyboardScreen,
      page: () => CustomerSupportChatKeyboardScreen(),
      bindings: [
        CustomerSupportChatKeyboardBinding(),
      ],
    ),
    GetPage(
      name: modalCalendarScreen,
      page: () => ModalCalendarScreen(),
      bindings: [
        ModalCalendarBinding(),
      ],
    ),
    GetPage(
      name: modalFilterScreen,
      page: () => ModalFilterScreen(),
      bindings: [
        ModalFilterBinding(),
      ],
    ),
    GetPage(
      name: modalConfirmationScreen,
      page: () => ModalConfirmationScreen(),
      bindings: [
        ModalConfirmationBinding(),
      ],
    ),
    GetPage(
      name: orderProcessingCollapsedScreen,
      page: () => OrderProcessingCollapsedScreen(),
      bindings: [
        OrderProcessingCollapsedBinding(),
      ],
    ),
    GetPage(
      name: orderScheduledExpandedScreen,
      page: () => OrderScheduledExpandedScreen(),
      bindings: [
        OrderScheduledExpandedBinding(),
      ],
    ),
    GetPage(
      name: orderScheduledExpandedTwoScreen,
      page: () => OrderScheduledExpandedTwoScreen(),
      bindings: [
        OrderScheduledExpandedTwoBinding(),
      ],
    ),
    GetPage(
      name: orderScheduledExpandedThreeScreen,
      page: () => OrderScheduledExpandedThreeScreen(),
      bindings: [
        OrderScheduledExpandedThreeBinding(),
      ],
    ),
    GetPage(
      name: orderScheduledExpandedOneScreen,
      page: () => OrderScheduledExpandedOneScreen(),
      bindings: [
        OrderScheduledExpandedOneBinding(),
      ],
    ),
    GetPage(
      name: fullPackageDetailsScreen,
      page: () => FullPackageDetailsScreen(),
      bindings: [
        FullPackageDetailsBinding(),
      ],
    ),
    GetPage(
      name: modalRatingScreen,
      page: () => ModalRatingScreen(),
      bindings: [
        ModalRatingBinding(),
      ],
    ),
    GetPage(
      name: orderCompletedScreen,
      page: () => OrderCompletedScreen(),
      bindings: [
        OrderCompletedBinding(),
      ],
    ),
    GetPage(
      name: appNavigationScreen,
      page: () => AppNavigationScreen(),
      bindings: [
        AppNavigationBinding(),
      ],
    ),
    GetPage(
      name: initialRoute,
      page: () => SplashScreen(),
      bindings: [
        SplashBinding(),
      ],
    )
  ];
}
