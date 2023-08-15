import 'package:flutter/material.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/enums/counter_type.dart';



class SelectCounter extends StatelessWidget {
  final String title;
  final CounterType selectedItem;
  final Function(CounterType type) onChange;
  const SelectCounter({Key? key,required this.title,required this.selectedItem,required this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final items = CounterType.values.map((type){
      return DropdownMenuItem<CounterType>(
        value: type,
        child: Text(type.title,style: Theme.of(context).textTheme.bodyMedium,),
      );
    }).toList();

    return Card(
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 9),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,style: Theme.of(context).textTheme.bodyLarge,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: InputDecorator(
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(13)),
                  contentPadding: const EdgeInsets.symmetric(vertical: 7,horizontal: 7),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<CounterType>(
                      value: selectedItem,
                      items: items,
                      isDense:true,
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(13),
                      onChanged: (CounterType? type){
                        if(type!=null) onChange(type);
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

