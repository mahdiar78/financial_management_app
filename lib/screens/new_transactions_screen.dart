import 'package:financial_management_app/main.dart';
import 'package:financial_management_app/models/user.dart';
import 'package:financial_management_app/screens/home_screen.dart';
import 'package:financial_management_app/screens/main_screen.dart';
import 'package:financial_management_app/services/database/user_database.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../widgets/my_text_field.dart';

class NewTransactionsScreen extends StatefulWidget {
  static TextEditingController descriptionController = TextEditingController();
  static TextEditingController priceController = TextEditingController();
  static int groupValue = 2;
  static String date = "تاریخ";

  const NewTransactionsScreen({super.key});

  @override
  State<NewTransactionsScreen> createState() => _NewTransactionsScreenState();
}

class _NewTransactionsScreenState extends State<NewTransactionsScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: formKey,
        child: Scaffold(
          backgroundColor: Colors.deepPurple,
          body: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, right: 20, bottom: 30),
                    child: Text(
                      HomeScreen.isEditing == true
                          ? "ویرایش تراکنش"
                          : "تراکنش جدید",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  MyTextField(
                    controller: NewTransactionsScreen.descriptionController,
                    hintText: "توضیحات",
                    keyBoardType: TextInputType.text,
                    errorText: "توضیحات را وارد کنید",
                  ),
                  MyTextField(
                    controller: NewTransactionsScreen.priceController,
                    hintText: "مبلغ",
                    keyBoardType: TextInputType.number,
                    errorText: "مبلغ را وارد کنید",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FormField(
                    builder: (FormFieldState state) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Column(
                          children: [
                            myRadioButton(
                              value: 0,
                              groupValue: NewTransactionsScreen.groupValue,
                              onChanged: (element) {
                                setState(() {
                                  NewTransactionsScreen.groupValue = element!;
                                  state.didChange(element);
                                });
                              },
                              radioText: "پرداختی",
                            ),
                            myRadioButton(
                              value: 1,
                              groupValue: NewTransactionsScreen.groupValue,
                              onChanged: (element) {
                                setState(() {
                                  NewTransactionsScreen.groupValue = element!;
                                  state.didChange(element);
                                });
                              },
                              radioText: "دریافتی",
                            ),
                            if (state.hasError)
                              Padding(
                                padding: const EdgeInsets.only(top: 5,bottom: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      state.errorText!,
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                    validator: (value) {
                      if (NewTransactionsScreen.groupValue == 2) {
                        return 'یک مورد را انتخاب کنید';
                      }
                      return null;
                    },
                  ),
                  FormField(
                    builder: (FormFieldState state) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              SizedBox(
                                width: 150,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(width: 1, color: Colors.white),
                                    backgroundColor: Colors.deepPurple.shade400,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () async {
                                    var pickedDate = await showPersianDatePicker(
                                        context: context,
                                        initialDate: Jalali.now(),
                                        firstDate: Jalali(1300),
                                        lastDate: Jalali(1499));
                                    setState(() {
                                      String year = pickedDate!.year.toString();
                                      String month = pickedDate.month.toString().length == 1
                                          ? "0${pickedDate.month.toString()}"
                                          : pickedDate.month.toString();
                                      String day = pickedDate.day.toString().length == 1
                                          ? "0${pickedDate.day.toString()}"
                                          : pickedDate.day.toString();
                                      NewTransactionsScreen.date = "$year/$month/$day";
                                      state.didChange(NewTransactionsScreen.date);
                                    });
                                  },
                                  child: Text(
                                    NewTransactionsScreen.date,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                              if (state.hasError)
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        state.errorText!,
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                    validator: (value) {
                      if (NewTransactionsScreen.date == "تاریخ") {
                        return 'تاریخی انتخاب کنید';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          User user = User(
                              id: HomeScreen.isEditing == false
                                  ? null
                                  : MainScreen.moneys[HomeScreen.index].id,
                              description: NewTransactionsScreen
                                  .descriptionController.text,
                              price: NewTransactionsScreen.priceController.text,
                              date: NewTransactionsScreen.date,
                              isRecieved: NewTransactionsScreen.groupValue);
                          HomeScreen.isEditing == false
                              ? UserDatabase().addMoney(user)
                              : UserDatabase().updateMoney(
                                  MainScreen.moneys[HomeScreen.index].id!, user);
                          MyApp.getMoneyList();
                          await Future.delayed(const Duration(milliseconds: 500));
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0XFFff86ff),
                      ),
                      child: Text(
                        HomeScreen.isEditing == true
                            ? "ویرایش کردن"
                            : "اضافه کردن",
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget myRadioButton(
      {required int value,
      required int groupValue,
      required Function(int?) onChanged,
      required String radioText}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Radio(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          fillColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.yellow;
            }
            return Colors.white;
          }),
        ),
        Text(
          radioText,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ],
    );
  }
}
