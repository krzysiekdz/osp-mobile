part of 'index.dart';

class StrazakPreview extends StatefulWidget {
  const StrazakPreview({super.key, required this.appState, required this.item});

  final AppSession appState;
  final Strazak item;

  @override
  State<StatefulWidget> createState() => StrazakPreviewState();
}

class StrazakPreviewState extends State<StrazakPreview>
    with SingleTickerProviderStateMixin {
  AppSession get appState => widget.appState;
  late Strazak item;

  late final TabController tabController;

  OspRouteReturnData? returnData;

  final List<Tab> tabs = const [
    Tab(text: 'Dane strażackie'),
    Tab(text: 'Dane osobowe'),
    Tab(text: 'Dane kontaktowe'),
    Tab(text: 'Wymiary'),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
    item = widget.item;
  }

  void updatePreview(Strazak item) {
    setState(() {
      this.item = item;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void goToEdit() {
    Timer(const Duration(milliseconds: 200), () async {
      final OspRouteReturnData? ret = await Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => StrazakFormController(id: item.id)));
      if (ret != null && (ret.data is Strazak)) {
        returnData = ret;
        updatePreview(ret.data);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          Navigator.pop(context, returnData);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('${item.nazwisko} ${item.imie}'),
          actions: [
            IconButton(onPressed: goToEdit, icon: const Icon(Icons.edit))
          ],
        ),
        body: Column(
          children: [
            const SizedBox(height: gap),
            Padding(
              padding: const EdgeInsets.all(gap),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    margin: const EdgeInsets.all(0),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: StrazakImg(
                        imgUrl: item.imgUrl,
                        width: 140,
                        height: 180,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        IconButton.filled(
                            onPressed: () {}, icon: const Icon(Icons.phone)),
                        const Text('Zadzwoń'),
                        space(2),
                        IconButton.filled(
                            onPressed: () {}, icon: const Icon(Icons.sms)),
                        const Text('SMS'),
                      ],
                    ),
                  )
                ],
              ),
            ),
            space(),
            TabBar(
              tabs: tabs,
              controller: tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
            ),
            Expanded(
              child: TabBarView(controller: tabController, children: [
                StrazacyPreviewTab1(
                  item: item,
                  appState: appState,
                ),
                StrazacyPreviewTab2(
                  item: item,
                  appState: appState,
                ),
                StrazacyPreviewTab3(
                  item: item,
                  appState: appState,
                ),
                StrazacyPreviewTab4(
                  item: item,
                  appState: appState,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

//Tab 1
class StrazacyPreviewTab1 extends StatefulWidget {
  const StrazacyPreviewTab1(
      {super.key, required this.item, required this.appState});

  final Strazak item;
  final AppSession appState;

  @override
  State<StrazacyPreviewTab1> createState() => _StrazacyPreviewTab1State();
}

class _StrazacyPreviewTab1State extends State<StrazacyPreviewTab1>
    with AutomaticKeepAliveClientMixin {
  AppSession get appState => widget.appState;
  Strazak get item => widget.item;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: gap),
      child: Column(
        children: [
          CardCaptionValue(children: [
            TCaptionValue(
                left: 'Stopień',
                right: TDict.find(appState.strazakStopien, item.stopien, "-")
                    .text),
            TCaptionValue(
                left: 'Rodzaj',
                right: TDict.find(Strazak.rodzaje(), item.rodzaj, "-").text),
            TCaptionValue(
              left: const SizedBox(),
              right: item.inActions
                  ? Text('Bierze udział w akcjach',
                      style: labelMedium(context)?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: successColor(context)))
                  : Text('Nie bierze udziału w akcjach',
                      style: labelMedium(context)?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: errorColor(context))),
            ),
            TCaptionValue(
                left: const SizedBox(),
                right: item.czyJot
                    ? Text('Należy do JOT',
                        style: labelMedium(context)?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: successColor(context)))
                    : Text('Nie należy do JOT',
                        style: labelMedium(context)?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: errorColor(context)))),
            if (item.czyOpiekunMdp)
              TCaptionValue(
                  left: const SizedBox(),
                  right: Text('Jest opiekunem MDP',
                      style: labelMedium(context)?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: successColor(context)))),
            TCaptionValue(
                left: 'Zarząd OSP',
                right: item.czyZarzad
                    ? Text(TDict.find(appState.zarzad, item.zarzad).text,
                        style: labelMedium(context)?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: primaryColor(context)))
                    : '-'),
            TCaptionValue(
                left: 'Komisja rewizyjna',
                right: item.czyKomisja
                    ? Text(TDict.find(appState.komisja, item.komisja).text,
                        style: labelMedium(context)?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: primaryColor(context)))
                    : '-'),
            TCaptionValue(left: 'Nr legitymacji', right: item.nrLegitymacji),
            TCaptionValue(left: 'Data wstąpienia', right: item.dataWstapienia),
          ]),
        ],
      ),
    );
  }
}

//Tab 2
class StrazacyPreviewTab2 extends StatefulWidget {
  const StrazacyPreviewTab2(
      {super.key, required this.item, required this.appState});

  final Strazak item;
  final AppSession appState;

  @override
  State<StrazacyPreviewTab2> createState() => _StrazacyPreviewTab2State();
}

class _StrazacyPreviewTab2State extends State<StrazacyPreviewTab2>
    with AutomaticKeepAliveClientMixin {
  AppSession get appState => widget.appState;
  Strazak get item => widget.item;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: gap),
      child: Column(
        children: [
          CardCaptionValue(children: [
            TCaptionValue(
                left: 'Nazwisko i imię',
                right: "${item.nazwisko} ${item.imie} ${item.drugieImie}"),
            TCaptionValue(left: "PESEL", right: item.pesel),
            TCaptionValue(left: "Data urodzenia", right: item.dataUr),
            TCaptionValue(left: "Miejsce urodzenia", right: item.miejsceUr),
            TCaptionValue(
                left: "Wykształcenie",
                right: TDict.find(appState.wyksztalcenie, item.wyksztalcenie)
                    .text),
            TCaptionValue(left: "Zawód", right: item.zawod),
            TCaptionValue(
                left: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Miejsce pracy",
                  style: labelMedium(context),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  item.miejscePracy,
                  style: labelMedium(context)
                      ?.copyWith(fontWeight: FontWeight.bold),
                )
              ],
            )),
            TCaptionValue(left: "Imię ojca", right: item.imieOjca),
          ]),
        ],
      ),
    );
  }
}

//Tab 3
class StrazacyPreviewTab3 extends StatefulWidget {
  const StrazacyPreviewTab3(
      {super.key, required this.item, required this.appState});

  final Strazak item;
  final AppSession appState;

  @override
  State<StrazacyPreviewTab3> createState() => _StrazacyPreviewTab3State();
}

class _StrazacyPreviewTab3State extends State<StrazacyPreviewTab3>
    with AutomaticKeepAliveClientMixin {
  AppSession get appState => widget.appState;
  Strazak get item => widget.item;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: gap),
      child: Column(
        children: [
          CardCaptionValue(children: [
            TCaptionValue(
                left: 'Adres',
                right: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   "Adres",
                    //   style: labelMedium(context),
                    // ),
                    // const SizedBox(
                    //   height: 6,
                    // ),
                    Text(
                      "${item.kodPocztowy} ${item.poczta}",
                      style: labelMedium(context)
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${item.miejscowosc != item.poczta ? item.miejscowosc : ''} ${item.ulica} ${item.nrBudynku}",
                      style: labelMedium(context)
                          ?.copyWith(fontWeight: FontWeight.bold),
                    )
                  ],
                )),
            TCaptionValue(left: "E-mail", right: item.email),
            TCaptionValue(left: "Nr telefonu", right: item.nrTel),
          ]),
        ],
      ),
    );
  }
}

//Tab 4
class StrazacyPreviewTab4 extends StatefulWidget {
  const StrazacyPreviewTab4(
      {super.key, required this.item, required this.appState});

  final Strazak item;
  final AppSession appState;

  @override
  State<StrazacyPreviewTab4> createState() => _StrazacyPreviewTab4State();
}

class _StrazacyPreviewTab4State extends State<StrazacyPreviewTab4>
    with AutomaticKeepAliveClientMixin {
  AppSession get appState => widget.appState;
  Strazak get item => widget.item;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: gap),
      child: Column(
        children: [
          CardCaptionValue(children: [
            TCaptionValue(left: "Wzrost", right: sizeOrEmpty(item.wzrost)),
            TCaptionValue(
                left: "Nr buta", right: item.nrButa > 0 ? item.nrButa : '-'),
            TCaptionValue(left: "Rozmiar dłoni", right: item.rozmiarRloni),
            TCaptionValue(
                left: "Obwód w klatce piersiowej",
                right: sizeOrEmpty(item.obWKlatcePiers)),
            TCaptionValue(
                left: "Obwód w pasie", right: sizeOrEmpty(item.obWPasie)),
            TCaptionValue(
                left: "Obwód głowy", right: sizeOrEmpty(item.obwodGlowy)),
            TCaptionValue(
                left: "Obwód szyi", right: sizeOrEmpty(item.obwodSzyi)),
          ]),
        ],
      ),
    );
  }

  String sizeOrEmpty(double v) => v > 0 ? "$v cm" : '-';
}
