import 'package:flutter/material.dart';

import '../../../../config/themes/colors.dart';

class KSkipOnButton extends StatelessWidget {
  const KSkipOnButton({
    super.key,
    required PageController controller,
  }) : _controller = controller;

  final PageController _controller;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
        child: TextButton(
          onPressed: () {
            _controller.jumpToPage(2);
          },
          child: Text(
            'Skip',
            style: TextStyle(
              color: KColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}
