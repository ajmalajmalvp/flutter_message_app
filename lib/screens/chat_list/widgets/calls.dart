import 'package:flutter/material.dart';

Widget callsWidget({required Size size}) {
  return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const CircleAvatar(),
          title: const Text(
            "Bryan",
          ),
          subtitle: const Text("What do you think?"),
          trailing: Column(
            children: [
              const Text(
                "4:30 PM",
              ),
              const Spacer(),
              const CircleAvatar(
                radius: 10,
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
            ],
          ),
        );
      });
}
