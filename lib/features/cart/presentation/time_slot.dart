import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plix/constants/app_color.dart';
import 'package:plix/helpers/ui_helpers.dart';
import 'package:plix/networks/api_acess.dart';
import 'package:plix/widgets/loading_indicators.dart';
import 'package:provider/provider.dart';

import '../../../helpers/toast.dart';
import '../../../provider/order_date_time.dart';
import '../model/dateslot.dart';
import 'widget/slot_widget.dart';

class CartBottomSheet extends StatefulWidget {
  const CartBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  _CartBottomSheetState createState() => _CartBottomSheetState();
}

class _CartBottomSheetState extends State<CartBottomSheet> {
  String selectedDate = "";
  DateSlot? selectedSlot;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: getTimeSlotRXObj.getTimeSlotDataRes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ShopTimeSlotResponse res =
                ShopTimeSlotResponse.fromJson(snapshot.data);

            return Container(
              height: MediaQuery.of(context).size.height * 0.6,
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Agendar entrega".tr,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  new Divider(
                    color: Colors.grey,
                  ),
                  UIHelper.verticalSpaceSmall,
                  Expanded(
                    child: ListView.builder(
                      itemCount: res.data!.dates.length,
                      itemBuilder: (ctx, idx) {
                        Map<String, List<DateSlot>> dates = res.data!.dates;
                        var slotList = dates.values.elementAt(idx);
                        return slotList.isEmpty
                            ? Container()
                            : Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Radio<String>(
                                      value: dates.keys.elementAt(idx),
                                      groupValue: selectedDate,
                                      onChanged: (String? value) {
                                        if (value != null)
                                          setState(() {
                                            selectedDate = value;
                                            if (slotList.isNotEmpty)
                                              selectedSlot = slotList[0];
                                          });
                                      },
                                    ),
                                    Expanded(
                                      child: DateTimeSlotWidget(
                                        key: Key(dates.keys.elementAt(idx)),
                                        isEnabled: dates.keys.elementAt(idx) ==
                                            selectedDate,
                                        date: dates.keys.elementAt(idx),
                                        dateSlot: slotList,
                                        callBack:
                                            (String date, DateSlot slotValue) {
                                          if (date == selectedDate) {
                                            selectedSlot = slotValue;
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                      },
                    ),
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    onPressed: selectedDate.isEmpty
                        ? null
                        : () {
                            if (selectedSlot != null) {
                              // controller.selectedDate.value = selectedDate;
                              // controller.selectedSlot.value = selectedSlot;
                              log("selected date :  ${selectedDate}");
                              log("selected slot :  ${selectedSlot!.slotValue.toString()}");
                              context
                                  .read<DateTimeProvider>()
                                  .changTimeSlot(selectedDate, selectedSlot!);
                              // print(
                              //     "selected date :  ${controller.selectedDate.value}");
                              // print(
                              //     "selected slot :  ${controller.selectedSlot.value}");
                              Get.back();
                            } else {
                              ToastUtil.showShortToast(
                                  "Please select a time slot".tr);
                            }
                          },
                    color: AppColors.appColor4D3E39,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          "Agendar".tr,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    textColor: Colors.white,
                  )
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return SizedBox.shrink();
          }
          return loadingIndicatorCircle(context: context);
        });
  }
}
