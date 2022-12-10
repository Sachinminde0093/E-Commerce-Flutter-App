import 'package:e_commerce_app/provider/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressBar extends StatelessWidget {
  const AddressBar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    const location = "location";
    return Container(
      height: 40,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 31, 242, 246),
          Color.fromARGB(255, 31, 242, 246),
        ], stops: [
          0.5,
          1.0
        ]),
      ),
      child: Row(
        children: [
          const Icon(Icons.edit_location),
          const SizedBox(width: 10),
          Expanded(
              child: Text(
            "Deliverd to ${user.name}- ${location}",
            overflow: TextOverflow.ellipsis,
          )),
          const SizedBox(width: 10),
          const Icon(Icons.expand_more)
        ],
      ),
    );
  }
}
