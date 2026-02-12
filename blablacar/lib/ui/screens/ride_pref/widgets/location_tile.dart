import 'package:flutter/material.dart';
import '../../../../model/ride/locations.dart';
import '../../../theme/theme.dart';

class LocationTile extends StatelessWidget {
  final Location location;
  final VoidCallback onTap;

  const LocationTile({super.key, required this.location, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        location.name,
        style: BlaTextStyles.body.copyWith(color: BlaColors.textNormal),
      ),

      subtitle: Text(
        location.country.name,
        style: BlaTextStyles.label.copyWith(color: BlaColors.textLight),
      ),

      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: BlaColors.neutralLight,
      ),
    );
  }
}
