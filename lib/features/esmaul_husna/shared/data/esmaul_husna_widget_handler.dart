
import 'package:hadith/core/data/local/instance.dart';
import 'package:home_widget/home_widget.dart';

class EsmaulHusnaWidgetHandler {

  static Future<void> handleWidget(String action)async {
    try{
      final orderItem = await HomeWidget.getWidgetData<int>("orderItem",defaultValue: 0) ?? 0;
      int nextOrderItem;
      switch(action){
        case "next":
          nextOrderItem = orderItem >= 99 ? 0 : orderItem + 1;
          break;
        case "previous":
          nextOrderItem = orderItem <= 0 ? 99 : orderItem - 1;
          break;
        case "refresh":
          nextOrderItem = 0;
          break;
        default:
          nextOrderItem = 0;
          break;
      }

      final database = await getDatabase();
      final esmaulHusna = await database.esmaulHusnaDao.getEsmaulHusnaByOrderItem(nextOrderItem);
      if(esmaulHusna == null) return;

      await HomeWidget.saveWidgetData("orderItem", nextOrderItem);
      await HomeWidget.saveWidgetData("title", esmaulHusna.name);
      await HomeWidget.saveWidgetData("arabicTitle", esmaulHusna.arabicName);
      await HomeWidget.saveWidgetData("meaning", esmaulHusna.meaning);

      await HomeWidget.updateWidget(
          name: "EsmaulHusnaWidgetProvider",
          androidName: "EsmaulHusnaWidgetProvider",
          qualifiedAndroidName: "com.masterplus.hadiths.providers.EsmaulHusnaWidgetProvider"
      );
    }catch(e){}
  }
}