import 'package:flutter/material.dart';

class GraphBars extends StatelessWidget {
  const GraphBars(
      {Key? key,
      required this.colors,
      required this.values,
      required this.barsBoundedBy})
      : super(key: key);
  final List<double?> values;
  final List colors;
  final double barsBoundedBy;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        ...List.generate(
          values.length,
          (index) => Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 5,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(barsBoundedBy),
              color: colors[index % 2],
            ),
            width: 25,
            height: values[index],
          ),
        ),
      ],
    );
  }
}
