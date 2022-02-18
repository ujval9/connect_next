import 'package:cloud_firestore/cloud_firestore.dart';
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
  var format = DateFormat('d-MM-y'); // <- use skeleton here
  return format.format(DateTime.parse(dateTime));
}
