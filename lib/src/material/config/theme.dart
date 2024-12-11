part of 'index.dart';

// const primary = Color.fromARGB(255, 92, 15, 186);
const primary = Colors.deepOrange;
const accent = Colors.deepOrangeAccent;

const primaryDark = Colors.orange;
const accentDark = Colors.orangeAccent;

const backgroundLight = Color.fromARGB(255, 248, 250, 251);
const cardLight = Colors.white;
const textColorOnLight = Color.fromARGB(255, 64, 54, 44);
const borderLight = Colors.black38;

// const backgroundDark = Color.fromARGB(255, 16, 20, 23);
// const cardDark = Color.fromARGB(255, 26, 32, 34);
const backgroundDark = Color.fromARGB(255, 28, 28, 29);
const cardDark = Color.fromARGB(255, 37, 39, 40);
const textColorOnDark = Color.fromARGB(255, 190, 192, 196);
const borderColorDark = Color.fromARGB(255, 160, 160, 160);

const borderRadius = 8.0;
const gap = 12.0;

const errorColorLight = Color.fromARGB(255, 233, 41, 41);
const greenColorLight = Color.fromRGBO(63, 199, 69, 1);

const errorColorDark = Color.fromARGB(255, 158, 20, 11);
const greenColorDark = Color.fromRGBO(45, 105, 48, 1);

ThemeData lightTheme(BuildContext context) => prepareTheme();

ThemeData darkTheme(BuildContext context) => prepareTheme(
    brightness: Brightness.dark,
    primary: primaryDark,
    accent: accentDark,
    error: errorColorDark,
    backgroundColor: backgroundDark,
    cardColor: cardDark,
    textColor: textColorOnDark,
    borderColor: borderColorDark);

ThemeData prepareTheme({
  MaterialColor primary = primary,
  MaterialAccentColor accent = accent,
  Color error = errorColorLight,
  Brightness brightness = Brightness.light,
  Color backgroundColor = backgroundLight,
  Color cardColor = cardLight,
  Color textColor = textColorOnLight,
  Color borderColor = borderLight,
}) =>
    ThemeData(
      useMaterial3: true,

      // colorSchemeSeed: primary,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: primary,
        accentColor: accent,
        errorColor: error,
        brightness: brightness,
        backgroundColor: backgroundColor,
        cardColor: cardColor,
      ),

      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(gap),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor,
            width: 1.0,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(borderRadius)),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor,
            width: 1.0,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(borderRadius)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor,
            width: 3.0,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(borderRadius)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: error,
            width: 3.0,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(borderRadius)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: error,
            width: 2.0,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(borderRadius)),
        ),
      ),

      textTheme: TextTheme(
        displayLarge: TextStyle(
            fontSize: 32, fontWeight: FontWeight.bold, color: textColor),
        displayMedium: TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
        displaySmall: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
        labelLarge: TextStyle(
            fontSize: 18, fontWeight: FontWeight.normal, color: textColor),
        labelMedium: TextStyle(
            fontSize: 16, fontWeight: FontWeight.normal, color: textColor),
        labelSmall: TextStyle(
            fontSize: 14, fontWeight: FontWeight.normal, color: textColor),
      ),

      cardTheme: CardTheme(
        elevation: 2.0,
        surfaceTintColor: cardColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
      ),

      buttonTheme: ButtonThemeData(
        buttonColor: primary,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          minimumSize:
              MaterialStateProperty.all(const Size(double.infinity, 56)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        ),
      ),
    );

TextStyle? displayMedium(BuildContext context) =>
    Theme.of(context).textTheme.displayMedium;
TextStyle? displayLarge(BuildContext context) =>
    Theme.of(context).textTheme.displayLarge;
TextStyle? displaySmall(BuildContext context) =>
    Theme.of(context).textTheme.displaySmall;
TextStyle? labelMedium(BuildContext context) =>
    Theme.of(context).textTheme.labelMedium;
TextStyle? labelLarge(BuildContext context) =>
    Theme.of(context).textTheme.labelLarge;
TextStyle? labelSmall(BuildContext context) =>
    Theme.of(context).textTheme.labelSmall;
TextStyle fontBold() => const TextStyle(fontWeight: FontWeight.bold);

Color errorColor(BuildContext context) =>
    Theme.of(context).brightness == Brightness.light
        ? errorColorLight
        : errorColorDark;

Color successColor(BuildContext context) =>
    Theme.of(context).brightness == Brightness.light
        ? greenColorLight
        : greenColorDark;

Color primaryColor(BuildContext context) =>
    Theme.of(context).brightness == Brightness.light ? primary : primaryDark;
