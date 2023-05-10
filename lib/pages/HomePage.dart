import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app_with_firebase/custom/TodoCard.dart';
import 'package:flutter_todo_app_with_firebase/pages/AddTodo.dart';
import 'package:flutter_todo_app_with_firebase/pages/Profile.dart';
import 'package:flutter_todo_app_with_firebase/pages/view_data.dart';
import 'package:flutter_todo_app_with_firebase/services/Auth_Services.dart';
import 'package:badges/badges.dart' as badges;

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthClass authClass = AuthClass();
  final Stream<QuerySnapshot> stream =
      FirebaseFirestore.instance.collection("Todo").snapshots();

  String? id;

  List<Select> selected = [];
  int countSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text(
          "Today's Schedule",
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage('assets/avatar.jpg'),
          ),
          SizedBox(height: 25),
        ],
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(35),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Monday 21',
                      style: TextStyle(
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    badges.Badge(
                      badgeContent: Text(countSelected.toString()),
                      position: badges.BadgePosition.topEnd(top: 0, end: 0),
                      showBadge: countSelected == 0 ? false : true,
                      badgeAnimation: const badges.BadgeAnimation.slide(
                          animationDuration: Duration(milliseconds: 1000)),
                      badgeStyle: const badges.BadgeStyle(
                        badgeColor: Color.fromARGB(255, 220, 16, 26),
                      ),
                      child: IconButton(
                        onPressed: countSelected == 0
                            ? null
                            : () {
                                var instance = FirebaseFirestore.instance
                                    .collection("Todo");
                                for (var i = 0; i < selected.length - 1; i++) {
                                  if (selected[i].checkValue == true) {
                                    instance.doc(selected[i].id).delete();
                                  }
                                }
                                selected.clear();
                              },
                        disabledColor: Colors.grey,
                        icon: const Icon(Icons.delete),
                        color: countSelected == 0 ? Colors.grey : Colors.red,
                        iconSize: 28,
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.black87,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 32,
              color: Colors.white,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => AddTodoPage()));
              },
              child: Container(
                height: 52,
                width: 52,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [
                      Colors.indigoAccent,
                      Colors.purple,
                    ])),
                child: const Icon(
                  Icons.add,
                  size: 32,
                  color: Colors.white,
                ),
              ),
            ),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => ProfilePage()));
              },
              child: const Icon(
                Icons.settings,
                size: 32,
                color: Colors.grey,
              ),
            ),
            label: 'Settings',
          ),
        ],
      ),
      body: StreamBuilder(
          stream: stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                IconData iconData;
                Color iconColor;
                Map<String, dynamic> document =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;
                switch (document["Category"]) {
                  case "Work":
                    iconData = Icons.work;
                    iconColor = Colors.red;
                    break;
                  case "WorkOut":
                    iconData = Icons.alarm;
                    iconColor = Colors.teal;
                    break;
                  case "Food":
                    iconData = Icons.food_bank;
                    iconColor = Colors.blue;
                    break;
                  case "Design":
                    iconData = Icons.design_services;
                    iconColor = Colors.red;
                    break;
                  default:
                    iconData = Icons.run_circle_outlined;
                    iconColor = Colors.red;
                }
                selected.add(Select(
                    id: snapshot.data!.docs[index].id, checkValue: false));
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => ViewDataPage(
                                  document: document,
                                  id: snapshot.data!.docs[index].id,
                                )));
                  },
                  child: TodoCard(
                      title: document["title"].toString(),
                      iconData: iconData,
                      iconColor: iconColor,
                      check: selected[index].checkValue,
                      iconBgColor: Colors.white,
                      index: index,
                      onChange: onChange,
                      time: "10 AM"),
                );
              },
            );
          }),
    );
  }

  void onChange(int index) {
    setState(() {
      countSelected = 0;
      print('length: ${selected.length}');
      selected[index].checkValue = !selected[index].checkValue;
      for (var i = 0; i < selected.length; i++) {
        if (selected[i].checkValue == true) {
          countSelected++;
          print('count: ${countSelected}');
        }
      }
    });
  }
}

class Select {
  String? id;
  bool checkValue;
  Select({this.id, this.checkValue = false});
}
