part of '../index.dart';

class AppTextErr extends StatelessWidget {
  final String text;
  final bool isBold;
  final double size;
  const AppTextErr(this.text, {super.key, this.isBold = false, this.size = 16});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : null,
            fontSize: size,
            color: Theme.of(context).colorScheme.error));
  }
}
