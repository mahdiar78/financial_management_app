import 'package:financial_management_app/screens/main_screen.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class Calculate {
  static double sum = 0;

  static String recieveThisYear() {
    Calculate.sum = 0;
    for (var element in MainScreen.moneys) {
      if (element.date.substring(0, 4) == Jalali.now().year.toString() &&
          element.isRecieved == 1) {
        sum += double.parse(element.price);
      }
    }
    return sum.toString();
  }

  //--------------------------------------------------------------------------
  static String payThisYear() {
    Calculate.sum = 0;
    for (var element in MainScreen.moneys) {
      if (element.date.substring(0, 4) == Jalali.now().year.toString() &&
          element.isRecieved == 0) {
        sum += double.parse(element.price);
      }
    }
    return sum.toString();
  }

//--------------------------------------------------------------------------
  static String recieveThisMonth() {
    sum = 0;
    for (var element in MainScreen.moneys) {
      if (element.date.substring(0, 7) ==
              "${Jalali.now().year}/${Jalali.now().month.toString().length == 1 ? "0${Jalali.now().month}" : Jalali.now().month}" &&
          element.isRecieved == 1) {
        sum += double.parse(element.price);
      }
    }
    return sum.toString();
  }

//--------------------------------------------------------------------------
  static String payThisMonth() {
    sum = 0;
    for (var element in MainScreen.moneys) {
      if (element.date.substring(0, 7) ==
              "${Jalali.now().year}/${Jalali.now().month.toString().length == 1 ? "0${Jalali.now().month}" : Jalali.now().month}" &&
          element.isRecieved == 0) {
        sum += double.parse(element.price);
      }
    }
    return sum.toString();
  }

//--------------------------------------------------------------------------
  static String recieveToday() {
    sum = 0;
    for (var element in MainScreen.moneys) {
      if (element.date.substring(0, 10) ==
              "${Jalali.now().year}/${Jalali.now().month.toString().length == 1 ? "0${Jalali.now().month}" : Jalali.now().month}/${Jalali.now().day.toString().length == 1 ? "0${Jalali.now().day}" : Jalali.now().day}" &&
          element.isRecieved == 1) {
        sum += double.parse(element.price);
      }
    }
    return sum.toString();
  }

//--------------------------------------------------------------------------
  static String payToday() {
    sum = 0;
    for (var element in MainScreen.moneys) {
      if (element.date.substring(0, 10) ==
              "${Jalali.now().year}/${Jalali.now().month.toString().length == 1 ? "0${Jalali.now().month}" : Jalali.now().month}/${Jalali.now().day.toString().length == 1 ? "0${Jalali.now().day}" : Jalali.now().day}" &&
          element.isRecieved == 0) {
        sum += double.parse(element.price);
      }
    }
    return sum.toString();
  }
}
