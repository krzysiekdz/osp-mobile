part of '../index.dart';

class TCaptionValue {
  final dynamic left;
  final dynamic right;
  final String dright;
  const TCaptionValue({this.left, this.right, this.dright = '-'});
}

class CardCaptionValue extends StatelessWidget {
  const CardCaptionValue(
      {super.key, this.title = '', this.children = const []});

  final String title;
  final List<TCaptionValue> children;

  @override
  Widget build(BuildContext context) {
    final deviceData = MediaQuery.of(context);
    final scale = deviceData.textScaler.scale(10);

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (title.isNotEmpty)
        Text(title,
            style:
                displaySmall(context)?.copyWith(fontWeight: FontWeight.normal)),
      SizedBox(
        width: double.infinity,
        child: Container(
            margin: const EdgeInsets.fromLTRB(0, gap, 0, 0),
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (TCaptionValue d in children) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0, vertical: gap),
                    // child: scale <= 10
                    child: scale <= 1
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: buildCaptionValue(d, context),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: buildCaptionValue(d, context),
                          ),
                  ),
                  line(),
                ]
              ],
            )),
      )
    ]);
  }

  List<Widget> buildCaptionValue(TCaptionValue d, BuildContext context) {
    return <Widget>[
      if (d.left is String) Text(d.left, style: labelMedium(context)),
      if (d.left is Widget) d.left,
      if (d.right is String)
        Text((d.right as String).isNotEmpty ? d.right : d.dright,
            style: labelMedium(context)?.copyWith(fontWeight: FontWeight.bold)),
      if (d.right is Widget) d.right,
    ];
  }
}
