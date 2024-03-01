import 'package:flutter/material.dart';

class MyTeb extends StatelessWidget {
  final String iconPath;
  final String tebname;

  const MyTeb({
    super.key,
    required this.iconPath,
    required this.tebname,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      height: 100,
      child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(15)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(iconPath),
              Align(
                child: Text(
                  tebname,
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                ),
              )
            ],
          )),
    );
  }
}
