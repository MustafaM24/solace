import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solace/backend/states.dart';
import 'package:solace/theme/color_scheme.dart';

class TableInformation extends StatelessWidget {
  const TableInformation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> data = Provider.of<StateController>(context, listen: true)
        .ambulanceInformation;
    List<String> titles =
        Provider.of<StateController>(context).ambulanceInformationtitles;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 150,
            width: 150,
            child: Image.asset(
              'assets/images/driver.jpg',
            ),
          ),
        ),
        DataTable(
          columnSpacing: 20,
          border: TableBorder.all(
              color: SecondaryFont.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10)),
          columns:const  [
           DataColumn(
              label: Text('Delivery Code',
                  style: TextStyle(fontWeight: FontWeight.w600)),
            ),
            DataColumn(
                label: Text(
             ' data[0]',
            )),
          ],
          rows: [
            for (int i = 1; i < data.length; i++)
              DataRow(cells: [
                DataCell(Text(titles[i],
                    style: const TextStyle(fontWeight: FontWeight.w600))),
                DataCell(Text(data[i])),
              ]),
          ],
        ),
      ],
    );
  }
}
