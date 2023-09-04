
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

class KValidate{

  static final FormFieldValidator<String> required = Validatorless.required("bu alan boş geçilemez");

  static FormFieldValidator<String> onlyText(){
    return Validatorless.number("sadece karekter giriniz");
  }

  static FormFieldValidator<String> minRequire(int min){
    return Validatorless.min(min,"en az $min karekter olması gerekiyor");
  }


  static FormFieldValidator<String> maxRequire(int max){
    return Validatorless.max(max, "en fazla $max karekter olmalı");
  }

  static FormFieldValidator<String> onlyNumbers(){
    return Validatorless.number("sadece sayı giriniz");
  }

  static FormFieldValidator<String> numberMin(double min){
    return Validatorless.numbersBetweenInterval(min,double.infinity,"$min değerinden küçük olamaz");
  }

  static FormFieldValidator<String> numberMax(double max){
    return Validatorless.numbersBetweenInterval(double.negativeInfinity,max,"$max değerinden büyük olamaz");
  }
  static FormFieldValidator<String> numberInterval(double min,double max){
    return Validatorless.numbersBetweenInterval(min,max,"$min değerinden küçük, $max değerinden büyük olamaz");
  }

  static List<FormFieldValidator<String>> lenRequire(int length){
    return [
      minRequire(length),
      maxRequire(length)
    ];
  }

  static List<FormFieldValidator<String>> numberAndLength(int length,{double minValue = 0}){
    return [
      onlyNumbers(),
      minRequire(length),
      maxRequire(length),
      numberMin(minValue)
    ];
  }

}