


enum SearchCriteriaEnum {inMultipleKeys,multipleKeys,inOneExpression,oneExpression }

extension SearchCriteriaExtension  on SearchCriteriaEnum {

  String getDescription(){
    switch(this){
      case SearchCriteriaEnum.inOneExpression:
        return "Tek bir ifadeyi içinde ara";
      case SearchCriteriaEnum.inMultipleKeys:
        return "Anahtar kelimeleri içinde ara";
      case SearchCriteriaEnum.multipleKeys:
        return "Anahtar kelimelerle ara";
      case SearchCriteriaEnum.oneExpression:
        return "Tek bir ifade olarak ara";
    }
  }

}