part of 'index.dart';

class FiremanList extends MatCubitableList2<Fireman, FiremanListCubit> {
  const FiremanList({super.key, super.params});

  @override
  String get title => 'Ewidencja strażaków';

  @override
  FiremanListCubit createCubit() => FiremanListCubit(params!.api1service!);

  @override
  Widget buildFormTypeCreate(
      BuildContext context, Map<String, dynamic>? params) {
    return FiremanFormController(formType: AppFormType.create, params: params);
  }

  @override
  List<FilterTab> get filterTabs => const [
        FilterTab(tab: Tab(text: 'Wszyscy')),
        FilterTab(
            key: 'in_actions', value: true, tab: Tab(text: 'Udział w akcjach')),
        FilterTab(key: 'czy_jot', value: true, tab: Tab(text: 'JOT')),
        FilterTab(key: 'rodzaj', value: 1, tab: Tab(text: 'Zwyczajni')),
        FilterTab(key: 'rodzaj', value: 4, tab: Tab(text: 'MDP')),
        FilterTab(key: 'rodzaj', value: 2, tab: Tab(text: 'Wspierający')),
        FilterTab(key: 'rodzaj', value: 3, tab: Tab(text: 'Honorowi')),
        FilterTab(
            key: 'czy_opiekun_mdp', value: true, tab: Tab(text: 'Opiekun MDP')),
      ];

  @override
  double get appBarHeight => 180;

  @override
  Widget renderItem(item, p) {
    return FiremanListItem(
      item: item,
      p: p,
      key: ValueKey(item.id),
    );
  }
}

//zrobic generic list item 2 i tutaj robic extends; tak samo dla preview
class FiremanListItem extends StatelessWidget {
  const FiremanListItem({super.key, required this.item, required this.p});

  final Fireman item;
  final ListItemParams p;

  @override
  Widget build(BuildContext context) {
    // const imgLight = Image(
    //     width: 64,
    //     height: 64,
    //     fit: BoxFit.cover,
    //     color: Color.fromRGBO(211, 47, 47, 1),
    //     colorBlendMode: BlendMode.colorDodge,
    //     image: AssetImage('assets/images/fireman.jpg'));

    // const imgDark = Image(
    //     width: 64,
    //     height: 64,
    //     fit: BoxFit.cover,
    //     color: Color.fromRGBO(23, 23, 23, 0.3),
    //     colorBlendMode: BlendMode.darken,
    //     image: AssetImage('assets/images/fireman.jpg'));

    // final emptyImg =
    //     Theme.of(context).brightness == Brightness.dark ? imgDark : imgLight;

    return AppListTile<Fireman, FiremanListCubit>(
      previewBuilder: (context) => FiremanPreview(
        item: item,
        appState: p.appState,
      ),
      leading: CircleAvatar(
          radius: 32,
          backgroundColor: Colors.black,
          backgroundImage: item.imgUrl.isEmpty
              ? const AssetImage('assets/images/fireman.jpg') as ImageProvider
              : NetworkImage(item.imgUrl)),
      title: Text(
        '${p.index + 1}. ${item.lastName} ${item.firstName}',
        style: labelMedium(context)?.copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(DictPair.find(p.appState.firemanRank, item.rank).value,
                  style: labelSmall(context)),
              if (item.rank.isNotEmpty) Text(' | ', style: labelSmall(context)),
              Expanded(
                  child: Text(DictPair.find(Fireman.types(), item.type).value,
                      style: labelSmall(context))),
            ],
          ),
          if (item.isBoardMember)
            Text(DictPair.find(p.appState.boardOf, item.boardRole).value,
                style: labelSmall(context)?.copyWith(
                    color: primaryColor(context), fontWeight: FontWeight.bold)),
          if (item.isAuditCommittee)
            Text(DictPair.find(p.appState.committee, item.committee).value,
                style: labelSmall(context)?.copyWith(
                    color: primaryColor(context), fontWeight: FontWeight.bold)),
        ],
      ),
      thirdLine: item.inActions
          ? Text(
              'Bierze udział w akcjach',
              style: labelSmall(context)?.copyWith(
                  color: successColor(context), fontWeight: FontWeight.bold),
            )
          : Text(
              'Nie bierze udziału w akcjach',
              style: labelSmall(context)?.copyWith(color: errorColor(context)),
            ),
    );
  }
}



/*

AppCard(
      key: ValueKey(item.id),
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        horizontalTitleGap: 0,
        minVerticalPadding: 0,
        visualDensity: const VisualDensity(vertical: -4),
        dense: true,
        // leading: CircleAvatar(
        //     radius: 26,
        //     backgroundImage: item.imgUrl.isEmpty
        //         ? const AssetImage('assets/images/fireman.jpg') as ImageProvider
        //         : NetworkImage(item.imgUrl)),
        leading: Image(
            width: 62,
            fit: BoxFit.cover,
            image: item.imgUrl.isEmpty
                ? const AssetImage('assets/images/fireman.jpg') as ImageProvider
                : NetworkImage(item.imgUrl)),
        title: Text(
          '${item.imie} ${item.nazwisko}',
          style: fontBold(),
        ),
        subtitle: RichText(
          text: TextSpan(
            style: labelSmall(context),
            children: [
              TextSpan(
                  text: TDict.find(appState.strazakStopien, item.stopien).text),
              if (item.stopien.isNotEmpty) const TextSpan(text: ' | '),
              TextSpan(
                text: TDict.find(Strazak.rodzaje(), item.rodzaj).text,
              ),
            ],
          ),
        ),
      ),
    );

*/

/*

leading: item.imgUrl.isEmpty
          ? emptyImg
          : Image(
              width: 64,
              height: 64,
              fit: BoxFit.cover,
              color: const Color.fromRGBO(23, 23, 23, 0.3),
              colorBlendMode: BlendMode.darken,
              image: NetworkImage(item.imgUrl)),

*/
