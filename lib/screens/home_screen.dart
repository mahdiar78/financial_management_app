import 'package:financial_management_app/main.dart';
import 'package:financial_management_app/screens/main_screen.dart';
import 'package:financial_management_app/screens/new_transactions_screen.dart';
import 'package:financial_management_app/services/database/user_database.dart';
import 'package:flutter/material.dart';
import 'package:searchbar_animation/searchbar_animation.dart';
import '../models/user.dart';
import '../widgets/empty_widget.dart';
import '../widgets/my_floating_action_button.dart';

class HomeScreen extends StatefulWidget {
  static bool isEditing = false;
  static late int index;

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepPurple,
        floatingActionButton: MyFloatingActionButton(
          onPressed: () {
            HomeScreen.isEditing = false;
            NewTransactionsScreen.descriptionController.clear();
            NewTransactionsScreen.priceController.clear();
            NewTransactionsScreen.groupValue = 2;
            NewTransactionsScreen.date = "تاریخ";
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const NewTransactionsScreen();
                },
              ),
            ).then((value) {
              setState(() {});
            });
          },
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              headerWidget(searchController),
              SizedBox(
                height: MainScreen.moneys.isEmpty ? 50 : 20,
              ),
              Expanded(
                child: MainScreen.moneys.isEmpty ? const EmptyWidget() : myListView(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget myListView() {
    return ListView.builder(
        itemCount: MainScreen.moneys.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              HomeScreen.index = index;
              HomeScreen.isEditing = true;
              NewTransactionsScreen.descriptionController.text =
                  MainScreen.moneys[index].description;
              NewTransactionsScreen.priceController.text =
                  MainScreen.moneys[index].price;
              NewTransactionsScreen.groupValue =
                  MainScreen.moneys[index].isRecieved;
              NewTransactionsScreen.date = MainScreen.moneys[index].date;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const NewTransactionsScreen();
                  },
                ),
              ).then((value) {
                setState(() {
                  searchController.text = '';
                });
              });
            },
            onLongPress: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text(
                    "آیا از حذف این داده مطمئن هستید؟",
                    style: TextStyle(fontSize: 15),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple.shade100),
                      child: const Text("خیر"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        UserDatabase()
                            .deleteMoney(MainScreen.moneys[index].id!);
                        searchController.text = '';
                        Navigator.pop(context);
                        MyApp.getMoneyList();
                        await Future.delayed(const Duration(milliseconds: 500));
                        setState(() {});
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple.shade100),
                      child: const Text("بله"),
                    ),
                  ],
                  actionsAlignment: MainAxisAlignment.spaceBetween,
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade400,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: MainScreen.moneys[index].isRecieved == 1
                          ? Colors.lightGreen
                          : Colors.redAccent,
                    ),
                    child: Icon(
                      MainScreen.moneys[index].isRecieved == 1
                          ? Icons.add
                          : Icons.remove,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    MainScreen.moneys[index].description,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "تومان ",
                              style: TextStyle(
                                color: MainScreen.moneys[index].isRecieved == 1
                                    ? Colors.green
                                    : Colors.red,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              MainScreen.moneys[index].price,
                              style: TextStyle(
                                color: MainScreen.moneys[index].isRecieved == 1
                                    ? Colors.green
                                    : Colors.red,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        MainScreen.moneys[index].date,
                        style: const TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget headerWidget(TextEditingController searchController) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 15),
      child: Row(
        children: [
          Expanded(
            child: SearchBarAnimation(
              hintText: "... جستجو کنید",
              textEditingController: searchController,
              onFieldSubmitted: (String text) {
                List<User> result = MainScreen.moneys
                    .where((value) =>
                        value.description.contains(text) ||
                        value.date.contains(text))
                    .toList();
                setState(() {
                  MainScreen.moneys.clear();
                  for (var element in result) {
                    MainScreen.moneys.add(element);
                  }
                });
              },
              onCollapseComplete: () async {
                searchController.text = '';
                MyApp.getMoneyList();
                await Future.delayed(const Duration(milliseconds: 500));
                setState(() {});
              },
              buttonColour: Colors.deepPurple.shade100,
              enableKeyboardFocus: true,
              isOriginalAnimation: true,
              trailingWidget: const Icon(
                Icons.search,
                size: 20,
                color: Colors.black,
              ),
              secondaryButtonWidget: const Icon(
                Icons.close,
                size: 20,
                color: Colors.black,
              ),
              buttonWidget: const Icon(
                Icons.search,
                size: 20,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          const Text(
            "تراکنش ها",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
