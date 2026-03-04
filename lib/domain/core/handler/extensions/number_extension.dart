
extension BanglaNumberExtension on String {
  String toBanglaNumber() {
    const english = ['0','1','2','3','4','5','6','7','8','9'];
    const bangla  = ['০','১','২','৩','৪','৫','৬','৭','৮','৯'];

    String result = this;

    for (int i = 0; i < english.length; i++) {
      result = result.replaceAll(english[i], bangla[i]);
    }

    return result;
  }
}