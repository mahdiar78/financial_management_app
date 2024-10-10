import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField(
      {super.key,
      required this.controller,
      required this.keyBoardType,
      required this.hintText,
      required this.errorText});

  final TextEditingController controller;
  final TextInputType keyBoardType;
  final String hintText;
  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, bottom: 15),
        child: TextFormField(
          validator: (value){
            if(value == null || value.isEmpty){
              return errorText;
            }
            return null;
          },
          controller: controller,
          cursorColor: Colors.yellow,
          keyboardType: keyBoardType,
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.white),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            filled: true,
            fillColor: Colors.deepPurple.shade400,
            errorStyle: const TextStyle(
              height: 2,
              color: Colors.red
            ),
          ),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }


//---------------------------
  //کد پایین همان کد بالاست فقط به جای TextFormField که یک ویجت پیش ساخته است ، خودم با
  // استفاده از FormField و درون آن TextField خودم ساختم . تنها تفاوت آن این هست که در کد بالا
  // موقع خطا border قرمز می شود ولی در کد پایین رنگ border هنگام خطا تغییری نمی کند
  // @override
  // Widget build(BuildContext context) {
  //   return Padding(
  //     padding: EdgeInsets.only(right: 20, left: 20, bottom: 15),
  //     child: FormField(
  //       validator: (value) {
  //         if (value == null || value == '') {
  //           return errorText;
  //         }
  //         return null;
  //       },
  //       builder: (FormFieldState state) {
  //         return Column(
  //           crossAxisAlignment: CrossAxisAlignment.end,
  //           children: [
  //             TextField(
  //               style: TextStyle(color: Colors.white),
  //               controller: controller,
  //               cursorColor: Colors.yellow,
  //               keyboardType: keyBoardType,
  //               textAlign: TextAlign.end,
  //               decoration: InputDecoration(
  //                 hintText: hintText,
  //                 hintStyle: TextStyle(color: Colors.white),
  //                 border: OutlineInputBorder(
  //                   borderSide: BorderSide(color: Colors.white),
  //                 ),
  //                 enabledBorder: OutlineInputBorder(
  //                   borderSide: BorderSide(color: Colors.white),
  //                 ),
  //                 focusedBorder: OutlineInputBorder(
  //                   borderSide: BorderSide(color: Colors.white),
  //                 ),
  //                 focusedErrorBorder: OutlineInputBorder(
  //                   borderSide: BorderSide(color: Colors.red),
  //                 ),
  //                 errorBorder: OutlineInputBorder(
  //                   borderSide: BorderSide(color: Colors.red),
  //                 ),
  //                 filled: true,
  //                 fillColor: Colors.deepPurple.shade400,
  //               ),
  //             ),
  //             if (state.hasError)
  //               Padding(
  //                 padding: const EdgeInsets.only(top: 10),
  //                 child: Text(
  //                   errorText,
  //                   style: const TextStyle(
  //                     color: Colors.red,
  //                   ),
  //                 ),
  //               ),
  //           ],
  //         );
  //       },
  //     ),
  //   );
  // }
}