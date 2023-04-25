import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/cupertino.dart';

class DropDownWidget extends StatefulWidget {
  final List<String> items;
  final String initialValue;
  final Function(DropDownValueModel value) onSelect;

  DropDownWidget(this.items, this.initialValue, this.onSelect);

  @override
  State<StatefulWidget> createState() {
    return _DropDownWidgetState();
  }
}

class _DropDownWidgetState extends State<DropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return DropDownTextField(
      clearOption: false,
      dropDownItemCount: widget.items.length,
      searchShowCursor: false,
      enableSearch: false,
      initialValue: widget.initialValue,
      dropDownList: widget.items
          .map((e) => DropDownValueModel(name: e, value: e))
          .toList()
          .cast<DropDownValueModel>(),
      onChanged: (value) => widget.onSelect(value),
    );
  }
}
