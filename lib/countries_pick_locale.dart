library countries_pick_locale;

import 'package:flutter/material.dart';

import 'coutry_picker_bottom_dialog.dart';
import 'coutry_picker_dialog.dart';
import 'support/country_codes.dart';
import 'support/country_model.dart';
import 'support/country_translate_code.dart';
import 'support/support_enums.dart';

class CountriesPickLocale extends StatefulWidget {
  CountriesPickLocale({
    required this.callBackFunction,
    this.headerText,
    this.headerBackgroundColor,
    this.headerTextColor,
    this.isFlag = true,
    this.locale = 'en', // Default locale is English
    this.dialogType = DialogType.MOdalBottomDialog,
    this.enableDivider=true,
    this.initCountryCode,
  });

  final Function(String dialCode,String flag) callBackFunction;
  final String? headerText;
  final Color? headerBackgroundColor;
  final Color? headerTextColor;
  final bool isFlag;
  final String locale; // Add locale as a parameter
  final DialogType dialogType;
  final bool enableDivider;
  final String? initCountryCode;

  @override
  _CountriesPickLocaleState createState() => _CountriesPickLocaleState();
}

class _CountriesPickLocaleState extends State<CountriesPickLocale> {
  List<CountryModel> countryList = [];
  CountryModel? selectedCountryData;
  Map translateCode = {};
  bool isInit = true;
  @override
  void didChangeDependencies() async {
    if (isInit) {
      isInit = false;
      countryList = List.generate(countryCodesList.length,(i) {
        Map<String, dynamic> code = Map<String, dynamic>.from(countryCodesList[i]);
        print(code);
        if(widget.locale!='en'){
          code['name'] = countryTranslateCode[code['name']][widget.locale]??code['name'];
        }
        return  CountryModel.fromJson(code);
      });
      if(widget.locale!='en'){
        countryList.sort((a, b) => a.name.compareTo(b.name));
      }
      selectedCountryData = countryList.firstWhere((_element)=>_element.code==widget.initCountryCode,orElse:()=> countryList[0]);
      // if(widget.initCountryCode!=null){
      //   selectedCountryData = countryList.firstWhere((_element)=>_element.code==widget.initCountryCode);
      // }else{
      // }

      setState(() {

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
          showDialogue(context,widget.dialogType);
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

  Future<void> showDialogue(BuildContext context,DialogType dialogType) async {

    CountryModel? countryData;

    if(dialogType== DialogType.MOdalBottomDialog){
      countryData =await showModalBottomSheet(context: context,
          isScrollControlled: true,
          backgroundColor: Colors.white,
          builder: (BuildContext context) {
            return FractionallySizedBox(
              heightFactor: 0.9, // 화면의 80%만 차지
              child: CountryPickerBottomDialog(
                searchList: countryList,
                enableDivider: widget.enableDivider,
                callBackFunction: widget.callBackFunction,
                headerText: widget.headerText,
                headerBackgroundColor: widget.headerBackgroundColor,
                headerTextColor: widget.headerTextColor,
                locale: widget.locale, // Pass locale to dialog
              ),
            );
          });
    }else{
      countryData = await showDialog(
        context: context,
        builder: (BuildContext context) => CountryPickerDialog(
          searchList: countryList,
          enableDivider: widget.enableDivider,
          callBackFunction: widget.callBackFunction,
          headerText: widget.headerText,
          headerBackgroundColor: widget.headerBackgroundColor,
          headerTextColor: widget.headerTextColor,
          locale: widget.locale, // Pass locale to dialog
        ),
      );
    }

    if (countryData != null) {
      selectedCountryData = countryData as CountryModel;
    }
    setState(() {});
  }
}


