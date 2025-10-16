import 'dart:ui';

import 'package:weeding_invitation/Data/Models/weeding.dart';

class InvitationContent {

  // Couple (Bride & Groome) Data 
  static const Wedding coupleData = Wedding(
    groomName: 'Asaad',
    brideName: 'Ward',
    groomEmail: '@gmail.com',
    brideEmail: '@gmail.com',
    day: 'السبت',
    date: '25 أكتوبر 2025',
    time: '09:30 AM',
    quote: 'وَالآنَ قَدِ اخْتَرْتُ وَقَدَّسْتُ هذَا الْبَيْتَ لِيَكُونَ اسْمِي فِيهِ إِلَى الأَبَدِ، وَتَكُونُ عَيْنَايَ وَقَلْبِي هُنَاكَ كُلَّ الأَيَّامِ. (2 أخبار 7:16)',
    church: 'كنيسة السيدة العذراء والأنبا شنودة',
    city: 'مدينة السلام',
    state: 'القاهرة',
    locationDetails: '( بجوار الطريق الدائري – بالقرب من قناة CTV )',
    mapLink: 'https://www.google.com/maps/dir//596V%2BH5V,+Galaxo,+Berket+an+Nasr,+Al+Salam+First,+Cairo+Governorate+4641606/@30.1614662,31.3105271,12z/data=!3m1!4b1!4m8!4m7!1m0!1m5!1m1!1s0x1458112c69aabecf:0xf510f4dc5d6f866!2m2!1d31.3926916!2d30.1615807?entry=ttu',
    calendarDate: '2025-10-25',
    details: 'تبدأ صلاة الإكليل الطقسي الساعة 09:30 صباحاً ويعقبها صلاة القداس الإلهي',
    logo: 'assets/image/Asaad & Ward.png',
  );


  // Header Section
  static String initialQuote = coupleData.quote;
  static const String inviteHeader = 'WE ARE INVITING YOU TO JOIN US AND CELEBRATE OUR MARRIAGE TOGETHER';
  
  // Event Info Section
  static const String witnessTitle = 'Bear witness to our special day';
  static const String dateLabel = 'التاريخ';
  static const String venueLabel = 'المكان';
  static const String openLocation = 'أفتح الموقع  ←  ';
  
  // Guests (RSVP) Form Section
  static const String formTitle = 'Your presence at our wedding is the only present we require';
  static const String nameLabel = 'الأسم';
  static const String attendingLabel = 'هل هتحضر الحفل  ؟';
  static const String howManyAttendeesLabel = 'عدد الحاضرين معك';
  static const String messageLabel = 'رسالتك ';
  static const String messageHint = 'رسالة';
  static const String signatureLabel = 'توقيعك  ؟';
  static const String signatureHint = 'التوقيع';
  static const String clearSignature = 'مسح';
  static const String yesLabel = 'نعم';
  static const String noLabel = 'لا';
  static const String send = 'إرسال'; 

  // Closing Section
  static const String closingTitle = 'We hope to see you there';
  static String closingDescription = 'We can\'t wait to celebrate with you on ${coupleData.date}';
  static const String addToCalendar = 'أضافة الي التقويم  ←  ';


  static const String loginTitle = 'Couple Login';
  static const String loginSubtitle = 'Access your guest messages and wishes for your wedding party';
  static const String emailLabel = 'البريد الإلكتروني';
  static const String emailHint = 'example@email.com';
  static const String emailEmptyError = 'من فضلك أدخل البريد الإلكتروني';
  static const String passwordLabel = 'كلمة المرور';
  static const String passwordHint = 'أدخل كلمة المرور';
  static const String passwordEmptyError = 'من فضلك أدخل كلمة المرور';
  static const String passwordTooShortError = 'يجب أن تحتوي كلمة المرور على 6 أحرف على الأقل';
  static const String loginButton = 'تسجيل الدخول';


  // couple Prefrences
  static const String languageCode = 'ar';
  static const Color baseColor = Color(0xFFD0F0C0);
  static const int maxNumberOfAttendees = 7;


  // Error Messages
  static const String emptyMapLink = 'رابط الخريطة فارغ';
  static const String cannotOpenMap = 'تعذر فتح الخريطة';
  static const String calendarMissingParams = 'بيانات التقويم غير مكتملة';
  static const String cannotOpenCalendar = 'تعذر فتح التقويم';
  static const String guestNameEmpty = 'من فضلك اكتب اسمك';
  static const String messageEmpty = 'نسيت ان تكتب رسالة';
  static const String submitFailed = 'تعذر إرسال الرد، حاول مرة تانية';
  static const String mapsFailed = 'حصل خطأ أثناء فتح الخريطة';
  static const String calendarFailed = 'حصل خطأ أثناء فتح التقويم';


  static const String attendeeCountLabel = 'عدد الحاضرين';
  static const String attendingYes = 'حاضر';
  static const String attendingNo = 'غير حاضر';
  static const String noMessageProvided = 'لم يترك رسالة';
 
  // Couples (Admin) Error Messages
  static const String adminNotFound = 'حساب المسؤول غير موجود، من فضلك تواصل مع الدعم';
  static const String loginFailed = 'تعذّر تسجيل الدخول، حاول مرة تانية';
  static const String authCheckFailed = 'تعذّر التحقق من حالة الدخول، حاول مرة تانية';
  static const String loadGuestsFailed = 'تعذّر تحميل قائمة الضيوف، حاول مرة تانية';
  static const String signOutFailed = 'تعذّر تسجيل الخروج، حاول مرة تانية';
  

}

