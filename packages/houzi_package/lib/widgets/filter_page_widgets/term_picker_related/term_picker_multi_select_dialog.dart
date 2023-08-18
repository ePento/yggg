import 'package:flutter/material.dart';
import 'package:houzi_package/widgets/generic_text_widget.dart';

import 'package:houzi_package/files/generic_methods/utility_methods.dart';

typedef MultiSelectDialogWidgetListener = void Function(
  List<dynamic> listOfSelectedItems,
  List<dynamic> listOfSelectedItemsSlugs,
);

class MultiSelectDialogWidget extends StatefulWidget{

  final String title;
  final List<dynamic> dataItemsList;
  final List<dynamic> selectedItemsList;
  final List<dynamic>? selectedItemsSlugsList;
  final MultiSelectDialogWidgetListener multiSelectDialogWidgetListener;
  
  final bool fromCustomFields;
  final bool fromAddProperty;
  final bool fromSearchPage;

  MultiSelectDialogWidget({
    Key? key,
    required this.title,
    required this.dataItemsList,
    required this.selectedItemsList,
    this.selectedItemsSlugsList,
    required this.multiSelectDialogWidgetListener,
    this.fromCustomFields = false,
    this.fromAddProperty = false,
    this.fromSearchPage = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => MultiSelectDialogWidgetState();

}

class MultiSelectDialogWidgetState extends State<MultiSelectDialogWidget> {

  List<dynamic> dataItemsList = [];
  List<dynamic> selectedItemsList = [];
  List<dynamic> selectedItemsSlugsList = [];

  List<dynamic> _parentChildFormatList = [];


  @override
  void initState() {
    super.initState();
    if(widget.dataItemsList != null && widget.dataItemsList.isNotEmpty){
      dataItemsList = widget.dataItemsList;
    }

    if(widget.selectedItemsList != null && widget.selectedItemsList.isNotEmpty){
      selectedItemsList = widget.selectedItemsList;
    }

    if(widget.selectedItemsSlugsList != null && widget.selectedItemsSlugsList!.isNotEmpty){
      selectedItemsSlugsList = widget.selectedItemsSlugsList!;
    }

    if (widget.fromCustomFields) {
      _parentChildFormatList = dataItemsList;
    } else {
      if (dataItemsList != null && dataItemsList.isNotEmpty) {
        List<dynamic> tempList = [];
        List<dynamic> tempList01 = [];
        for (int i = 0; i < dataItemsList.length; i++) {
          if (dataItemsList[i].parent == 0) {
            tempList.add(dataItemsList[i]);
          }
        }

        for (int i = 0; i < tempList.length; i++) {
          for (int j = 0; j < dataItemsList.length; j++) {
            if (tempList[i].id == dataItemsList[j].parent) {
              tempList01.add(dataItemsList[j]);
            }
          }
          _parentChildFormatList.add(tempList[i]);
          _parentChildFormatList.addAll(tempList01);
          tempList01 = [];
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: GenericTextWidget(widget.title),
      contentPadding: const EdgeInsets.only(top: 12.0),
      content: SingleChildScrollView(
        child: ListTileTheme(
          child: ListBody(
            children: _parentChildFormatList.map((item) {
              String title = widget.fromCustomFields ? item.parent : item.name;
              final checked = widget.fromSearchPage ?
              selectedItemsList.contains(item.name) : selectedItemsList.contains(title);

              return CheckboxListTile(
                value: checked,
                title: GenericTextWidget(widget.fromCustomFields ? title : item.parent == 0 ? title :'- $title'),
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (checked) => _onItemCheckedChange(item, checked!),
              );
            }).toList(),
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: GenericTextWidget(UtilityMethods.getLocalizedString("cancel")),
          onPressed: ()=> Navigator.pop(context),
        ),
        TextButton(
          child: GenericTextWidget(UtilityMethods.getLocalizedString("ok")),
          onPressed: () {
            widget.multiSelectDialogWidgetListener(selectedItemsList, selectedItemsSlugsList);
            Navigator.pop(context);
          },
        )
      ],
    );
  }

  void _onItemCheckedChange(dynamic item, bool checked) {
    setState(() {
      if (checked) {
        if (widget.fromCustomFields) {
          selectedItemsList.add(item.parent);
          if (widget.fromSearchPage) {
            selectedItemsSlugsList.add(item.name);
          }
        } else if (widget.fromAddProperty) {
          selectedItemsList.add(item.name);
          selectedItemsSlugsList.add(item.id);
        } else {
          selectedItemsList.add(item.name);
          selectedItemsSlugsList.add(item.slug);
        }
      } else {
        if (widget.fromCustomFields) {
          selectedItemsList.remove(item.parent);
        } else if (widget.fromAddProperty) {
          selectedItemsList.remove(item.name);
          selectedItemsSlugsList.remove(item.id);
        } else {
          selectedItemsList.remove(item.name);
          selectedItemsSlugsList.remove(item.slug);
        }
      }
    });
  }
}