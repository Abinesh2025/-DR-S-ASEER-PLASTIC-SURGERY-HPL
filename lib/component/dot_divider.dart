import 'package:flutter/material.dart';

class DashDivider extends StatelessWidget {
  final double dashWidth;
  final double dashHeight;
  final double dashSpacing;
  final Color color;
  final Axis direction;

  const DashDivider({
    Key? key,
    this.dashWidth = 6.0,  // Length of each dash
    this.dashHeight = 1.5, // Thickness of the dash
    this.dashSpacing = 4.0, // Space between each dash
    this.color = Colors.grey, // Color of the dashes
    this.direction = Axis.horizontal, // Horizontal or Vertical line
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // Determine the maximum length based on the direction
        final boxLength = direction == Axis.horizontal
            ? constraints.constrainWidth()
            : constraints.constrainHeight();

        // Calculate the total length of one dash plus its spacing
        final dashAndSpaceLength = direction == Axis.horizontal
            ? dashWidth + dashSpacing
            : dashWidth + dashSpacing; // dashWidth acts as the length in both directions

        // Calculate how many dashes will fit in the available space
        final dashCount = (boxLength / dashAndSpaceLength).floor();

        return Flex(
          direction: direction,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              // Swap width and height based on orientation
              width: direction == Axis.horizontal ? dashWidth : dashHeight,
              height: direction == Axis.horizontal ? dashHeight : dashWidth,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(1.0), // Slight rounding for smooth edges
                ),
              ),
            );
          }),
        );
      },
    );
  }
}