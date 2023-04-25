import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputFieldWidget extends StatefulWidget {
  final String label;
  final TextEditingController textEditingController;
  final bool isPasswordField;
  final Function onTap;
  InputFieldWidget(this.label, this.textEditingController,
      {this.isPasswordField = false, this.onTap});
  @override
  State<StatefulWidget> createState() {
    return _InputFieldWidgetState();
  }
}

class _InputFieldWidgetState extends State<InputFieldWidget> {
  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    if (widget.isPasswordField) {
      return _passwordWidget(context);
    }
    if (widget.onTap != null) {
      return _onTapTextWidget(context);
    }
    return _textWidget(context);
  }

  Widget _textWidget(BuildContext context) {
    return TextField(
      controller: widget.textEditingController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0.sp),
          ),
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[800]),
          hintText: widget.label,
          fillColor: Colors.white70),
    );
  }

  Widget _onTapTextWidget(BuildContext context) {
    return InkWell(
      onTap: () => widget.onTap(),
      child: TextField(
        enabled: false,
        controller: widget.textEditingController,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0.sp),
            ),
            filled: true,
            hintStyle: TextStyle(color: Colors.grey[800]),
            hintText: widget.label,
            fillColor: Colors.white70),
      ),
    );
  }

  Widget _passwordWidget(BuildContext context) {
    return TextField(
      controller: widget.textEditingController,
      obscureText: _passwordVisible,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0.sp),
          ),
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[800]),
          hintText: widget.label,
          fillColor: Colors.white70,
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility_off : Icons.visibility,
              color: Theme.of(context).primaryColorDark,
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          )),
    );
  }
}
