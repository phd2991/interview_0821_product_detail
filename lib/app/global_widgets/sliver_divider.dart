import 'package:flutter/material.dart';

class SliverDivider extends StatelessWidget {
  final double? height;
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final Color? color;

  const SliverDivider({
    Key? key,
    this.height,
    this.thickness,
    this.indent,
    this.endIndent,
    this.color,
  })  : assert(height == null || height >= 0.0),
        assert(thickness == null || thickness >= 0.0),
        assert(indent == null || indent >= 0.0),
        assert(endIndent == null || endIndent >= 0.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Divider(
        height: height,
        thickness: thickness,
        indent: indent,
      ),
    );
  }
}
