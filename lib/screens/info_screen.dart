import 'package:financial_management_app/utils/calculate.dart';
import 'package:financial_management_app/widgets/bar_chart_widget.dart';
import 'package:flutter/material.dart';
import '../widgets/info_widget.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepPurple,
        body: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20, right: 20, bottom: 10),
                child: Text(
                  "مدیریت تراکنش ها به تومان",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.bold),
                ),
              ),
              InfoWidget(
                payPrice: Calculate.payToday(),
                payText: " : پرداختی امروز",
                recievePrice: Calculate.recieveToday(),
                recieveText: " : دریافتی امروز",
              ),
              InfoWidget(
                payPrice: Calculate.payThisMonth(),
                payText: " : پرداختی این ماه",
                recievePrice: Calculate.recieveThisMonth(),
                recieveText: " : دریافتی این ماه",
              ),
              InfoWidget(
                payPrice: Calculate.payThisYear(),
                payText: " : پرداختی امسال",
                recievePrice: Calculate.recieveThisYear(),
                recieveText: " : دریافتی امسال",
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 70, horizontal: 30),
                  child: double.parse(Calculate.payThisYear()) == 0 &&
                      double.parse(Calculate.recieveThisYear()) == 0
                      ? Container()
                      : const BarChartWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
