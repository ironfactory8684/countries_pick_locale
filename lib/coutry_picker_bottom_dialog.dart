// CustomDialog class should also use locale
import 'package:flutter/material.dart';

import 'support/country_model.dart';
import 'support/country_picker_translate_mdoel.dart';

class CountryPickerBottomDialog extends StatefulWidget {
  const CountryPickerBottomDialog({
    required this.searchList,
    required this.callBackFunction,
    this.headerText,
    this.enableDivider=true,
    this.headerBackgroundColor,
    this.headerTextColor,
    this.locale = 'en', // Default locale is English
  });

  final List<CountryModel> searchList;
  final Function(String dialCode,String flag) callBackFunction;
  final String? headerText;
  final Color? headerBackgroundColor;
  final Color? headerTextColor;
  final String locale;
  final bool enableDivider;


  @override
  _CountryPickerBottomDialogState createState() => _CountryPickerBottomDialogState();
}

class _CountryPickerBottomDialogState extends State<CountryPickerBottomDialog> {
  List<CountryModel> tmpList = [];

  @override
  void initState() {
    super.initState();
    tmpList = widget.searchList;
  }

  @override
  Widget build(BuildContext context) {
    return dialogContent(context);
  }

  Widget dialogContent(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(

          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 52,
            decoration: BoxDecoration(
                color: widget.headerBackgroundColor ,
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    CountryPickerTranslateType.selectCountryByLocale(widget.locale),
                    style: TextStyle(fontSize: 18, color: widget.headerTextColor ?? Colors.black),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      CountryPickerTranslateType.cancelByLocale(widget.locale),
                      style: TextStyle(color: widget.headerTextColor ?? Colors.blue),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8),
            height: 45,
            decoration: BoxDecoration(
              color: const Color.fromARGB(8, 0, 0, 0),
              borderRadius: BorderRadius.circular(36),
            ),
            child: TextField(
              decoration: InputDecoration(
                  hintText: CountryPickerTranslateType.searchCountryByLocale(widget.locale),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 18.0,
                    color: Colors.black38,
                  )),
              onChanged: filterData,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...tmpList.map(
                        (item) => GestureDetector(
                      onTap: () {
                        Navigator.pop(context, item);
                        widget.callBackFunction(
                            // item.getLocalizedName(widget.locale),
                            item.dialCode,
                            item.flag
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Color(0xffC8C8C8
                          )))
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.flag,
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                item.name,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              item.dialCode,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void filterData(String text) {
    tmpList = [];
    if (text == '') {
      tmpList.addAll(widget.searchList);
    } else {
      widget.searchList.forEach((userDetail) {
        if (userDetail.name.toLowerCase().contains(text.toLowerCase())) {
          tmpList.add(userDetail);
        }
      });
    }
    setState(() {});
  }
}