// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------


/// Kicseréli a szövegben az ékezetes betűket ékezet nélküli változatra.
///
class DiacriticRemover {
  String removeDiacritics(String text) {
    final resultCodeUnits = text.codeUnits.map((codeUnit) => codeUnit > 0x007f
        ? (DiacriticMap().replacementMap[codeUnit] ?? codeUnit)
        : codeUnit);
    return String.fromCharCodes(resultCodeUnits);
  }
}

///
/// Definiálja, hogy melyik ékezetes betűt milyen ékezet nélkülire kell
/// cserélni.
///
/// Singleton.
///
/// A map innen van:
///
/// https://docs.oracle.com/cd/E29584_01/webhelp/mdex_basicDev/src/rbdv_chars_mapping.html
///
class DiacriticMap {
  ///
  /// A definíció formátuma: az értékben vannak felsorolva azok az ékezetes
  /// karakterek, amit a kulcsnak megadott ékezet nélküli karakterre kell
  /// fordítani.
  /// A formátum ember számára könnyen olvasható és módosítható.
  ///
  static const _diacriticReplacementDefinition = {
    'A': 'ÀÁÂÃÄÅÆĀĂĄ',
    'a': 'àáâãäåæāăą',
    'E': 'ÈÉÊËĒĔĖĘĚ',
    'e': 'èéêëēĕėęě',
    'I': 'ÌÍÎÏĨĪĬĮİĲ',
    'i': 'ìíîïĩīĭįıĳ',
    'O': 'ÒÓÔÕÖØŌŎŐŒ',
    'o': 'òóôõöøōŏőœ',
    'U': 'ÙÚÛÜŨŪŬŮŰŲ',
    'u': 'ùúûüũūŭůűų',
  };

  /// Singleton
  static final _instance = DiacriticMap._();

  /// A konvertálás során használt map
  final Map<int, int> _replacementMap = {};

  ///
  /// A definíciót átalakítjuk a programnak jobb formátumra, ahol a kulcsok az
  /// ékezetes betűk, az értékek pedig az ékezet nélküliek.
  /// Mivel ez egy singleton, ezért ezt csak 1x csináljuk meg a program futása
  /// során.
  ///
  DiacriticMap._() {
    _diacriticReplacementDefinition.forEach((key, value) {
      final keyCodeUnit = key.codeUnits.first;
      for (var codeUnit in value.codeUnits) {
        _replacementMap[codeUnit] = keyCodeUnit;
      }
    });
  }

  factory DiacriticMap() {
    return _instance;
  }

  Map<int, int> get replacementMap => _replacementMap;
}
