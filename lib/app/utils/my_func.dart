import 'dart:math';

import 'package:flutter/material.dart';
import 'package:yogo_pos/app/utils/static_colors.dart';
import 'package:flutter/services.dart' show rootBundle;

class MyFunc {
  static Color productColor(String text) {
    if (text == "VEG") {
      return StaticColors.greenColor;
    } else if (text == "NON_VEG") {
      return const Color(0xffFD571A);
    } else {
      return StaticColors.purpleColor;
    }
  }


  static Color getTableColorWithStatus(String? status) {
    switch (status) {
      case "AVAILABLE":
        return const Color(0xff118A01); // Available
      case "BOOKING":
        return const Color(0xffF8931D); // Booked
      // case "WALK-IN":
      //   return const Color(0xffF8931D);
      case "COOKING":
        return const Color.fromARGB(255, 255, 106, 52); // COOKING
      case "SERVING":
        return const Color.fromARGB(255, 255, 106, 52); // Serving
      case "ONLINE_BOOKING":
        return const Color(0xff006AFF); // Online Booking
      case "COMBINED_TABLES":
        return const Color(0xff6864D2); // Combined
      case "HOLD_TABLES":
        return const Color(0xffEA295E); // Combined
      default:
        return const Color.fromARGB(255, 75, 22, 36); // Hold
    }
  }

  static String getStatusWithStatusCode(int? status) {
    switch (status) {
      case 1:
        return "Available"; // Available
      case 2:
        return "Booked"; // Booked
      case 3:
        return "UServing"; // UServing
      case 4:
        return "Online Booking"; // Online Booking
      case 5:
        return "Combined"; // Combined
      default:
        return "Hold"; // Hold
    }
  }

  // static num yogotRound(num value) {
  //   num roundToNearest = 0.05;
  //   return (value / roundToNearest).ceil() * roundToNearest;
  // }

  static int generateRandomNumericId() {
    Random random = Random();
    int min = 100000;
    int max = 999999;
    return min + random.nextInt(max - min);
  }

  static String capitalize(String s) {
    var stringData = s.trim();
    if (stringData.isNotEmpty) {
      return stringData[0].toUpperCase() + s.substring(1).toLowerCase();
    } else {
      return "";
    }
  }

  static String capitalizeEachWord({String? s}) {
    if (s != null && s.isNotEmpty) {
      return s
          .trim()
          .split(' ')
          .map(
              (word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
          .join(' ');
    }
    return "";
  }

  static int calculateSecondsFrom(DateTime? givenDate) {
    if (givenDate == null) {
      return 0;
    }
    try {
      // Get the current date and time in UTC
      DateTime now = DateTime.now().toUtc();

      // Calculate the difference in seconds
      int secondsDifference = now.difference(givenDate.toUtc()).inSeconds;

      return secondsDifference;
    } catch (e) {
      // Return 0 if there is an error
      return 0;
    }
  }

  static num yogotRound(num value) {
    num roundToNearest = 0.05;
    num roundedValue = (value / roundToNearest).ceil() * roundToNearest;
    return num.parse(roundedValue.toStringAsFixed(2));
  }


  static Color getColorForCategory(String mainCategory) {
    switch (mainCategory.toLowerCase()) {
      case "food":
        return StaticColors.greenColor;
      case "drinks":
        return StaticColors.blueColor; // Booked
      case "dessert":
        return StaticColors.greenColor; // COOKING
      default:
        return StaticColors.orangeColor; // groceriesList
    }
  }

  static Color getColorItemType(String mainCategory) {
    switch (mainCategory.toLowerCase()) {
      case "veg":
        return StaticColors.greenColor;
      case "non veg":
        return StaticColors.yellowColor;
      case "drinks":
        return StaticColors.blueColor;
      case "liquor":
        return StaticColors.orangeColor;
      case "dessert":
        return StaticColors.greenColor;
      default:
        return StaticColors.blueColor; // as drinks
    }
  }

  static String stringNullCheck(String? value) {
    if (value == null || value.isEmpty) {
      return "N.A.";
    } else {
      return value;
    }
  }

  // String getAmPm(TimeOfDay time, BuildContext context) {
  //   final formattedTime = time.format(context);
  //   if (formattedTime.contains('AM')) {
  //     return 'AM';
  //   } else if (formattedTime.contains('PM')) {
  //     return 'PM';
  //   } else {
  //     return ''; // In case the format does not include AM/PM
  //   }
  // }
  String timeOfDayToString(TimeOfDay time, BuildContext context) {
    final localizations = MaterialLocalizations.of(context);
    final formattedTime =
        localizations.formatTimeOfDay(time, alwaysUse24HourFormat: false);
    return formattedTime.replaceAll(' ', '').toLowerCase();
  }
}
