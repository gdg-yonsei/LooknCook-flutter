import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final double size; // Optional size parameter for customization
  final Color color; // Optional color parameter for customization

  const LoadingIndicator({
    Key? key,
    this.size = 40.0,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color), // Apply custom color
        strokeWidth: 4.0, // Adjust stroke width for visibility
        semanticsLabel: 'Loading...', // Set accessibility label
      ),
    );
  }
}
