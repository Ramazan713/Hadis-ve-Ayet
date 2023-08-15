import 'package:flutter/material.dart';



class DhikrmaticUnLimited extends StatelessWidget{
  final Function() onClick;
  final int counter;
  const DhikrmaticUnLimited({Key? key,required this.counter,required this.onClick}) : super(key: key);

  final double radius = 130;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: radius*2,
      width: radius*2,
      child: Card(
        elevation: 7,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
        color: Theme.of(context).colorScheme.secondary,
        child: InkWell(
          onTap: onClick,
          borderRadius: BorderRadius.circular(radius),
          child: Center(
            child: Text(counter.toString(),
              style: Theme.of(context).textTheme.headline3),
          ),
        ),
      ),
    );
  }
}