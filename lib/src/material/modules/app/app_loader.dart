part of 'index.dart';

class AppInitialLoader extends StatelessWidget {
  final AppStateInitial? state;
  final Function? onRetry;
  final String btnText;
  const AppInitialLoader(
      {super.key, this.state, this.onRetry, this.btnText = 'Ponów'});

  bool get isError => state?.error != null && state!.error.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppImgBg(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const AppLogo(
              //   width: 96,
              // ),
              const SizedBox(height: 32),
              const AppTitle(),
              const SizedBox(height: 32),
              if (!isError) const AppLoader(),
              if (isError)
                Column(
                  children: [
                    Card(
                        color: Colors.red[100],
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: ListTile(
                            leading: const Icon(Icons.error),
                            title: Text(state!.error))),
                    const SizedBox(height: 24),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: FilledButton(
                          onPressed: () {
                            onRetry?.call();
                          },
                          style: FilledButton.styleFrom(
                              minimumSize: const Size(double.infinity, 48)),
                          child: Text(btnText)),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
