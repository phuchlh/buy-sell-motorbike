import 'dart:ui';

import '../model/mappings.dart';

class SharedVariable {
  // static final mappr = ModelMapper();
}

class DesignConstants {
  static const Color primaryColor = Color(0xFFffd43b);
  static const Color greyBorder = Color(0xFFadb5bd);
  static const Color greyFooter = Color(0xFFdee2e6);
  static const Color secondaryColor = Color.fromRGBO(160, 160, 160, 1);
}

class ErrorConstants {
  static const String ERROR_PHOTO =
      "https://archive.org/download/no-photo-available/no-photo-available.png";
  static const String UPDATING = "Đang cập nhật";
  static const String SHOWROOM_DEFAULT = "https://i.imgur.com/vYsYgC0.jpg";
  static const String DEFAULT_SHOWROOM = "assets/images/app_logo.jpg";
}

class ErrorMessageConstant {
  static final String PHONE_EXIST = 'phone_exist';
  static final String EMAIL_EXIST = 'email_exist';
  static final String USER_NAME_EXIST = 'user_name_exist';
}
