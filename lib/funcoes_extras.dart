

 class Extras{

  static final Map<DateTime, List> holidays = {
    DateTime(2019, 1, 1): ['New Year\'s Day'],
    DateTime(2019, 1, 6): ['Epiphany'],
    DateTime(2019, 2, 14): ['Valentine\'s Day'],
    DateTime(2019, 4, 21): ['Easter Sunday'],
    DateTime(2019, 4, 22): ['Easter Monday'],
  };
  static String getNoNullText(String text){
    if(text != null){
      return text;
    }
    return '';
  }
}