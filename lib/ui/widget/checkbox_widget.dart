import 'package:flutter/material.dart';

class CustomCheckBox<T> extends StatefulWidget {
  final T item;
  final Function onSelCallback;

  CustomCheckBox({this.item, this.onSelCallback});

  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool _value1 = false;

  void _value1Changed(bool value) => setState(() {
        _value1 = value;
        widget.item.isChecked = _value1;
        widget.onSelCallback(widget.item);
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
          height: 20,
          width: 20,
          child: DecoratedBox(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: .5, color: Colors.grey)),
            child: Theme(
                data: Theme.of(context).copyWith(
                  unselectedWidgetColor: Colors.white,
                ),
                child: Checkbox(
                  value: _value1,
                  onChanged: _value1Changed,
                  checkColor: Colors.green,
                  activeColor: Colors.white,
                )),
          )),
    );
  }
}
