

import 'dart:convert';

import 'package:hadith/core/data/remote/dto/edition_dto.dart';
import 'package:hadith/models/resource.dart';
import 'package:http/http.dart' as http;


class EditionDownloadService{


  Future<Resource<List<EditionDto>>> getEditions()async{

    const url="https://api.alquran.cloud/v1/edition?format=audio&language=ar&type=versebyverse";
    try{
      final response = await http.get(Uri.parse(url),headers: {
        'Content-Type': 'application/json',
      });
      if(response.statusCode == 200){
        final data = EditionDto.fromJsonArr(jsonDecode(response.body)["data"]);
        return ResourceSuccess(data);
      }else{
        return Resource.error("error");
      }
    }catch(e){
      return Resource.error(e.toString());
    }
  }

}