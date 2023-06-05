// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

enum ErrorState {
  invalidConnId,
  connectionFailure,
}

extension ErrorStateDisplay on ErrorState {
  String get message {
    switch (this) {
      case ErrorState.invalidConnId:
        return 'A megadott kapcsolati azonosító nem érvényes!';
      case ErrorState.connectionFailure:
        return 'Nem sikerült kapcsolódni a szerverhez!';
      default:
        return toString();
    }
  }
}
