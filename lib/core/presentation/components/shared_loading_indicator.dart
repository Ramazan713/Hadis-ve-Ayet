import 'package:flutter/material.dart';

class SharedLoadingIndicator extends StatelessWidget {
  const SharedLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
