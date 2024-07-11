import 'package:intl/intl.dart';

class IntlService {
  String getCurrentDateFormatted() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    return formatted;
  }
}
