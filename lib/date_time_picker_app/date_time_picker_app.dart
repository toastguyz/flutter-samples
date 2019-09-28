import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePickerApp extends StatefulWidget {
  @override
  _DateTimePickerAppState createState() => _DateTimePickerAppState();
}

class _DateTimePickerAppState extends State<DateTimePickerApp> {
  String timeValue = "Select Time";
  TimeOfDay selectedTime = TimeOfDay.now();
  String dateValue = "Select Date";
  DateTime selectedDate = DateTime.now();

  openDatePicker(initialDateString) async {
    var initialDate = convertToDate(initialDateString) ?? selectedDate;
    initialDate =
        (initialDate.year >= 1900 && initialDate.isBefore(selectedDate)
            ? initialDate
            : selectedDate);

    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2018, 1),
      lastDate: DateTime(3000),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        dateValue = new DateFormat.yMd().format(pickedDate);
      });
    }
  }

  DateTime convertToDate(String input) {
    try {
      var d = new DateFormat.yMd().parseStrict(input);
      return d;
    } catch (e) {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();

    dateValue = new DateFormat.yMd().format(selectedDate);
  }

  openTimePicker() async {
    final TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
        timeValue = getHourMinuteString(pickedTime);
      });
    }
  }

  String getHourMinuteString(timeObject) {
    String periodAmPm, periodHour;
    if (timeObject.period.toString() == "DayPeriod.am") {
      periodAmPm = "AM";
      periodHour = timeObject.hour.toString();
    } else {
      periodAmPm = "PM";
      periodHour = (timeObject.hour - 12).toString();
    }
    return periodHour.padLeft(2, '0') +
        ':' +
        timeObject.minute.toString().padLeft(2, '0') +
        ' ' +
        periodAmPm;
  }

  @override
  Widget build(BuildContext context) {
    final dateformat = DateFormat("yyyy-MM-dd");
    final timeFormat = DateFormat("hh:mm a");

    return Scaffold(
      appBar: AppBar(
        title: Text("Date Picker"),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.grey[300],
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(10.0),
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    openDatePicker(dateValue);
                  },
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 9,
                        child: Text(dateValue),
                      ),
                      Expanded(
                        flex: 1,
                        child: Icon(Icons.calendar_today),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.grey[300],
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(10.0),
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    openTimePicker();
                  },
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 9,
                        child: Text(timeValue),
                      ),
                      Expanded(
                        flex: 1,
                        child: Icon(Icons.watch_later),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
