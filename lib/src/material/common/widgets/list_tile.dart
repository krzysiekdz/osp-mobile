part of '../index.dart';

class AppListTile extends StatelessWidget {
  const AppListTile(
      {super.key,
      this.previewBuilder,
      this.leading,
      this.title,
      this.subtitle,
      this.thirdLine});

  final WidgetBuilder? previewBuilder;
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? thirdLine;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: previewBuilder != null
          ? () {
              Timer(const Duration(milliseconds: 200), () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: previewBuilder!));
              });
            }
          : null,
      child: Container(
          key: key,
          width: double.infinity,
          margin:
              const EdgeInsets.symmetric(horizontal: gap, vertical: gap / 2),
          child: Row(
            children: [
              leading ??
                  const SizedBox(
                    width: 64,
                  ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      title ?? const SizedBox(),
                      subtitle ?? const SizedBox(),
                      thirdLine ?? const SizedBox(),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
