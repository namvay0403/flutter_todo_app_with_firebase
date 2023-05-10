import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  const TodoCard(
      {super.key,
      required this.title,
      required this.iconData,
      required this.iconColor,
      required this.check,
      required this.iconBgColor,
      required this.onChange,
      required this.index,
      required this.time});

  final String title;
  final IconData iconData;
  final Color iconColor;
  final String time;
  final bool check;
  final Color iconBgColor;
  final Function onChange;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Theme(
            data: ThemeData(
              primaryColor: Colors.blue,
              unselectedWidgetColor: const Color(0xff5e616a),
            ),
            child: Transform.scale(
              scale: 1.5,
              child: Checkbox(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                activeColor: const Color(0xff6cf8a9),
                checkColor: const Color(0xff0e3e26),
                value: check,
                onChanged: (bool? value) {
                  onChange(index);
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 75,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                color: const Color(0xff2a2e3d),
                child: Row(
                  children: [
                    const SizedBox(width: 15),
                    Container(
                      height: 33,
                      width: 36,
                      decoration: BoxDecoration(
                        color: iconBgColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(iconData, color: iconColor),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
