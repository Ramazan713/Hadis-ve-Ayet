import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/features/extra_features/counter/domain/counter_type.dart';
import 'package:hadith/features/extra_features/counter/domain/model/counter.dart';
import 'package:hadith/utils/snack_utils.dart';
import 'package:hadith/widgets/buttons/custom_button_positive.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_appbar.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_nested_scrollview.dart';

import 'bloc/manage_counter_bloc.dart';
import 'bloc/manage_counter_event.dart';
import 'bloc/manage_counter_state.dart';
import 'components/input_text_item.dart';
import 'components/select_counter.dart';

class ManageCounterPage extends StatefulWidget {
  static const id = "ManageCounterPage";

  final Counter? counter;
  const ManageCounterPage({Key? key, this.counter}) : super(key: key);

  @override
  State<ManageCounterPage> createState() => _ManageCounterPageState();
}

class _ManageCounterPageState extends State<ManageCounterPage> {

  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController contentTextController = TextEditingController();
  final TextEditingController meaningTextController = TextEditingController();
  final TextEditingController arabicContentController = TextEditingController();
  final TextEditingController goalTextController = TextEditingController();


  void init(Counter? counter,ManageCounterBloc manageBloc){
    if(counter!=null){
      manageBloc.add(ManageCounterEventSetType(type: counter.counterType));
      nameTextController.text = counter.name;
      contentTextController.text = counter.content??"";
      meaningTextController.text = counter.meaning??"";
      arabicContentController.text = counter.arabicContent??"";
      goalTextController.text = counter.goal?.toString()??"";
    }
  }

  @override
  Widget build(BuildContext context) {

    final manageBloc = context.read<ManageCounterBloc>();
    final counter = (ModalRoute.of(context)?.settings.arguments as Counter?);
    init(counter,manageBloc);

    return BlocListener<ManageCounterBloc,ManageCounterState>(
      listener: (context,state){
        if(state.message!=null){
          SnackUtils.showMessage(context, SnackBar(content: Text(state.message??"")));
        }
        if(state.navigatePop){
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: CustomSliverNestedView(
            context,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                const CustomSliverAppBar(
                  title: Text("Zikri Düzenle"),
                  floating: true,
                  snap: true,
                )
              ];
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InputTextItem(
                    name: "İsim (zorunlu alan) ",
                    textEditingController: nameTextController,
                    maxLines: 2,
                  ),
                  InputTextItem(
                    name: "İçerik (isteğe bağlı) ",
                    textEditingController: contentTextController,
                    maxLines: 5,
                    inputType: TextInputType.multiline,
                  ),
                  InputTextItem(
                    name: "Anlamı (isteğe bağlı) ",
                    textEditingController: meaningTextController,
                    maxLines: 5,
                    inputType: TextInputType.multiline,
                  ),
                  InputTextItem(
                    name: "Arapça İçerik (isteğe bağlı) ",
                    textEditingController: arabicContentController,
                    maxLines: 5,
                    inputType: TextInputType.multiline,
                    fontFamily: "ScheherazadeNew",
                    textDirection: TextDirection.rtl,
                    plusFontSize: 5,
                  ),
                  InputTextItem(
                    name: "Hedef (isteğe bağlı)",
                    textEditingController: goalTextController,
                    maxLines: 1,
                    inputType: TextInputType.number,
                    hintText: "Belirlenmedi",
                  ),
                  BlocSelector<ManageCounterBloc,ManageCounterState,CounterType>(
                    selector: (state)=>state.type,
                    builder: (context,counterType){
                      return SelectCounter(
                        title: "Sayaç Türü Seç",
                        selectedItem: counterType,
                        onChange: (type){
                          manageBloc.add(ManageCounterEventSetType(type: type));
                        },
                      );
                    },
                  ),
                  CustomButtonPositive(
                    onTap: (){
                      manageBloc.add(ManageCounterEventUpdate(
                          newName: nameTextController.text,
                          newArabicContent: arabicContentController.text,
                          newGoal: goalTextController.text,
                          newContent: contentTextController.text,
                          newMeaning: meaningTextController.text,
                          counter: counter
                      ));
                    },
                    label: "Kaydet",
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() async{
    super.dispose();
    goalTextController.dispose();
    nameTextController.dispose();
    contentTextController.dispose();
    arabicContentController.dispose();
    meaningTextController.dispose();
  }
}

