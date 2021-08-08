import 'package:flutter/material.dart';

class NumericStepButton extends StatefulWidget {
  final int initialValue;
  final int minValue;
  final int maxValue;

  final ValueChanged<int> onChanged;

  NumericStepButton({
    Key? key,
    this.initialValue = 0,
    this.minValue = 0,
    this.maxValue = 10,
    required this.onChanged,
  })  : assert(minValue <= maxValue),
        assert(initialValue >= minValue),
        assert(initialValue <= maxValue),
        super(key: key);

  @override
  State<NumericStepButton> createState() {
    return _NumericStepButtonState();
  }
}

class _NumericStepButtonState extends State<NumericStepButton> {
  int counter = 0;

  @override
  void initState() {
    super.initState();
    counter = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          child: Icon(Icons.remove, color: Colors.white),
          onPressed: counter <= widget.minValue
              ? null
              : () {
                  setState(() => counter--);
                  widget.onChanged(counter);
                },
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            visualDensity: VisualDensity.compact,
            elevation: 0,
          ),
        ),
        SizedBox(
          width: 30,
          child: Text(counter.toString(), textAlign: TextAlign.center),
        ),
        ElevatedButton(
          child: Icon(Icons.add, color: Colors.white),
          onPressed: counter >= widget.maxValue
              ? null
              : () {
                  setState(() => counter++);
                  widget.onChanged(counter);
                },
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            visualDensity: VisualDensity.compact,
            elevation: 0,
          ),
        ),
      ],
    );
  }
}
