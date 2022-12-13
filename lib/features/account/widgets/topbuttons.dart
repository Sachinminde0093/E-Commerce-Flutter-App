import 'package:e_commerce_app/features/account/widgets/accountbutton.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AccountButton(onTap: () {}, text: "Button"),
            AccountButton(onTap: () {}, text: "Button"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AccountButton(onTap: () {}, text: "Button"),
            AccountButton(onTap: () {}, text: "Button"),
          ],
        )
      ],
    );
  }
}
