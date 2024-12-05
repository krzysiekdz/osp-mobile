import 'package:osp_mobile/src/flutter/modules/app/index.dart';
import 'package:osp_mobile/src/material/common/index.dart';

class Dashboard extends StatelessWidget {
  final OspRouteParams? config;
  const Dashboard({super.key, this.config});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pulpit'),
        actions: [
          IconButton(
              onPressed: () {
                context.read<OspAppCubit>().logout();
              },
              tooltip: 'Wyloguj',
              icon: const Icon(Icons.logout))
        ],
      ),
      body: const Center(
        child: Text('Pulpit'),
      ),
      bottomNavigationBar: config?.menuBottom,
    );
  }
}
