import 'package:flutter/material.dart';

class SharedLoadingIndicator extends StatelessWidget {
  final double? value;
  final EdgeInsets? paddings;

  const SharedLoadingIndicator({
    Key? key,
    this.value,
    this.paddings
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddings ?? EdgeInsets.zero,
      child: Center(
        child: CircularProgressIndicator(
          value: value,
        ),
      ),
    );
  }
}
