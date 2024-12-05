part of '../index.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  const AppCard(
      {super.key,
      required this.child,
      this.padding = const EdgeInsets.all(0),
      this.margin = const EdgeInsets.only(
          bottom: gap / 2, top: gap / 2, left: gap, right: gap)});

  final EdgeInsets padding;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: padding,
        margin: margin,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey
                  : const Color.fromARGB(255, 60, 68, 72),
              offset: const Offset(0.0, 0.8), //(x,y)
              blurRadius: 1,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: child);
  }
}
