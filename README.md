
# Countries Pick Locale

`Countries Pick Locale` is a Flutter package that provides a customizable country picker dialog. It supports multiple locales, allowing users to select a country by name, with the name displayed in the selected language. This package also allows the display of country flags and dial codes.

## Features

- **Country Picker Dialog**: Displays a list of countries for the user to select from.
- **Locale Support**: Supports multiple languages (`en`, `kr`, `zh`, `ja`, `th`) for country names and UI text.
- **Customizable Header**: Customize the header's text, background color, and text color.
- **Country Flags**: Optionally display country flags alongside country names and dial codes.
- **Search Functionality**: Allows users to search for countries within the dialog.

## Installation

Add `countries_pick_locale` to your `pubspec.yaml` file:

```yaml
dependencies:
  countries_pick_locale:
    git:
      url: https://github.com/yourusername/countries_pick_locale.git
      ref: main
```

Then, run `flutter pub get` to install the package.

## Usage

To use `CountriesPickLocale`, simply include it in your widget tree:

```dart
import 'package:flutter/material.dart';
import 'package:countries_pick_locale/countries_pick_locale.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Country Picker Example'),
        ),
        body: Center(
          child: CountriesPickLocale(
            callBackFunction: (dialCode, flag) {
              print("Selected country dial code: \$dialCode, flag: \$flag");
            },
            locale: 'kr', // Set your desired locale
            headerText: '국가 선택',
            headerBackgroundColor: Colors.blue,
            headerTextColor: Colors.white,
          ),
        ),
      ),
    );
  }
}

void main() => runApp(MyApp());
```

### Properties

- `callBackFunction`: A required callback function that returns the selected country's dial code and flag.
- `headerText`: (Optional) Text for the header. If not provided, the package will use a localized default text.
- `headerBackgroundColor`: (Optional) Background color for the header.
- `headerTextColor`: (Optional) Text color for the header.
- `isFlag`: (Optional) Boolean to show or hide the flag in the picker. Default is `true`.
- `locale`: (Optional) Set the locale for the country names. Default is `'en'`.

### Example

```dart
CountriesPickLocale(
  callBackFunction: (dialCode, flag) {
    print("Selected country dial code: \$dialCode, flag: \$flag");
  },
  locale: 'zh', // Display in Chinese
  headerText: '选择国家',
  headerBackgroundColor: Colors.green,
  headerTextColor: Colors.white,
);
```

## Supported Locales

The following locales are supported:

- **English (`en`)**
- **Korean (`kr`)**
- **Chinese (`zh`)**
- **Japanese (`ja`)**
- **Thai (`th`)**

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgement

This package was inspired by and built upon the concepts from the [country_list_pick](https://pub.dev/packages/country_list_pick) package.

## Additional Notes:
Contributing: If you would like to contribute to the project, feel free to fork the repository and submit a pull request.
Bugs/Issues: If you find any bugs or issues, please open an issue on the GitHub repository.
This README provides a clear overview of the package, how to install and use it, and relevant information such as supported locales and licensing. Adjust the git URL and any other details as per your specific project configuration.