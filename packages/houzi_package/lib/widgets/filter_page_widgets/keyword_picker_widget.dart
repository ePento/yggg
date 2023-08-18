import 'package:flutter/material.dart';
import 'package:houzi_package/common/constants.dart';
import 'package:houzi_package/files/generic_methods/general_notifier.dart';
import 'package:houzi_package/files/generic_methods/utility_methods.dart';
import 'package:houzi_package/models/filter_page_config.dart';
import 'package:houzi_package/widgets/filter_page_widgets/drop_down_widget.dart';
import 'package:houzi_package/widgets/filter_page_widgets/keyword_widgets/keyword_input_field_widget.dart';
import 'package:houzi_package/widgets/filter_page_widgets/string_picker.dart';

typedef  KeywordPickerWidgetListener = void Function(String keywordString);

class KeywordPickerWidget extends StatefulWidget {
  final String pickerTitle;
  final String pickerType;
  final Icon pickerIcon;
  final String? hintText;
  final TextEditingController textEditingController;
  final FilterPageElement filterObj;
  final KeywordPickerWidgetListener keywordPickerWidgetListener;
  final Map<String, dynamic>? dataMap;

  const KeywordPickerWidget({
    Key? key,
    required this.filterObj,
    required this.pickerTitle,
    required this.pickerType,
    required this.pickerIcon,
    this.hintText,
    required this.textEditingController,
    this.dataMap,
    required this.keywordPickerWidgetListener,
  }): super(key: key);

  @override
  State<StatefulWidget> createState() => _KeywordPickerWidgetState();

}

class _KeywordPickerWidgetState extends State<KeywordPickerWidget> {

  String? _optionsString;
  String? _selectedOptionsString;
  String? _uniqueKey;
  List<String> _optionsList = [];
  List<String> _selectedOptionsList = [];

  VoidCallback? generalNotifierLister;

  @override
  void initState() {
    // get the options string
    _optionsString = widget.filterObj.options ?? "";
    // get the Unique Key
    _uniqueKey = widget.filterObj.uniqueKey;

    // reset the controller
    if (_uniqueKey != null && _uniqueKey!.isNotEmpty) {
      // add keyword prefix
      if (!_uniqueKey!.contains(KEYWORD_PREFIX)) {
        _uniqueKey = KEYWORD_PREFIX + _uniqueKey!;
      }

      // reset the controller
      widget.textEditingController.text = "";

      // get the selected options string
      if (widget.dataMap != null && widget.dataMap!.isNotEmpty) {
        _selectedOptionsString = widget.dataMap![_uniqueKey!];
        widget.textEditingController.text = _selectedOptionsString ?? "";
      }
    }

    if (widget.pickerType == stringPickerKey || widget.pickerType == dropDownPicker) {
      if (_optionsString!.isNotEmpty) {
        _optionsList = UtilityMethods.getListFromString(_optionsString);
      }

      if (_selectedOptionsString != null && _selectedOptionsString!.isNotEmpty) {
        _selectedOptionsList = UtilityMethods.getListFromString(_selectedOptionsString);
      }

    }

    //
    // for testing purposes:
    //
    // print("_optionsString: $_optionsString");
    // print("_uniqueKey: $_uniqueKey");
    // print("_selectedOptionsString: $_selectedOptionsString");
    // print("_optionsList: $_optionsList");
    // print("_selectedOptionsList: $_selectedOptionsList");

    generalNotifierLister = () {
      if (GeneralNotifier().change == GeneralNotifier.RESET_FILTER_DATA) {
        resetData();
      }
    };
    GeneralNotifier().addListener(generalNotifierLister!);

    super.initState();
  }

  resetData() {
    if (mounted) {
      setState(() {
        _selectedOptionsList = [];
        widget.keywordPickerWidgetListener(UtilityMethods.getStringFromList(_selectedOptionsList));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.pickerType) {

      case(stringPickerKey): {
        if (_optionsList.isNotEmpty) {
          return StringPicker(
              pickerTitle: UtilityMethods.getLocalizedString(widget.pickerTitle),
              pickerType: widget.pickerType,
              pickerIcon: widget.pickerIcon,
              pickerDataList: _optionsList,
              selectedItemsList: _selectedOptionsList,
              stringPickerListener: (List<dynamic> _selectedItemsList){
                if (_selectedItemsList.isNotEmpty) {
                  _selectedOptionsList = List<String>.from(_selectedItemsList);
                } else {
                  _selectedOptionsList = [];
                }

                widget.keywordPickerWidgetListener(UtilityMethods.getStringFromList(_selectedOptionsList));
              }
          );
        }
        return Container();
      }

      case(dropDownPicker): {
        return FilterStringMultiSelectWidget(
          pickerTitle: UtilityMethods.getLocalizedString(widget.pickerTitle),
          pickerIcon: widget.pickerIcon,
          dataList: _optionsList,
          selectedDataList: _selectedOptionsList,
          listener: (selectedItems) {
            _selectedOptionsList = selectedItems;
            widget.keywordPickerWidgetListener(UtilityMethods.getStringFromList(_selectedOptionsList));
          },
        );
      }

      default: {
        return KeywordPickerInputField(
          pickerTitle: widget.pickerTitle,
          pickerIcon: widget.pickerIcon,
          controller: widget.textEditingController,
          hintText: widget.hintText,
          listener: (keywordString) => widget.keywordPickerWidgetListener(keywordString),
        );
      }
    }
  }
}