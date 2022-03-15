import 'package:intl/intl.dart';

getStatus(String value) {
  if (value == '0') {
    return 'Started';
  } else if (value == '1') {
    return 'In transit';
  } else if (value == '2') {
    return 'Completed';
  } else {
    return 'Unknown';
  }
}

getDateFromTimestamp(dateTime) {
  var format = DateFormat('dd/MM/yyyy, hh:mm a'); // <- use skeleton here
  return format.format(DateTime.parse(dateTime));
}
