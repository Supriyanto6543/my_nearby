import 'dart:ui';

const String bgColorBlack = "#02020d";
const String bgColorApp = "#1c2834";
const String grey1Color = "#5e5c5d";

Color getColorFromHex(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll('#', '');

  if (hexColor.length == 6) {
    hexColor = 'FF$hexColor';
  }

  return Color(int.parse(hexColor, radix: 16));
}
