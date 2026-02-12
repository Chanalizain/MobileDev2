import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

class LocationSearchBar extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final VoidCallback onBackPressed;

  const LocationSearchBar({
    super.key,
    required this.onChanged,
    required this.onBackPressed,
  });

  @override
  State<LocationSearchBar> createState() => _LocationSearchBarState();
}

class _LocationSearchBarState extends State<LocationSearchBar> {
  final TextEditingController _controller = TextEditingController();

  void _onClearPressed() {
    setState(() {
      _controller.clear();
      widget.onChanged(""); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 237, 237, 237,), 
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            // 1. Back Button
            IconButton(
              onPressed: widget.onBackPressed,
              icon: const Icon(Icons.arrow_back_ios, size: 18),
              color: BlaColors.neutralLight,
            ),

            // 2. Real Search Input
            Expanded(
              child: TextField(
                controller: _controller,
                onChanged: (value) {
                  setState(() {}); 
                  widget.onChanged(value);
                },
                autofocus: true,
                style: BlaTextStyles.body.copyWith(color: BlaColors.textNormal),
                decoration: InputDecoration(
                  hintText: "Where to?",
                  hintStyle: BlaTextStyles.body.copyWith(
                    color: BlaColors.textLight,
                  ),
                  border: InputBorder.none, 
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),

            // 3. The Cancel Button 
            if (_controller.text.isNotEmpty)
              IconButton(
                icon: const Icon(Icons.close, size: 20),
                color: BlaColors.neutralLight,
                onPressed: _onClearPressed,
              ),
          ],
        ),
      ),
    );
  }
}
