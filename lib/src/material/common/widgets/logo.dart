part of '../index.dart';

class AppLogo extends StatelessWidget {
  final double width;
  const AppLogo({super.key, this.width = 64});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/fire2.png',
      width: width,
    );
  }
}
