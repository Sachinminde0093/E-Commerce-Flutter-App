import 'package:flutter/material.dart';

class AccountButton extends StatelessWidget {
  const AccountButton({super.key, required this.onTap, required this.text});

  final VoidCallback onTap;
  final text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: OutlinedButton(
          onPressed: onTap,
          child: Text(text),
        ),
      ),
    );
  }
}
