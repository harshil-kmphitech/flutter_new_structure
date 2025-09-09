import 'package:app/app/ui/widgets/custom_image_view.dart';
import 'package:app/app/utils/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

part 'text_editing_controllers.dart';

class _SuffixIcon extends StatelessWidget {
  const _SuffixIcon({required this.showing});

  final RxBool showing;

  @override
  Widget build(BuildContext context) {
    /// If you have to change the suffixIcon widget so you must have to be change you icon here.
    return ExcludeFocus(
      child: IconButton(
        icon: Icon(showing.value ? Icons.visibility : Icons.visibility_off),
        onPressed: showing.toggle,
      ),
    );
  }
}

class TextInputField extends TextFormField {
  TextInputField({
    super.key,
    required super.controller,
    required this.type,
    required String hintLabel,
    super.textInputAction = TextInputAction.next,
    super.maxLines,
    super.minLines,
    super.autovalidateMode = AutovalidateMode.onUnfocus,
    super.validator,
    super.enabled,
    super.readOnly,
    super.expands,
    super.obscuringCharacter,
    this.prefixIcon,
    TextInputType? keyboardType,
    Iterable<String>? autoFillHints,
    Widget? suffixIcon,
    List<TextInputFormatter>? inputFormatters,
  }) : assert(
         type != InputType.multiline || textInputAction == TextInputAction.newline,
         'Make textInputAction = TextInputAction.newline',
       ),
       assert(
         (type != InputType.password &&
                 type != InputType.newPassword &&
                 type != InputType.confirmPassword) ||
             controller is PasswordController,
         'Make sure your providing obscureText and Wrap Obx on TextInputField',
       ),
       super(
         style: TextFieldStyleProvider.styleOf,
         keyboardType:
             keyboardType ??
             switch (type) {
               InputType.name => TextInputType.name,
               InputType.text => TextInputType.text,
               InputType.email => TextInputType.emailAddress,
               InputType.password => TextInputType.visiblePassword,
               InputType.confirmPassword => TextInputType.visiblePassword,
               InputType.newPassword => TextInputType.visiblePassword,
               InputType.phoneNumber => TextInputType.phone,
               InputType.digits => TextInputType.number,
               InputType.decimalDigits => const TextInputType.numberWithOptions(decimal: true),
               InputType.multiline => TextInputType.multiline,
             },
         textCapitalization: switch (type) {
           InputType.name ||
           InputType.text ||
           InputType.newPassword ||
           InputType.password ||
           InputType.confirmPassword => TextCapitalization.words,
           InputType.multiline => TextCapitalization.sentences,
           _ => TextCapitalization.none,
         },
         autofillHints: [
           if (autoFillHints != null) ...autoFillHints,
           switch (type) {
             InputType.name => AutofillHints.name,
             InputType.email => AutofillHints.email,
             InputType.password => AutofillHints.password,
             InputType.confirmPassword => AutofillHints.password,
             InputType.newPassword => AutofillHints.newPassword,
             InputType.phoneNumber => AutofillHints.telephoneNumber,
             _ => '',
           },
         ],
         inputFormatters: [
           if (inputFormatters != null) ...inputFormatters,
           if (type == InputType.digits) FilteringTextInputFormatter.digitsOnly,
           if (type == InputType.decimalDigits)
             FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
         ],
         obscureText: _obscureText(controller),
         decoration: InputDecoration(
           labelText: hintLabel,
           // hintText: hintLabel,
           prefixIconConstraints: _prefixIconConstraints(prefixIcon is ImageView, maxLines),
           prefixIcon: _prefixIcon(prefixIcon, maxLines),
           suffixIcon: _suffixIcon(suffixIcon: suffixIcon, type: type, controller: controller),
         ),
       );

  final InputType type;
  final Widget? prefixIcon;

  @override
  FormFieldBuilder<String> get builder => (field) {
    var builder = super.builder(field);

    if (type == InputType.multiline && prefixIcon != null) {
      builder = Stack(
        children: [
          super.builder(field),
          ConstrainedBox(
            constraints: BoxConstraints.loose(const Size.square(50)),
            child: Center(child: prefixIcon),
          ),
        ],
      );
    }

    return builder;
  };

  static bool _obscureText(TextEditingController? controller) {
    if (controller is PasswordController) {
      return controller.obscureText.value;
    }

    return false;
  }

  static BoxConstraints? _prefixIconConstraints(bool isPrefixIcon, int? maxLines) {
    if (maxLines case != null && > 1) {
      return const BoxConstraints(maxWidth: 50);
    }

    if (isPrefixIcon) {
      return BoxConstraints.loose(const Size.square(50));
    }

    return null;
  }

  static Widget? _prefixIcon(Widget? prefixIcon, int? maxLines) {
    if (prefixIcon is ImageView) {
      if (maxLines != null && maxLines > 2) {
        return const Center();
      }
      return Center(child: prefixIcon);
    }

    return prefixIcon;
  }

  static Widget? _suffixIcon({
    Widget? suffixIcon,
    required InputType type,
    TextEditingController? controller,
  }) {
    if (suffixIcon != null) {
      return suffixIcon;
    }

    if (controller is PasswordController) {
      return _SuffixIcon(showing: controller.obscureText);
    }

    return null;
  }
}

enum InputType {
  name,
  text,
  email,
  password,
  confirmPassword,
  newPassword,
  phoneNumber,
  digits,
  decimalDigits,
  multiline,
}
