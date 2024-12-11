part of '../index.dart';

typedef FormChangeCallback<T> = T Function(T item, String s);

class AppTextFormField<T extends TBase, C extends BaseFormCubit<T>>
    extends StatelessWidget {
  final String initialValue;
  final String label;
  final FormChangeCallback<T> onFormChange;
  const AppTextFormField(
      {super.key,
      this.initialValue = '',
      this.label = '',
      required this.onFormChange});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: label.isNotEmpty ? InputDecoration(label: Text(label)) : null,
      onChanged: (v) {
        final cub = context.read<C>();
        cub.updateForm(onFormChange(cub.state.current!, v),
            onFormChange(cub.state.buffer!, v));
      },
    );
  }
}
