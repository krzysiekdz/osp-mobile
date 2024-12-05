part of 'index.dart';

Widget space([double f = 1.0]) => SizedBox(height: f * gap);

Widget line({double f = 1.0, double padding = 0.0}) => Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: padding),
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 0.2, color: Color.fromARGB(255, 90, 90, 90)))),
    );
