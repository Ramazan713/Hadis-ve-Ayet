

import 'dart:typed_data';

import 'package:hadith/core/domain/models/hadith.dart';
import 'package:hadith/core/domain/repo/share/share_pdf_repo.dart';
import 'package:hadith/db/entities/verse.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';


class SharePdfRepoImpl extends SharePdfRepo{

  final double _fontSize = 14;

  @override
  Future<Uint8List> getHadithPdfContent(List<Hadith> hadiths, String title) async{
    final font=await PdfGoogleFonts.nunitoExtraLight();
    final pdf = pw.Document();

    final List<pw.Widget> bodyItems = [];
    bodyItems.add(_getPdfTitleWidget(font, title));
    for (var hadith in hadiths) {
      bodyItems.add(_getHadithPdfContentWidget(hadith, font));
    }

    pdf.addPage(pw.MultiPage(build: (pw.Context context){
      return bodyItems;
    }));

    return await pdf.save();

  }

  @override
  Future<Uint8List> getVersePdfContent(List<Verse> verses, String title) async{
    final font=await PdfGoogleFonts.nunitoExtraLight();
    final pdf = pw.Document();

    final List<pw.Widget> bodyItems = [];
    bodyItems.add(_getPdfTitleWidget(font, title));
    for (var verse in verses) {
      bodyItems.add(_getVersePdfContentWidget(verse, font));
    }

    pdf.addPage(pw.MultiPage(build: (pw.Context context){
      return bodyItems;
    }));

    return await pdf.save();
  }


  pw.Widget _getPdfTitleWidget(Font font, String title){
    final style = pw.TextStyle(
        font: font,
        fontSize: _fontSize + 14,
        fontWeight: pw.FontWeight.bold
    );

    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.Center(
              child: pw.Text("Hadis ve Ayet",
                  style: style
              )
          ),
          pw.Center(
              child: pw.Text(title,
                  style: style.copyWith(fontSize: _fontSize + 5)
              )
          ),
          pw.SizedBox(height: 33)
        ]
    );
  }



  pw.Column _getHadithPdfContentWidget(Hadith item, Font font) {
    final style=pw.TextStyle(font: font,fontSize: _fontSize);
    return pw.Column(
        children: [
          pw.Center(
              child: pw.Text(item.content.trim().replaceAll("\n", " "),
                  style: style
                  ,textAlign: pw.TextAlign.center
              )
          ),
          pw.SizedBox(height: 7),
          pw.Center(
              child: pw.Text("- ${item.source}",
                  style: style.copyWith(fontSize: _fontSize - 4,
                      fontWeight: pw.FontWeight.bold
                  ),
              textAlign: pw.TextAlign.center)
          ),
          pw.SizedBox(height: 61)
        ]
    );
  }


  pw.Column _getVersePdfContentWidget(Verse item, Font font) {
    final style=pw.TextStyle(font: font,fontSize: _fontSize);
    return pw.Column(
        children: [
          pw.Center(
              child: pw.Text(item.content,
                  style:style,
                  textAlign: pw.TextAlign.center
              )
          ),
          pw.SizedBox(height: 7),
          pw.Center(
              child: pw.Text("- ${item.surahId}/${item.surahName}   ${item.verseNumber}. Ayet",
                  style: style.copyWith(fontSize: _fontSize - 4,
                      fontWeight: pw.FontWeight.bold
                  ),
              textAlign: pw.TextAlign.center
              )
          ),
          pw.SizedBox(height: 61)
        ]
    );
  }

}