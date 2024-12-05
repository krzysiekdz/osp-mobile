part of '../index.dart';

class StrazakImg extends StatelessWidget {
  const StrazakImg(
      {super.key, required this.imgUrl, this.width = 64, this.height = 64});

  final String imgUrl;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    // final imgLight = Image(
    //     width: width,
    //     height: height,
    //     fit: BoxFit.cover,
    //     color: const Color.fromRGBO(211, 47, 47, 0.5),
    //     colorBlendMode: BlendMode.colorDodge,
    //     image: const AssetImage('assets/images/fireman.jpg'));

    // final imgDark = Image(
    //     width: width,
    //     height: height,
    //     fit: BoxFit.cover,
    //     color: const Color.fromRGBO(33, 33, 33, 0.6),
    //     colorBlendMode: BlendMode.darken,
    //     image: const AssetImage('assets/images/fireman.jpg'));

    // final emptyImg =
    //     Theme.of(context).brightness == Brightness.dark ? imgDark : imgLight;
    return Image(
        width: width,
        height: height,
        fit: BoxFit.cover,
        image: imgUrl.isEmpty
            ? const AssetImage('assets/images/fireman.jpg') as ImageProvider
            : NetworkImage(imgUrl));

    // return CircleAvatar(
    //   radius: width / 2,
    //   backgroundImage: imgUrl.isEmpty
    //       ? const AssetImage('assets/images/fireman.jpg')
    //       : NetworkImage(imgUrl) as ImageProvider,
    // );
  }
}
