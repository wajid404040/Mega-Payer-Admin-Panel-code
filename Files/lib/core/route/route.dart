import 'package:get/get.dart';
import 'package:local_coin/core/helper/shared_pref_helper.dart';
import 'package:local_coin/data/model/user/user.dart';
import 'package:local_coin/view/screens/account/deposit_history_screen/deposit_history_screen.dart';
import 'package:local_coin/view/screens/account/withdrawls_history_screen/withdrawals_history_screen.dart';
import 'package:local_coin/view/screens/advertisement/add_advertisement_screen/new_advertisement_screen.dart';
import 'package:local_coin/view/screens/advertisement/advertisement_review/advertisement_review_screen.dart';
import 'package:local_coin/view/screens/advertisement/advertisement_screen.dart';
import 'package:local_coin/view/screens/auth/kyc/kyc.dart';
import 'package:local_coin/view/screens/auth/two_factor/two_factor_screen/two_factor_verification_screen.dart';
import 'package:local_coin/view/screens/auth/two_factor/two_factor_setup_screen/two_factor_setup_screen.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/marketplace_screen/market_place_screen.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/menu_screen/menu_screen.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/trade/make_a_trade_screen/make_a_trade_screen.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/trade/trade_details_screen/trade_details_screen.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/wallet_screen/wallet_screen.dart';
import 'package:local_coin/view/screens/client_profile_screen/client_profile_screen.dart';
import 'package:local_coin/view/screens/faq/faq_screen.dart';
import 'package:local_coin/view/screens/filter_result_screen/filter_result_screen.dart';
import 'package:local_coin/view/screens/filter_screen/filter_screen.dart';
import 'package:local_coin/view/screens/language/language_screen.dart';
import 'package:local_coin/view/screens/lock_screen/create_new_pin_screen/create_new_pin_screen.dart';
import 'package:local_coin/view/screens/lock_screen/verify_lock_pin_screen/verify_lock_pin_screen.dart';
import 'package:local_coin/view/screens/notification/notification_screen.dart';
import 'package:local_coin/view/screens/preview_image/preview_image_screen.dart';
import 'package:local_coin/view/screens/referral/referral_screen.dart';
import 'package:local_coin/view/screens/supportTicket/new_ticket_screen/new_ticket_screen.dart';
import 'package:local_coin/view/screens/supportTicket/support_ticket_methods_screen/support_ticket_methods_screen.dart';
import 'package:local_coin/view/screens/supportTicket/ticket_details/ticket_details.dart';
import 'package:local_coin/view/screens/supportTicket/ticket_screen.dart';
import 'package:local_coin/view/screens/transactions/single_wallet_transaction.dart';
import 'package:local_coin/view/screens/transactions/transactions_screen.dart';
import 'package:local_coin/view/screens/wallet_address_screen/wallet_address_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../view/screens/about/privacy_screen.dart';
import '../../view/screens/account/change_password/change_password.dart';
import '../../view/screens/account/profile_complete_screen/profile_complete_screen.dart';
import '../../view/screens/account/profile/profile_screen.dart';
import '../../view/screens/advertisement/edit_advertisement_screen/edit_advertisement_screen.dart';
import '../../view/screens/auth/email_verification_page/email_verification_screen.dart';
import '../../view/screens/auth/forget_password/forget_password_screen/forget_password.dart';
import '../../view/screens/auth/forget_password/reset_pass_screen/reset_pass_screen.dart';
import '../../view/screens/auth/forget_password/verify_forget_password_code_screen/verify_forget_pass_code.dart';
import '../../view/screens/auth/login/login.dart';
import '../../view/screens/auth/registration/registration_screen.dart';
import '../../view/screens/auth/sms_verification_page/sms_verification_screen.dart';
import '../../view/screens/bottom_nav_pages/home/home_screen.dart';
import '../../view/screens/bottom_nav_pages/trade/trade_screen/trade_screen.dart';
import '../../view/screens/splash/splash_screen.dart';
import '../../view/screens/withdraw/previous_withdraw_screen/previous_withdraw_screen.dart';
import '../../view/screens/withdraw/withdraw_screen/withdraw_screen.dart';

class RouteHelper {
  static const String splashScreen = '/splash-screen';

  static const String loginScreen = '/login-screen';
  static const String onboardScreen = '/onboard-screen';
  static const String registrationScreen = '/signup-screen';
  static const String emailVerificationScreen = '/verify-email-screen';
  static const String smsVerificationScreen = '/verify-sms-screen';
  static const String forgetPasswordScreen = '/forget-password-screen';
  static const String verifyPassCodeScreen = '/verify-pass-code-screen';
  static const String resetPasswordScreen = '/reset-pass-screen';
  static const String homeScreen = '/dashboard-screen';
  static const String profileScreen = '/profile-screen';
  static const String profileComplete = '/profile-complete-screen';
  static const String changePasswordScreen = '/change-password-screen';
  static const String twoFactorScreen = '/two-factor-screen';
  static const String paymentHistoryScreen = '/payment-screen';
  static const String privacyScreen = '/privacy-screen';

  static const String createPinScreen = '/create-pin-screen';
  static const String verifyPinScreen = '/verify-pin-screen';

  //filter screen
  static const String filterScreen = '/filter-screen';
  static const String filterResultScreen = '/filter-result-screen';

  //bottom nav item
  static const String walletScreen = '/wallet-screen';
  static const String tradeScreen = '/trade-screen';
  static const String marketPlaceScreen = '/marketplace-screen';
  static const String menuScreen = '/menu-screen';

  static const String tradeDetailsScreen = '/trade-details-screen';

  //menu screen
  static const String referralScreen = '/referral-screen';
  static const String advertisementScreen = '/advertisement-screen';
  static const String advertisementReviewScreen = '/advertisement-review';
  static const String newAdvertisementScreen = '/add-advertisement-screen';
  static const String editAdvertisementScreen = '/edit-advertisement-screen';
  static const String transactionScreen = '/transaction-screen';
  static const String singleWalletTransaction = '/single-wallet-transaction-screen';
  static const String depositHistoryScreen = '/deposit-history-screen';
  static const String withdrawHistoryScreen = '/withdraw-history-screen';

  static const String walletAddressScreen = '/wallet-address-screen';

  static const String addWithdrawScreen = '/withdraw_screen';
  static const String previousWithdrawalScreen = '/previous-withdrawals-screen';

  static const String confirmWithdrawRequest = '/confirm_withdraw_screen';

  //client profile screen
  static const String clientProfileScreen = '/client-profile-screen';
  static const String makeATradeScreen = '/make-a-trade-screen';

  //kyc
  static const String kycScreen = '/kyc_screen';
  //notification
  static const String notificationScreen = '/notification_screen';
  static const String languageScreen = '/language_screen';
  static const String faqScreen = '/faq_screen';
  static const String twoFactorSetupScreen = '/twoFactorSetup_screen';

  static const String supportTicketMethodsList = '/all_ticket_methods';
  static const String allTicketScreen = '/all_ticket_screen';
  static const String ticketDetailsdScreen = '/ticket_details_screen';
  static const String newTicketScreen = '/new_ticket_screen';
  static const String previewImageScreen = "/preview-image-screen";

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: privacyScreen, page: () => const PrivacyScreen()),
    GetPage(name: profileScreen, page: () => const ProfileScreen()),
    GetPage(name: profileComplete, page: () => const ProfileCompleteScreen()),
    GetPage(name: changePasswordScreen, page: () => const ChangePasswordScreen()),
    GetPage(name: depositHistoryScreen, page: () => const DepositHistoryScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: registrationScreen, page: () => const RegistrationScreen()),
    GetPage(name: emailVerificationScreen, page: () => const EmailVerificationScreen()),
    GetPage(name: smsVerificationScreen, page: () => const SmsVerificationScreen()),
    GetPage(name: forgetPasswordScreen, page: () => const ForgetPasswordScreen()),
    GetPage(name: verifyPassCodeScreen, page: () => const VerifyForgetPassScreen()),
    GetPage(name: resetPasswordScreen, page: () => const ResetPasswordScreen()),
    GetPage(name: homeScreen, page: () => const HomeScreen()),

    //filter screen
    GetPage(name: filterScreen, page: () => const FilterScreen()),
    GetPage(name: filterResultScreen, page: () => const FilterResultScreen()),

    //bottom nav
    GetPage(name: walletScreen, page: () => const WalletScreen()),
    GetPage(name: tradeScreen, page: () => const TradeScreen()),
    GetPage(name: marketPlaceScreen, page: () => const MarketPlaceScreen()),
    GetPage(name: menuScreen, page: () => const MenuScreen()),
    GetPage(name: withdrawHistoryScreen, page: () => const WithdrawHistoryScreen()),

    //client profile screen
    GetPage(name: clientProfileScreen, page: () => const ClientProfileScreen()),

    GetPage(name: makeATradeScreen, page: () => const MakeATradeScreen()),
    GetPage(name: tradeDetailsScreen, page: () => const TradeDetailsScreen()),

    //wallet address
    GetPage(name: walletAddressScreen, page: () => const WalletAddressScreen()),

    //withdraw
    GetPage(name: addWithdrawScreen, page: () => const WithdrawScreen()),
    GetPage(name: previousWithdrawalScreen, page: () => const PreviousWithdrawScreen()),

    //menu screen
    GetPage(name: referralScreen, page: () => const ReferralScreen()),
    GetPage(name: advertisementScreen, page: () => const AdvertisementScreen()),
    GetPage(name: advertisementReviewScreen, page: () => const AdvertisementReviewScreen()),
    GetPage(name: newAdvertisementScreen, page: () => const NewAdvertisementScreen()),
    GetPage(name: editAdvertisementScreen, page: () => const EditAdvertisementScreen()),
    GetPage(name: transactionScreen, page: () => const TransactionScreen()),
    GetPage(name: singleWalletTransaction, page: () => const SingleWalletTransactionScreen()),
    GetPage(name: kycScreen, page: () => const KycScreen()),
    GetPage(name: notificationScreen, page: () => const NotificationScreen()),
    GetPage(name: twoFactorScreen, page: () => const TwoFactorVerificationScreen()),
    GetPage(name: createPinScreen, page: () => const CreateNewPinScreen()),
    GetPage(name: verifyPinScreen, page: () => const VerifyLockPinScreen()),

    GetPage(name: languageScreen, page: () => const LanguageScreen()),
    GetPage(name: faqScreen, page: () => const FaqScreen()),
    GetPage(name: twoFactorSetupScreen, page: () => const TwoFactorSetupScreen()),

    GetPage(name: supportTicketMethodsList, page: () => const SupportTicketMethodsList()),
    GetPage(name: allTicketScreen, page: () => const AllTicketScreen()),
    GetPage(name: ticketDetailsdScreen, page: () => const TicketDetailsScreen()),
    GetPage(name: newTicketScreen, page: () => const NewTicketScreen()),
    GetPage(name: previewImageScreen, page: () => PreviewImage(url: Get.arguments)),
  ];

  static Future<void> checkUserStatusAndGoToNextStep(GlobalUser? user, {bool isRemember = false, String accessToken = "", String tokenType = ""}) async {
    bool needEmailVerification = user?.ev == "1" ? false : true;
    bool needSmsVerification = user?.sv == '1' ? false : true;
    bool isTwoFactorEnable = user?.tv == '1' ? false : true;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (isRemember) {
      await sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, true);
    } else {
      await sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
    }

    await sharedPreferences.setString(SharedPreferenceHelper.userIdKey, user?.id.toString() ?? '-1');
    await sharedPreferences.setString(SharedPreferenceHelper.userEmailKey, user?.email ?? '');
    await sharedPreferences.setString(SharedPreferenceHelper.userPhoneNumberKey, user?.mobile ?? '');
    await sharedPreferences.setString(SharedPreferenceHelper.userNameKey, user?.username ?? '');

    if (accessToken.isNotEmpty) {
      await sharedPreferences.setString(SharedPreferenceHelper.accessTokenKey, accessToken);
      await sharedPreferences.setString(SharedPreferenceHelper.accessTokenType, tokenType);
    }

    bool isProfileCompleteEnable = user?.profileComplete == '0' ? true : false;

    if (isProfileCompleteEnable) {
      Get.offAndToNamed(RouteHelper.profileComplete);
    } else if (needEmailVerification) {
      Get.offAndToNamed(RouteHelper.emailVerificationScreen);
    } else if (needSmsVerification) {
      Get.offAndToNamed(RouteHelper.smsVerificationScreen);
    } else if (isTwoFactorEnable) {
      Get.offAndToNamed(RouteHelper.twoFactorScreen);
    } else {
      String pin = sharedPreferences.getString(SharedPreferenceHelper.screenLockPin) ?? '';
      if (pin.isEmpty || pin == 'null') {
        Get.offAndToNamed(RouteHelper.createPinScreen);
      } else {
        Get.offAllNamed(RouteHelper.homeScreen);
      }
    }
  }
}
