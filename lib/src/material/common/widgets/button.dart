part of '../index.dart';

class AppFilledButton extends StatelessWidget {
  final Function? onPressed;
  final String textLabel;
  final bool isPending;
  final bool isDisabled;
  const AppFilledButton(
      {super.key,
      required this.textLabel,
      this.onPressed,
      this.isDisabled = false,
      this.isPending = false});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        onPressed: (onPressed != null) && !isDisabled
            ? () {
                onPressed!.call();
              }
            : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(textLabel,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(width: isPending ? 16 : 0),
            if (isPending) const CircularProgressIndicator(),
          ],
        ));
  }
}
