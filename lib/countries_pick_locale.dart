library countries_pick_locale;

import 'package:flutter/material.dart';

import 'coutry_picker_dialog.dart';
import 'support/country_codes.dart';
import 'support/country_model.dart';
import 'support/country_translate_code.dart';



class CountriesPickLocale extends StatefulWidget {
  CountriesPickLocale({
    required this.callBackFunction,
    this.headerText,
    this.headerBackgroundColor,
    this.headerTextColor,
    this.isFlag = true,
    this.locale = 'en', // Default locale is English
  });

  final Function(String dialCode,String flag) callBackFunction;
  final String? headerText;
  final Color? headerBackgroundColor;
  final Color? headerTextColor;
  final bool isFlag;
  final String locale; // Add locale as a parameter
  bool isInit = true;

  @override
  _CountriesPickLocaleState createState() => _CountriesPickLocaleState();
}

class _CountriesPickLocaleState extends State<CountriesPickLocale> {
  List<CountryModel> countryList = [];
  CountryModel? selectedCountryData;
  Map translateCode = {};

  @override
  void didChangeDependencies() async {
    if (widget.isInit) {
      widget.isInit = false;
      List decodeCountryCode = countryCodesList;
      translateCode = countryTranslateCode;
      setState(() {
        countryList = List.generate(decodeCountryCode.length,(i) {
          var code = decodeCountryCode[i];

          if(widget.locale!='en'){
            code['name'] = translateCode[code['name']][widget.locale]??code['name'];
          }
          return  CountryModel.fromJson(code);
        });
        if(widget.locale!='en'){
          countryList.sort((a, b) => a.name.compareTo(b.name));
        }
        selectedCountryData = countryList[0];
      });
      // widget.callBackFunction(
      //     // selectedCountryData.getLocalizedName(widget.locale),
      //     selectedCountryData.dialCode,
      //     selectedCountryData.flag
      // );
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkResponse(
        onTap: () {
          showDialogue(context);
        },
        child: Container(
          width: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if(widget.isFlag&&selectedCountryData!=null)Text(selectedCountryData!.flag ,
                style: const TextStyle(fontSize: 20),
              ),
              if(selectedCountryData!=null) Text(selectedCountryData!.dialCode,
                style: const TextStyle(fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showDialogue(BuildContext context) async {
    final countryData = await showDialog(
      context: context,
      builder: (BuildContext context) => CountryPickerDialog(
        searchList: countryList,
        callBackFunction: widget.callBackFunction,
        headerText: widget.headerText,
        headerBackgroundColor: widget.headerBackgroundColor,
        headerTextColor: widget.headerTextColor,
        locale: widget.locale, // Pass locale to dialog
      ),
    );
    if (countryData != null) {
      selectedCountryData = countryData as CountryModel;
    }
    setState(() {});
  }
}
