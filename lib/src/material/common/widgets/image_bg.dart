part of '../index.dart';

class AppImgBg extends StatelessWidget {
  final String image;
  final double opacity;
  final BoxFit fit;
  final Widget? child;

  const AppImgBg({
    super.key,
    this.child,
    this.image = 'assets/images/bg.jpg',
    this.opacity = 0.1,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: fit,
          colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.background, BlendMode.saturation),
          opacity: opacity,
        ),
      ),
      child: child,
    );
  }
}
