import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:plix/constants/app_color.dart';

import '../../model/dateslot.dart';

class DateTimeSlotWidget extends StatefulWidget {
  final String date;
  final bool isEnabled;
  final List<DateSlot> dateSlot;
  final Function(String date, DateSlot slot) callBack;

  const DateTimeSlotWidget({
    Key? key,
    required this.date,
    required this.dateSlot,
    required this.callBack,
    required this.isEnabled,
  }) : super(key: key);

  @override
  _DateTimeSlotWidgetState createState() =>
      _DateTimeSlotWidgetState(date, dateSlot, callBack);
}

class _DateTimeSlotWidgetState extends State<DateTimeSlotWidget> {
  String date;
  List<DateSlot> dateSlot;
  late DateSlot selectedSlot;
  Function(String date, DateSlot slot) callBack;

  _DateTimeSlotWidgetState(this.date, this.dateSlot, this.callBack);

  @override
  void initState() {
    if (dateSlot.isNotEmpty) {
      selectedSlot = dateSlot[0];
      List<DateSlot> tempSlot = [];
      for (var slot in dateSlot) {
        if (slot.status) tempSlot.add(slot);
      }
      dateSlot = tempSlot;
    }
    super.initState();
  }

  String getDateTimeNow(String date) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    if (formattedDate == date) {
      return "Today";
    }
    return date;
  }

  @override
  Widget build(BuildContext context) {
    callBack(date, selectedSlot);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            getDateTimeNow(date),
            style: TextStyle(
                color: AppColors.appColor2C303E,
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
          DropdownButton<DateSlot>(
            elevation: 2,
            value: selectedSlot,
            items: dateSlot.map((DateSlot slotObj) {
              return DropdownMenuItem<DateSlot>(
                value: slotObj,
                child: Text(
                  slotObj.slotDisplay,
                  style: GoogleFonts.poppins(color: AppColors.appColor000000),
                ),
              );
            }).toList(),
            onChanged: widget.isEnabled
                ? (slot) {
                    setState(() {
                      selectedSlot = slot!;
                    });
                    callBack(date, slot!);
                  }
                : null,
          )
        ],
      ),
    );
  }
}
