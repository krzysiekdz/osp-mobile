part of 'index.dart';

class FiremanPreview extends StatefulWidget {
  const FiremanPreview({super.key, required this.appState, required this.item});

  final AppSession appState;
  final Fireman item;

  @override
  State<StatefulWidget> createState() => FiremanPreviewState();
}

class FiremanPreviewState extends State<FiremanPreview>
    with SingleTickerProviderStateMixin {
  AppSession get appState => widget.appState;
  late Fireman item;

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

  void updatePreview(Fireman item) {
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
              builder: (context) => FiremanFormController(id: item.id)));
      if (ret != null && (ret.data is Fireman)) {
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
          title: Text('${item.lastName} ${item.firstName}'),
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
                      child: FiremanImg(
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
                FiremanPreviewTab1(
                  item: item,
                  appState: appState,
                ),
                FiremanPreviewTab2(
                  item: item,
                  appState: appState,
                ),
                FiremanPreviewTab3(
                  item: item,
                  appState: appState,
                ),
                FiremanPreviewTab4(
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
class FiremanPreviewTab1 extends StatefulWidget {
  const FiremanPreviewTab1(
      {super.key, required this.item, required this.appState});

  final Fireman item;
  final AppSession appState;

  @override
  State<FiremanPreviewTab1> createState() => _FiremanPreviewTab1State();
}

class _FiremanPreviewTab1State extends State<FiremanPreviewTab1>
    with AutomaticKeepAliveClientMixin {
  AppSession get appState => widget.appState;
  Fireman get item => widget.item;

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
                right:
                    DictPair.find(appState.firemanRank, item.rank, "-").value),
            TCaptionValue(
                left: 'Rodzaj',
                right: DictPair.find(Fireman.types(), item.type, "-").value),
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
                right: item.isJOT
                    ? Text('Należy do JOT',
                        style: labelMedium(context)?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: successColor(context)))
                    : Text('Nie należy do JOT',
                        style: labelMedium(context)?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: errorColor(context)))),
            if (item.isMDPSupervisor)
              TCaptionValue(
                  left: const SizedBox(),
                  right: Text('Jest opiekunem MDP',
                      style: labelMedium(context)?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: successColor(context)))),
            TCaptionValue(
                left: 'Zarząd OSP',
                right: item.isBoardMember
                    ? Text(
                        DictPair.find(appState.boardOf, item.boardRole).value,
                        style: labelMedium(context)?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: primaryColor(context)))
                    : '-'),
            TCaptionValue(
                left: 'Komisja rewizyjna',
                right: item.isAuditCommittee
                    ? Text(
                        DictPair.find(appState.committee, item.committee).value,
                        style: labelMedium(context)?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: primaryColor(context)))
                    : '-'),
            TCaptionValue(left: 'Nr legitymacji', right: item.idNo),
            TCaptionValue(left: 'Data wstąpienia', right: item.joinDate),
          ]),
        ],
      ),
    );
  }
}

//Tab 2
class FiremanPreviewTab2 extends StatefulWidget {
  const FiremanPreviewTab2(
      {super.key, required this.item, required this.appState});

  final Fireman item;
  final AppSession appState;

  @override
  State<FiremanPreviewTab2> createState() => _FiremanPreviewTab2State();
}

class _FiremanPreviewTab2State extends State<FiremanPreviewTab2>
    with AutomaticKeepAliveClientMixin {
  AppSession get appState => widget.appState;
  Fireman get item => widget.item;

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
                right: "${item.lastName} ${item.firstName} ${item.middleName}"),
            TCaptionValue(left: "PESEL", right: item.peselNo),
            TCaptionValue(left: "Data urodzenia", right: item.birthDate),
            TCaptionValue(left: "Miejsce urodzenia", right: item.placeOfBirth),
            TCaptionValue(
                left: "Wykształcenie",
                right: DictPair.find(appState.education, item.education).value),
            TCaptionValue(left: "Zawód", right: item.profession),
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
                  item.workplace,
                  style: labelMedium(context)
                      ?.copyWith(fontWeight: FontWeight.bold),
                )
              ],
            )),
            TCaptionValue(left: "Imię ojca", right: item.fatherName),
          ]),
        ],
      ),
    );
  }
}

//Tab 3
class FiremanPreviewTab3 extends StatefulWidget {
  const FiremanPreviewTab3(
      {super.key, required this.item, required this.appState});

  final Fireman item;
  final AppSession appState;

  @override
  State<FiremanPreviewTab3> createState() => _FiremanPreviewTab3State();
}

class _FiremanPreviewTab3State extends State<FiremanPreviewTab3>
    with AutomaticKeepAliveClientMixin {
  AppSession get appState => widget.appState;
  Fireman get item => widget.item;

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
                      "${item.zipCode} ${item.postOffice}",
                      style: labelMedium(context)
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${item.city != item.postOffice ? item.city : ''} ${item.street} ${item.buildingNo}",
                      style: labelMedium(context)
                          ?.copyWith(fontWeight: FontWeight.bold),
                    )
                  ],
                )),
            TCaptionValue(left: "E-mail", right: item.email),
            TCaptionValue(left: "Nr telefonu", right: item.phoneNo),
          ]),
        ],
      ),
    );
  }
}

//Tab 4
class FiremanPreviewTab4 extends StatefulWidget {
  const FiremanPreviewTab4(
      {super.key, required this.item, required this.appState});

  final Fireman item;
  final AppSession appState;

  @override
  State<FiremanPreviewTab4> createState() => _FiremanPreviewTab4State();
}

class _FiremanPreviewTab4State extends State<FiremanPreviewTab4>
    with AutomaticKeepAliveClientMixin {
  AppSession get appState => widget.appState;
  Fireman get item => widget.item;

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
            TCaptionValue(left: "Wzrost", right: sizeOrEmpty(item.height)),
            TCaptionValue(
                left: "Nr buta", right: item.shoeNo > 0 ? item.shoeNo : '-'),
            TCaptionValue(left: "Rozmiar dłoni", right: item.handSize),
            TCaptionValue(
                left: "Obwód w klatce piersiowej",
                right: sizeOrEmpty(item.chestCircum)),
            TCaptionValue(
                left: "Obwód w pasie", right: sizeOrEmpty(item.waistCircum)),
            TCaptionValue(
                left: "Obwód głowy", right: sizeOrEmpty(item.headCircum)),
            TCaptionValue(
                left: "Obwód szyi", right: sizeOrEmpty(item.neckCircum)),
          ]),
        ],
      ),
    );
  }

  String sizeOrEmpty(double v) => v > 0 ? "$v cm" : '-';
}
