import 'package:flutter/material.dart';

class ButtonForEditScreen extends StatelessWidget {
  final String label;
  final Function() onTap;
  
  const ButtonForEditScreen({Key? key, required this.label, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 110,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.indigo[500],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                color: Colors.white,
              ),
              Text(
                label,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
