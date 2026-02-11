import 'package:flutter/material.dart';

class BlaButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final IconData? icon;
  final bool isPrimary;

  const BlaButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    required this.isPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return isPrimary ? _buildPrimaryButton() : _buildSecondaryButton();
  }

  Widget _buildPrimaryButton() {
    return icon != null
        ? ElevatedButton.icon(
            onPressed: onPressed,
            icon: Icon(icon),
            label: Text(label),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, 
              foregroundColor: Colors.white,
            ),
          )
        : ElevatedButton(
          onPressed: onPressed, 
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, 
              foregroundColor: Colors.white,
          ),
          child: Text(label),
          );
  }

  Widget _buildSecondaryButton() {
    return icon != null
        ? OutlinedButton.icon(
            onPressed: onPressed,
            icon: Icon(icon),
            label: Text(label),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.blue, 
              side: const BorderSide(color: Colors.grey), 
            ),
          )
        : OutlinedButton(
            onPressed: onPressed, 
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.blue, // Text color
              side: const BorderSide(color: Colors.grey), // <--- GREY OUTLINE
            ),
            child: Text(label)
          );
  }
}
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}