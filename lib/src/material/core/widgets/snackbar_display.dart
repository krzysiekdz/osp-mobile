part of '../index.dart';

class SnackbarDisplay extends StatefulWidget {
  final String snackbarMsg;
  final SnackBarType snackbarType;
  const SnackbarDisplay(
      {super.key,
      this.snackbarMsg = '',
      this.snackbarType = SnackBarType.error});

  @override
  State<SnackbarDisplay> createState() => _SnackbarDisplayState();
}

class _SnackbarDisplayState extends State<SnackbarDisplay> {
  @override
  void initState() {
    super.initState();
    _callShowSnackbar();
  }

  @override
  void didUpdateWidget(covariant SnackbarDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);
    _callShowSnackbar();
  }

  void _callShowSnackbar() {
    if (widget.snackbarMsg != '') {
      Future.delayed(const Duration(milliseconds: 200), () {
        _showSnackbar();
      });
    }
  }

  void _showSnackbar() {
    MatUtils.showSnackBar(context, widget.snackbarMsg, widget.snackbarType);
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 0);
  }
}


/*
Builder(builder: (context) {
  if (widget.snackbarMsg != '') {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(widget.snackbarMsg),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ));
    });
  }
  return const Text('');
})

*/
