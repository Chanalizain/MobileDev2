import 'package:flutter/material.dart';
import '../../../../utils/date_time_utils.dart';
import '../../../theme/theme.dart';

import '../../../../model/ride/locations.dart';
import '../../../../model/ride_pref/ride_pref.dart';
import '../../../widgets/actions/bla_button.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    // TODO
    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      arrival = widget.initRidePref!.arrival;
      departureDate = widget.initRidePref!.departureDate;
      requestedSeats = widget.initRidePref!.requestedSeats;
    } else {
      departure = null;
      arrival = null;
      departureDate = DateTime.now();
      requestedSeats = 1;
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------
  void _switchLocations() {
    setState(() {
      final temp = departure;
      departure = arrival;
      arrival = temp;
    });
  }
  void _onSearchPressed() {
    bool isDepartureValid = departure != null;
    bool isArrivalValid = arrival != null;

    if (isDepartureValid && isArrivalValid) {
      RidePref newPref = RidePref(
        departure: departure!,
        arrival: arrival!,
        departureDate: departureDate,
        requestedSeats: requestedSeats,
      );

      print(
        "Valid Search",
      );
    } else {
      print("Error");
    }
  }
  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------
  Widget _buildRow(IconData icon, String label, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Icon(icon, color: BlaColors.neutralLight, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: BlaTextStyles.body.copyWith(
                  color: label.contains("from") || label.contains("to")
                      ? BlaColors.textLight
                      : BlaColors.textNormal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          margin: EdgeInsets.zero, 
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 1, 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //departure
              Row(
                children: [
                  Expanded(
                    child: _buildRow(
                      departure == null
                          ? Icons.location_on
                          : Icons.panorama_fish_eye_rounded,
                      departure?.name ?? "Leaving from",
                    ),
                  ),
                  IconButton(
                    onPressed: _switchLocations,
                    icon: Icon(Icons.swap_vert, color: BlaColors.primary),
                  ),
                ],
              ),
              const Divider(indent: 50, height: 1),
              // Arrival row
              _buildRow(
                arrival == null
                    ? Icons.location_on
                    : Icons.panorama_fish_eye_rounded,
                arrival?.name ?? "Going to",
              ),
              const Divider(indent: 50, height: 1),

              // Date row
              _buildRow(
                Icons.calendar_month_outlined,
                DateTimeUtils.formatDateTime(departureDate),
              ),
              const Divider(indent: 50, height: 1),

              // Seats row
              _buildRow(Icons.person_outline, "$requestedSeats"),

              BlaButton(
                label: "Search",
                onPressed:  _onSearchPressed,
                isPrimary: true,
              ),
            ],
          ),
        ),
        
      ],
    );
  }
}
