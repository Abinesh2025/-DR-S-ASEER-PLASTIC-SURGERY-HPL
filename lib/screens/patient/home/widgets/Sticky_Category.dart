import 'package:flutter/cupertino.dart';

import '../../../../constant/color_const.dart';

class StickyCategoryDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  StickyCategoryDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: ColorConst.bgGreyColor, // Match your page background
      child: child,
    );
  }

  @override
  double get maxExtent => 80; // Adjust based on your CategoryWidget height
  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant StickyCategoryDelegate oldDelegate) => false;
}