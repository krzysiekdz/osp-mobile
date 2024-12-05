part of '../index.dart';

class NotFound extends StatelessWidget {
  final OspRouteParams? config;
  const NotFound({
    super.key,
    this.config,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nie znaleziono'),
      ),
      body: const Center(child: Text('Nie znaleziono')),
      bottomNavigationBar: config?.menuBottom,
    );
  }
}
