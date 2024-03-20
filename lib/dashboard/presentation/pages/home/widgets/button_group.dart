import 'package:flutter/material.dart';
import 'package:renting_app/dashboard/presentation/components/button.dart';
import 'package:renting_app/dashboard/presentation/themes/colors.dart';
import 'package:renting_app/dashboard/presentation/themes/config.dart';

class ButtonGroup__widget extends StatelessWidget {
  const ButtonGroup__widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Accent__Button__Medium(
              text: 'Landlords',
              leftIconVisibility: false,
              rightIconVisibility: false,
              onTap: () {},

            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Accent__Button__Medium(
              text: 'Agents',
              leftIconVisibility: false,
              rightIconVisibility: false,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
