import 'package:flutter/material.dart';

import '../widgets/actions/bla_button.dart';
import '../screens/ride_pref/widgets/ride_prefs_form.dart';
import '../theme/theme.dart';
import '../../data/dummy_data.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          
          child: Column(
            children:[
              RidePrefForm(
                initRidePref: fakeRidePrefs[0],
              ), // Shows data in a card
              const SizedBox(height: 32),
              const RidePrefForm(),
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
