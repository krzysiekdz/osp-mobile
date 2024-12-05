part of '../index.dart';

typedef OnSearchText = void Function(String text);

class SearchField extends StatefulWidget {
  const SearchField({super.key, this.text = '', required this.onSearchText});
  final String text;
  final OnSearchText onSearchText;

  @override
  State<StatefulWidget> createState() => SearchFieldState();
}

class SearchFieldState extends State<SearchField> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.text);
    controller.addListener(() {
      widget.onSearchText(controller.text);
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        hintText: 'Wpisz coś, aby wyszukać...',
        prefixIcon: const Icon(Icons.search),
        prefix: const Padding(
          padding: EdgeInsets.only(right: 8),
          child: Text('Szukasz:'),
        ),
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  controller.clear();
                },
              )
            : null,
      ),
    );
  }
}
