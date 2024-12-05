part of '../index.dart';

class AppFilledButton extends StatelessWidget {
  final Function? onPressed;
  final String textLabel;
  final bool isPending;
  const AppFilledButton(
      {super.key,
      required this.textLabel,
      this.onPressed,
      this.isPending = false});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        onPressed: onPressed != null
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
