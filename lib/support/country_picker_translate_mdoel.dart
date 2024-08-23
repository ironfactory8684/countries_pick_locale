enum CountryPickerTranslateType {
  en, kr, zh, ja, th;

  static CountryPickerTranslateType fromString(String locale) {
    switch (locale) {
      case 'kr':
        return CountryPickerTranslateType.kr;
      case 'zh':
        return CountryPickerTranslateType.zh;
      case 'ja':
        return CountryPickerTranslateType.ja;
      case 'th':
        return CountryPickerTranslateType.th;
      case 'en':
      default:
        return CountryPickerTranslateType.en;
    }
  }

  String get selectCountry {
    switch (this) {
      case CountryPickerTranslateType.kr:
        return '국가 선택';
      case CountryPickerTranslateType.zh:
        return '选择国家';
      case CountryPickerTranslateType.ja:
        return '国を選択';
      case CountryPickerTranslateType.th:
        return 'เลือกประเทศ';
      case CountryPickerTranslateType.en:
      default:
        return 'Select Country';
    }
  }
  String get searchCountry {
    switch (this) {
      case CountryPickerTranslateType.kr:
        return '국가 검색';
      case CountryPickerTranslateType.zh:
        return '搜索国家';
      case CountryPickerTranslateType.ja:
        return '国を検索';
      case CountryPickerTranslateType.th:
        return 'ค้นหาประเทศ';
      case CountryPickerTranslateType.en:
      default:
        return 'Search Country';
    }
  }


  String get cancel {
    switch (this) {
      case CountryPickerTranslateType.kr:
        return '취소';
      case CountryPickerTranslateType.zh:
        return '取消';
      case CountryPickerTranslateType.ja:
        return 'キャンセル';
      case CountryPickerTranslateType.th:
        return 'ยกเลิก';
      case CountryPickerTranslateType.en:
      default:
        return 'Cancel';
    }
  }

  static String searchCountryByLocale(String locale) {
    final type = CountryPickerTranslateType.fromString(locale);
    return type.searchCountry;
  }

  static String selectCountryByLocale(String locale) {
    final type = CountryPickerTranslateType.fromString(locale);
    return type.selectCountry;
  }

  static String cancelByLocale(String locale) {
    final type = CountryPickerTranslateType.fromString(locale);
    return type.cancel;
  }
}