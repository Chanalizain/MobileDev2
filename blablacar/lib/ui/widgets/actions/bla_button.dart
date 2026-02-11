import 'package:flutter/material.dart';
import '../../theme/theme.dart'; // Ensure this points to your BlaColors/BlaTextStyles

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
    final style = ElevatedButton.styleFrom(
      backgroundColor: BlaColors.primary,      
      foregroundColor: BlaColors.white,        
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BlaSpacings.radiusLarge),
      ),
      textStyle: BlaTextStyles.button,
      elevation: 0,
    );

    return icon != null
        ? ElevatedButton.icon(
            onPressed: onPressed,
            icon: Icon(icon),
            label: Text(label),
            style: style,
          )
        : ElevatedButton(
            onPressed: onPressed,
            style: style,
            child: Text(label),
          );
  }

  Widget _buildSecondaryButton() {
    final style = OutlinedButton.styleFrom(
      foregroundColor: BlaColors.primary,      
      side: BorderSide(color: BlaColors.greyLight), 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BlaSpacings.radiusLarge),
      ),
      textStyle: BlaTextStyles.button,
    );

    return icon != null
        ? OutlinedButton.icon(
            onPressed: onPressed,
            icon: Icon(icon),
            label: Text(label),
            style: style,
          )
        : OutlinedButton(
            onPressed: onPressed,
            style: style,
            child: Text(label),
          );
  }
}