import 'package:flutter/material.dart';

import 'package:solace/theme/color_scheme.dart';

class DropDown extends StatefulWidget {
  const DropDown({
    Key? key,
    required this.width,
    required this.label,
    required this.list,
    required this.val,
    required this.cb,
  }) : super(key: key);

  final double width;
  final String label;
  final List<String> list;
  final String val;
  final void Function(String) cb;
  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.label,
              style: const TextStyle(
                  fontFamily: 'Raleway-Medium',
                  color: PrimaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField(
                style: const TextStyle(
                  color: SecondaryFont,
                  fontSize: 14,
                ),
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: PrimaryColor)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: SecondaryFont)),
                  border: OutlineInputBorder(),
                ),
                elevation: 0,
                // Initial Value
                value: widget.val,

                // Array list of items
                items: widget.list.map((String item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Row(
                      children: [
                        widget.label == 'Accident Type'
                            ? ImageIcon(
                                AssetImage("assets/Icons/$item.png"),
                                size: widget.width * 0.06,
                                color: PrimaryColor,
                              )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontFamily: 'Raleway-Medium',
                              color: PrimaryFont,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  widget.cb(newValue!);
               
                }),
          ),
        ],
      ),
    );
  }
}
