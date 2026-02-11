import 'package:flutter/material.dart';
import '../widgets/actions/bla_button.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          
          child: Column(
            children:[
              BlaButton(
                icon: Icons.search,
                label: 'Search',
                isPrimary: true,
                onPressed: () {
                  print("search");
                },
              ),
              BlaButton(
                label: 'Home',
                isPrimary: false,
                onPressed: () {
                  print("home");
                },
              ),
            ]
          ),
        ),
      ),
    ),
  );
}
