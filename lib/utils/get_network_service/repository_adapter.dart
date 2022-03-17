import 'package:solo_luxury/data/model/Home/banner_list_model.dart';
import 'package:solo_luxury/data/model/RecommendedProducts/recommended_products_model.dart';
import 'package:solo_luxury/data/model/checkout_order/shipping_information_model.dart';
import 'package:solo_luxury/data/model/contact_us_response_model.dart';
import 'package:solo_luxury/data/model/myAccount/my_account_model.dart';
import 'package:solo_luxury/data/model/signup_response_model.dart';
import '../../data/model/Home/menu_model.dart';

import '../../data/model/InfluenceRegistration/influencer_registration_model.dart';
import '../../data/model/checkout_order/multi_address_model.dart';

abstract class ISplashRepository {
  Future<String> getSplashAPIResponse();
}
abstract class IReferFriendRepository {
  Future<String> getReferFriendAPIResponse();
}

abstract class ILoginRepository {
  Future<String> getLoginAPIResponse(
      String loginRequestJson, String userName, String password);
}

abstract class ISignupRepository {
  Future<SignUpResponseModel> getSignupAPIResponse(String signupRequestJson);
}

abstract class IInfluencerRepository {
  Future<InfluencerRegistrationMethodModel> getInfluencerAPIResponse(
      String influencerRequestJson);
}

abstract class IDashboardRepository {
  Future<MenuModel> getMenuAPIResponse();
  Future<BannerListModel> getBannerListAPIResponse();

}

abstract class IHomeRepository {

}

abstract class ICountryRepository {
  Future<String> getStoreWebsitesAPIResponse();

  Future<String> getStoreViewsAPIResponse();

  Future<String> getStoreConfigsAPIResponse();
}

abstract class ICheckoutOrderRepository {
  Future<String> postEstimateAPIResponse(String requestJson);
  Future<ShippingInformationModel> postShippingInformationAPIResponse(String requestJson);
  Future<String> getMultiAddressAPIResponse();
}

///myAccount Class
abstract class IMyAccountRepository {
  Future<MyAccountDetails> getMyAccountApiResponse();
}

abstract class IContactUsRepository {
  Future<ContactUsResponseModel> getContactUsApiResponse(
      String contactusRequestJson, String orderNo,
      String country,
      String subject,
      String message,
      String sourceOfTicket,
      String phoneNumber,
      String typeOfEnquiry,
      String email,
      String name,
      String lastName);
}
///RecommendedProduct Class
abstract class IRecommendedProductsRepository {
  Future<RecommendedProductModel> getMyAccountApiResponse();
}

abstract class ICountryListRepository {
  Future<String> getCountryListResponse();
  Future<String> postaddAddressApiResponse(String response);
}
