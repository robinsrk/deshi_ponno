import 'package:flutter/material.dart';

class MadeWithLoveWidget extends StatelessWidget {
  const MadeWithLoveWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Made with ❤️ in Bangladesh',
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }
}
