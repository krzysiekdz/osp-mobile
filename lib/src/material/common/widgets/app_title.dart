part of '../index.dart';

class AppTitle extends StatelessWidget {
  final double fontSize;
  const AppTitle({super.key, this.fontSize = 32});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'OSP',
          style: displayLarge(context)?.copyWith(
            fontSize: fontSize,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          'POŻARNIK',
          style: displayLarge(context)?.copyWith(
            fontSize: fontSize,
            color: primary,
          ),
        ),
      ],
    );
  }
}
