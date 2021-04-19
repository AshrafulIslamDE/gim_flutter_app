class ScreenView {
  static const DRAWER_SCREENS = [
    _CREATE_TRIP,
    _REQUESTED_TRIPS,
    _NOTIFICATIONS,
    _PROFILE,
    _DASHBOARD,
    _REFERRAL_DASHBOARD,
    _PAYMENT_DUE,
    _LEGAL,
    _TRACKER
  ];

  static const TRIP_SCREENS = [
    _REQUESTED_TRIPS,
    _BOOKED_TRIPS,
    _LIVE_TRIPS,
    _HISTORY_TRIPS,
  ];

  static const REF_SCREENS = [
    _REFERRAL_DASHBOARD,
    _REFERRAL_HISTORY,
  ];

  static const PAY_SCREENS = [
    _PAYMENT_DUE,
    _PAYMENT_PAID,
  ];

  static const SPLASH = "Splash";
  static const ON_BOARD = "OnBoard";
  static const _NOTIFICATIONS = "Notifications";
  static const _DASHBOARD = "Dashboard";
  static const _CREATE_TRIP = "Create Trip";
  static const _REQUESTED_TRIPS = "Requested Trips";
  static const _BOOKED_TRIPS = "Booked Trips";
  static const _LIVE_TRIPS = "Live Trips";
  static const _HISTORY_TRIPS = "History Trips";
  static const AVAILABLE_TRIPS = "Available Trips";
  static const _PROFILE = "Profile";
  static const INVOICE = "Invoice";
  static const RECEIPT = "Receipt";
  static const BOOKED_TRIP_DETAILS = "Booked Trip Details";
  static const TRIP_DETAILS = "Trip Details";
  static const BID_LISTING = "BID List";
  static const _REFERRAL_DASHBOARD = "Referral Dashboard";
  static const _REFERRAL_HISTORY = "Referral History";
  static const ABOUT_US = "About Us";
  static const ON_BOARDING_TOUR = "On Boarding Tour";
  static const TERMS = "Terms & Conditions";
  static const PRIVACY = "Privacy Policy";
  static const HELP_CENTER = "Help Center";
  static const OS_LICENSE = "Open Source Licenses";
  static const CHANGE_PASSWORD = "Change Password";
  static const _PAYMENT_DUE = "Payment Due";
  static const _PAYMENT_PAID = "Payment Paid";
  static const _LEGAL = "Legal";
  static const _TRACKER = "Tracker";
  static const PARTNER_RATING = "Partner Rating";
}

class AnalyticsParams {
  static const USER_ROLE = {"user_role" : "customer"};
  static const TIME_SECONDS = "time_seconds";
  static const FLEET_OWNER_NAME = "fleet_owner_name";
  static const TRIP_CANCEL_REASON = "cancel_reason";
  static const FROM_DATE = "from_date";
  static const TO_DATE = "to_date";
  static const GOODS_TYPE = "goods_type";
}

class AnalyticsEvents {
  static const SIGN_IN_BUTTON = "sign_in_button";
  static const SIGN_IN = "sign_in";
  static const SIGN_OUT = "sign_out";
  static const SESSION_SIGN_OUT = "session_sign_out";

  static const SIGN_UP_MOBILE_VERIFICATION = "sign_up_mobile_verification";
  static const SIGN_UP_OTP_VERIFICATION = "sign_up_otp_verification";
  static const SIGN_UP_PERSONAL_INFO = "sign_up_personal_info";
  static const SIGN_UP_COMPLETE = "sign_up_complete";
  static const SIGN_UP_COMPLETE_WITH_REFERRAL = "sign_up_complete_referral";

  static const EVENT_CHANGE_PASSWORD = "change_password";

  static const EVENT_CREATE_TRIP_PICKER = "create_trip_picker";
  static const EVENT_CREATE_TRIP_ADDRESS_SELECT = "create_trip_address_select";
  static const EVENT_CREATE_TRIP_ADDITIONAL_DETAILS = "create_trip_additional"
      "_details";
  static const EVENT_CREATE_TRIP_SUBMIT = "create_trip_submit";
  static const EVENT_CREATE_TRIP_SUCCESS = "create_trip_success";
  static const EVENT_BID_ACCEPTED = "bid_accepted";
  static const EVENT_COMPLETE_TRIP = "complete_trip";
  static const EVENT_START_TRIP = "start_trip";
  static const EVENT_CANCEL_TRIP = "cancel_trip";
  static const EVENT_RATING_BY_CUSTOMER = "rating_by_customer";
  static const EVENT_REFERRAL_INVITE = "referral_invite";
  static const EVENT_FILTER_DASHBOARD = "filter_dashboard";
  static const EVENT_CUSTOMER_SUPPORT_CALL = "customer_support_call";
}
