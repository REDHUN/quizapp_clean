import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const ShimmerWidget.rectangular({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.borderRadius,
  });

  const ShimmerWidget.circular({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}
