
import 'package:flutter/material.dart';
import 'dart:math';


class DhikrmaticClassic extends StatelessWidget {
  final Function() onClick;
  final int counter;
  final int subCounter;
  const DhikrmaticClassic({Key? key,required this.onClick,
    required this.counter,required this.subCounter
  }) : super(key: key);

  final double radius = 130;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      elevation: 7,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      child: InkWell(
        onTap: onClick,
        borderRadius: BorderRadius.circular(radius),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: radius * 2,
              width: radius * 2,
              child: CircularProgressIndicator(
                value: counter / 99,
                strokeWidth: 13,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              counter.toString(),
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Positioned(
              bottom: radius/2,
              child: Text(
                subCounter.toString(),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.normal
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}

