import 'package:flutter/material.dart';

GestureDetector KBackAppBarButton(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.pop(context);
    },
    child: Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.black, width: 1)),
        child: Center(
          child: Icon(Icons.chevron_left),
        ),
      ),
    ),
  );
}
