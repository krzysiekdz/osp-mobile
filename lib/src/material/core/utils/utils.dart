part of '../index.dart';

enum SnackBarType { error, success, warning, info, normal }

class SnackBarConfig {
  final EdgeInsets? margin;
  final SnackBarBehavior? behavior;
  final Duration? duration;
  const SnackBarConfig({this.margin, this.behavior, this.duration});
}

class MatUtils {
  static void showSnackBar(BuildContext context, String message,
      {SnackBarConfig? config, SnackBarType? type}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: config?.margin,
        behavior: config?.behavior,
        duration: config?.duration ?? const Duration(seconds: 5),
        content: Row(
          children: [
            Icon(
              getIconByType(type),
              color: getTextColorByType(context, type),
            ),
            const SizedBox(width: 8),
            Expanded(
                child: Text(
              message,
              style: TextStyle(
                  color: getTextColorByType(context, type),
                  fontWeight: FontWeight.bold),
            )),
          ],
        ),
        action: SnackBarAction(
          label: 'OK',
          textColor: getTextColorByType(context, type),
          onPressed: () {
            // if (context.mounted) {
            //   ScaffoldMessenger.of(context).hideCurrentSnackBar();
            // }
          },
        ),
        backgroundColor: getColorByType(context, type),
      ),
    );
  }

  static IconData getIconByType(SnackBarType? type) {
    switch (type) {
      case SnackBarType.error:
        return Icons.error;
      case SnackBarType.success:
        return Icons.check_circle;
      case SnackBarType.warning:
        return Icons.warning;
      case SnackBarType.info:
        return Icons.info;
      default:
        return Icons.info_outline;
    }
  }

  static Color getColorByType(BuildContext context, [SnackBarType? type]) {
    switch (type) {
      case SnackBarType.error:
        return Theme.of(context).colorScheme.error;
      case SnackBarType.success:
        return const Color.fromRGBO(58, 137, 62, 1);
      case SnackBarType.warning:
        return Colors.orange;
      case SnackBarType.info:
        return Colors.blue;
      default:
        return Theme.of(context).colorScheme.surface;
    }
  }

  static Color getTextColorByType(BuildContext context, [SnackBarType? type]) {
    switch (type) {
      case SnackBarType.error:
        // return Theme.of(context).colorScheme.onPrimary;
        return Colors.white;
      case SnackBarType.success:
        // return Theme.of(context).colorScheme.onPrimary;
        return Colors.white;
      case SnackBarType.warning:
        return Theme.of(context).colorScheme.onPrimary;
      case SnackBarType.info:
        return Theme.of(context).colorScheme.onPrimary;
      default:
        return Theme.of(context).colorScheme.onSurface;
    }
  }
}
