import 'package:flutter/material.dart';
import 'package:solace/theme/color_scheme.dart';

class CustomTable extends StatelessWidget {
  const CustomTable({super.key, required this.data, required this.fields});

  final List<String> data;
  final List<String> fields;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DataTable(
          border: TableBorder.all(
              color: SecondaryFont.withOpacity(0.8),
              borderRadius: BorderRadius.circular(10)),
          columns: [
            DataColumn(
              label: Text(fields[0],
                  style: const TextStyle(
                      color: PrimaryFont, fontFamily: 'Raleway-Medium')),
            ),
            DataColumn(
                label: Text(data[0],
                    style: const TextStyle(
                        color: PrimaryFont, fontFamily: 'Raleway-Medium'))),
          ],
          rows: [
            for (int i = 1; i < data.length; i++)
              DataRow(cells: [
                DataCell(Text(fields[i],
                    style: const TextStyle(
                        color: PrimaryFont, fontFamily: 'Raleway-Medium'))),
                DataCell(Text(data[i],
                    style: const TextStyle(
                        color: PrimaryFont, fontFamily: 'Raleway-Medium'))),
              ]),
          ],
        ),
      ],
    );
  }
}
