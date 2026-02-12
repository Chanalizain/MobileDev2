import 'package:flutter/material.dart';
import '../../../../model/ride/locations.dart';
import '../../../../data/dummy_data.dart'; 
import 'location_tile.dart';
import 'search_bar.dart';

class LocationPicker extends StatefulWidget {
  final String title;
  final Function(Location) onSelect;

  const LocationPicker({
    super.key,
    required this.title,
    required this.onSelect,
  });

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  // 1. Maintain a list of filtered locations in state
  List<Location> filteredLocations = fakeLocations;

  // 2. Logic to filter results as user types
  void _onSearchChanged(String query) {
    setState(() {
      filteredLocations = fakeLocations
          .where((loc) => loc.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            LocationSearchBar(
              onChanged: _onSearchChanged,
              onBackPressed: () => Navigator.pop(context),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: filteredLocations.length,
                itemBuilder: (ctx, index) => LocationTile(
                  location: filteredLocations[index],
                  onTap: () => widget.onSelect(filteredLocations[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
