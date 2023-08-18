import 'package:flutter/material.dart';
import 'package:houzi_package/models/form_related/houzi_form_page.dart';
import 'package:houzi_package/widgets/form_widgets/generic_form_widget.dart';

typedef AddPropertyFormWidgetListener = void Function(Map<String, dynamic> dataMap);

class AddPropertyFormWidget extends StatelessWidget {
  final List<HouziFormSectionFields> formSectionFieldsList;
  final GlobalKey<FormState>? formStateKey;
  final Map<String, dynamic>? infoDataMap;
  final bool isPropertyForUpdate;
  final AddPropertyFormWidgetListener listener;

  const AddPropertyFormWidget({
    required this.formSectionFieldsList,
    this.isPropertyForUpdate = false,
    this.formStateKey,
    this.infoDataMap,
    required this.listener,
  });

  @override
  Widget build(BuildContext context) {
    return GenericFormWidget(
      formStateKey: formStateKey,
      formSectionFieldsList: formSectionFieldsList,
      infoDataMap: infoDataMap,
      isPropertyForUpdate: isPropertyForUpdate,
      listener: listener,
    );
  }
}
