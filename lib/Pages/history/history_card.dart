import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:solace/theme/color_scheme.dart';

class HistoryRecord extends StatelessWidget {
  const HistoryRecord({
    Key? key,
    required this.size,
    required this.data,
    required this.docID,
  }) : super(key: key);

  final Size size;
  final Map<String, dynamic> data;
  final String docID;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpandablePanel(
        theme: const ExpandableThemeData(
          iconColor: PrimaryColor,
        ),
        header: Container(
          padding: EdgeInsets.all(size.width * 0.03),
          child: Row(children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              height: size.height * 0.012,
              width: size.height * 0.012,
              decoration: BoxDecoration(
                color: colorState(),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 2,
                    blurRadius: 5,
                  )
                ],
                border: Border.all(color: SecondaryFont.withOpacity(0.2)),
                shape: BoxShape.circle,
              ),
            ),
            Text(
              data['Status']!,
              style: textStyle(FontWeight.bold, 'Raleway-Medium', 0.015),
            )
          ]),
        ),
        collapsed: Container(
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
                      color: SecondaryFont.withOpacity(0.2), width: 2))),
          margin: EdgeInsets.symmetric(
              horizontal: size.width * 0.05, vertical: size.height * 0.01),
          height: size.height * 0.10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  docID.substring(0, 5),
                  style: textStyle(FontWeight.normal, 'Raleway', 0.018),
                ),
              ),
              Row(
                children: [
                  Text(
                    'from: ',
                    style: textStyle(FontWeight.w800, 'Raleway-Medium', 0.015),
                  ),
                  Text(
                    data['Pickup location']!,
                    style:
                        textStyle(FontWeight.normal, 'Raleway-Medium', 0.015),
                  ),
                ],
              ),
              data['Dropoff Hospital'] != null
                  ? Row(
                      children: [
                        Text(
                          'to: ',
                          style: textStyle(
                              FontWeight.w800, 'Raleway-Medium', 0.015),
                        ),
                        Text(
                          data['Dropoff Hospital']!,
                          style: textStyle(
                              FontWeight.normal, 'Raleway-Medium', 0.015),
                        )
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
        expanded: SizedBox(
          height: size.height * 0.25,
          child: const Text('sddssdsd'),
        ),
      ),
    );
  }

  Color colorState() {
    if (data['Status'] == 'Requested') {
      return const Color.fromARGB(255, 255, 230, 4);
    } else {
      return data['Status'] == 'Done'
          ? PrimaryColor
          : data['Status'] == 'Accepted'
              ? const Color.fromARGB(255, 0, 86, 216)
              : const Color.fromARGB(255, 0, 255, 17);
    }
  }

  TextStyle textStyle(FontWeight fw, String family, double frac) {
    return TextStyle(
        fontWeight: fw, fontFamily: family, fontSize: size.height * frac);
  }
}
