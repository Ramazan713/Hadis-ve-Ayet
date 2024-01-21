package com.masterplus.hadiths.providers
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.net.Uri
import android.widget.RemoteViews
import com.masterplus.hadiths.MainActivity
import com.masterplus.hadiths.R
import es.antonborri.home_widget.HomeWidgetBackgroundIntent
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider

class EsmaulHusnaWidgetProvider: HomeWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.esmaul_husna_widget_layout).apply {
                val arabicTitle = widgetData.getString("arabicTitle","")
                val title = widgetData.getString("title","")
                val meaning = widgetData.getString("meaning","")
                val orderItem = widgetData.getInt("orderItem",0)

                setTextViewText(R.id.esmual_husna_arabic_title,arabicTitle)
                setTextViewText(R.id.esmual_husna_title,title)
                setTextViewText(R.id.esmual_husna_meaning,meaning)
                setTextViewText(R.id.esmual_husna_order_item,orderItem.toString())

                val nextIntent = HomeWidgetBackgroundIntent.getBroadcast(
                    context,
                    Uri.parse("esmaulHusnaWidget://next")
                )
                val previousIntent = HomeWidgetBackgroundIntent.getBroadcast(
                    context,
                    Uri.parse("esmaulHusnaWidget://previous")
                )

                val refreshIntent = HomeWidgetBackgroundIntent.getBroadcast(
                    context,
                    Uri.parse("esmaulHusnaWidget://refresh")
                )

                setOnClickPendingIntent(R.id.esmual_husna_previous_button, previousIntent)
                setOnClickPendingIntent(R.id.esmual_husna_next_button, nextIntent)
                setOnClickPendingIntent(R.id.esmual_husna_refresh_button, refreshIntent)

            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }

}