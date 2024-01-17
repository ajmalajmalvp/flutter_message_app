import 'package:flutter/material.dart';

import '../../../main.dart';

class SenderRowView extends StatelessWidget {
  const SenderRowView({Key? key, required this.index, required this.message})
      : super(key: key);

  final int index;
  final String message;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 50,
      ),
      visualDensity: VisualDensity.comfortable,
      title: Wrap(alignment: WrapAlignment.end, children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.blue,
            borderRadius: BorderRadius.all(
              Radius.circular(
                20,
              ),
            ),
          ),
          child: Text(
            message,
            textAlign: TextAlign.left,
            style: const TextStyle(color: Colors.white),
            softWrap: true,
          ),
        ),
      ]),
      trailing: CircleAvatar(
        backgroundImage: NetworkImage(urlTwo),
      ),
    );
  }
}
