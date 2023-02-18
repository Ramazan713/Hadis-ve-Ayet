import 'package:flutter/material.dart';
import 'package:hadith/utils/font_size_helper.dart';
import 'package:hadith/widgets/buttons/custom_button_positive.dart';
import 'package:hadith/widgets/custom_radio.dart';
import 'package:hadith/constants/enums/font_size_enum.dart';
import 'package:hadith/constants/preference_constants.dart';
import 'package:hadith/utils/localstorage.dart';

Future<void> showSelectFontSizeBottomDia(BuildContext context,
    {void Function(FontSize selectedFontSize)? listener}) async {

  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        ValueNotifier<FontSize> radioNotifier = ValueNotifier(FontSizeHelper.getFontSize());

        void getSelectedRadio(FontSize fontSize) {
          radioNotifier.value = fontSize;
          FontSizeHelper.setFontSize(fontSize);
          listener?.call(fontSize);
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: Text(
                  "Yazı Tipini Seç",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              ValueListenableBuilder<FontSize>(
                valueListenable: radioNotifier,
                builder: (context, val, child) {
                  return Column(
                    children: [
                      CustomRadio(
                          label: FontSize.verySmall.shortName,
                          value: FontSize.verySmall,
                          selectedValue: val,
                          onClick: getSelectedRadio),
                      CustomRadio(
                          label: FontSize.small.shortName,
                          value: FontSize.small,
                          selectedValue: val,
                          onClick: getSelectedRadio),
                      CustomRadio(
                          label: FontSize.medium.shortName,
                          value: FontSize.medium,
                          selectedValue: val,
                          onClick: getSelectedRadio),
                      CustomRadio(
                          label: FontSize.large.shortName,
                          value: FontSize.large,
                          selectedValue: val,
                          onClick: getSelectedRadio),
                      CustomRadio(
                          label: FontSize.veryLarge.shortName,
                          value: FontSize.veryLarge,
                          selectedValue: val,
                          onClick: getSelectedRadio)
                    ],
                  );
                },
              ),
              ValueListenableBuilder<FontSize>(
                  valueListenable: radioNotifier,
                  builder: (context, fontSize, child) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: Text(
                        "Örnek Yazı",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: fontSize.size),
                      ),
                    );
                  }),
              CustomButtonPositive(onTap: () {
                Navigator.pop(context);
              }),
            ],
          ),
        );
      });
}
