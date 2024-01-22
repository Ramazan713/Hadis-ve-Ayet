

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/premium/presentation/bloc/premium_bloc.dart';
import 'package:hadith/core/features/premium/presentation/bloc/premium_state.dart';
import 'package:hadith/core/features/premium/presentation/components/premium_feature_item.dart';

void showPremiumActive(BuildContext context){

  showDialog(
    context: context,
    useSafeArea: true,
    builder: (context){
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 19),
        child: _DialogContent(
          onClosed: (){
            Navigator.pop(context);
          },
        )
      );
    }
  );

}


class _DialogContent extends StatelessWidget {

  final void Function() onClosed;

  const _DialogContent({
    super.key,
    required this.onClosed
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            getHeader(context),
            const SizedBox(height: 19,),
            getFeaturesSection(context),
            const SizedBox(height: 29,),
          ],
        ),
      ),
    );
  }

  Widget getFeaturesSection(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Özellikler",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500
          )
        ),
        const SizedBox(height: 5,),
        BlocSelector<PremiumBloc, PremiumState, List<String>>(
          selector: (state) => state.features,
          builder: (context, features){
            return ListView.builder(
              itemCount: features.length,
              shrinkWrap: true,
              controller: ScrollController(),
              itemBuilder: (context, index) {
                final item = features[index];
                return PremiumFeatureItem(
                  featureName: item,
                );
              },
            );
          },
        )
      ],
    );
  }


  Widget getHeader(BuildContext context){
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: Text(
            "Premium Kullanılıyor",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.error,
              fontWeight: FontWeight.w500
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: onClosed,
            icon: const Icon(Icons.close),
          ),
        )
      ],
    );
  }
}

