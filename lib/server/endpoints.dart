class EndPoints {
  static String baseurl = //https://mcare.careofme.net/api
      //http://192.168.1.160:9898/api
      'https://engazegy.com/shanab/public/api/v1';
  static Map<dynamic, dynamic> segments = {
    "countries": "/countries",
    "cities": "/cities",
    "registernormal": "/user/register",
    "registerprovider": "/provider/register",
    "categories": "/categories",
    "login": "/login",
    "sendcode": "/sendCode",
    "checkcode": "/checkCode",
    "changepassword": "/updatePassword",
    "gethomedata": "/home",
    "offerdetails": "/offer/",
    "categorydetails": "/category/",
    "addreserve": "/reservation",
    "userreservations": "/reservations",
    "reservationforp": "/provider/reservations",
    "offer": "/offer",
    "provideroffers": "/provider/offers",
    "providercategories": "/userCategories",
    "category": "/category",
    "categories": "/categories",
    "getprofile": "/profile",
    "acceptResrve": "/acceptReservation",
    "refuserReserve": "/refuseReservation",
    "getpolices":"/policy",
    "getroles":"/rules",
    "getaboutus":"/aboutus",


  };
}
