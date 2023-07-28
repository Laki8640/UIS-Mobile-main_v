import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:universal_identification_system/constant/common_circularIndicator.dart';
import 'package:universal_identification_system/controller/selector_controller.dart';
import 'package:universal_identification_system/views/Api/api_response.dart';
import 'package:universal_identification_system/views/Api/model/response_model/get_all_form_response_model.dart';
import 'package:universal_identification_system/views/Api/view_model/get_all_from_view_model.dart';
import 'package:universal_identification_system/views/edit_form.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  SelectorController selectorController = Get.put(SelectorController());
  GetAllFormViewModel getAllFormViewModel = Get.put(GetAllFormViewModel());

  @override
  void initState() {
    super.initState();
    getAllFormMethod();
  }

  void getAllFormMethod() {
    getAllFormViewModel.getAllFormViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectorController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            elevation: 0,
            leading: GestureDetector(
              child:
                  Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.sp),
              onTap: () {
                selectorController.selected(0);
              },
            ),
            title: Text(
              'History',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.grey.shade100,
          ),
          body: GetBuilder<GetAllFormViewModel>(
            builder: (formController) {
              if (formController.apiResponse.status == Status.COMPLETE) {
                GetAllFormResponseModel responseModel =
                    formController.apiResponse.data;

                return Column(
                  children: [
                    SizedBox(height: 20.h),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                        ),
                        physics: const BouncingScrollPhysics(),
                        itemCount: responseModel.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          FormModel item = responseModel.data[index];

                          final DateFormat formatter = DateFormat('dd-MM-yyyy');
                          final String formattedDateOfDeath =
                              formatter.format(item.dateOfDeath);
                          return Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 4.h,
                            ),
                            child: Slidable(
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) async {
                                      var result = await Navigator.push(context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) {
                                        return EditFormScreen(
                                          item: item,
                                        );
                                      }));
                                      print('View Details ');

                                      if (result != null && result == true) {
                                        getAllFormMethod();
                                      }
                                    },
                                    backgroundColor: Colors.blue.shade900,
                                    foregroundColor: Colors.white,
                                    icon: Icons.edit,
                                    label: 'Edit',
                                  ),
                                  SlidableAction(
                                      onPressed: (context) async {
                                        await formController
                                            .deleteFormViewModel(
                                                formId: item.id.toString());

                                        if (formController
                                                .apiResponseDeleteForm.status ==
                                            Status.COMPLETE) {
                                          getAllFormMethod();
                                        } else if (formController
                                                .apiResponseDeleteForm.status ==
                                            Status.LOADING) {
                                        } else {}
                                      },
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                      borderRadius: BorderRadius.horizontal(
                                          right: Radius.circular(6.r))),
                                ],
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        //color of shadow
                                        spreadRadius: 7,
                                        //spread radius
                                        blurRadius: 7,
                                        // blur radius
                                        offset: const Offset(
                                            0, 2), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(6.r)),
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.w, vertical: 10.h),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.deceasedName ?? '',
                                            style: TextStyle(
                                                color: const Color(0xff313131),
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          SizedBox(height: 9.h),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Date of Death: ',
                                                style: TextStyle(
                                                    color:
                                                        const Color(0xff848484),
                                                    fontSize: 12.sp,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              Text(
                                                formattedDateOfDeath,
                                                style: TextStyle(
                                                    color:
                                                        const Color(0xff353535),
                                                    fontSize: 12.sp,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      // const Spacer(),
                                      // Container(
                                      //   decoration: BoxDecoration(
                                      //       color: PickColor.secondaryColor,
                                      //       borderRadius:
                                      //           BorderRadius.circular(6.r)),
                                      //   child: Material(
                                      //     color: Colors.transparent,
                                      //     child: InkWell(
                                      //       onTap: () {
                                      //         Navigator.push(context,
                                      //             MaterialPageRoute(builder:
                                      //                 (BuildContext context) {
                                      //           return FormScreen();
                                      //         }));
                                      //         print('View Details');
                                      //       },
                                      //       child: Container(
                                      //         height: 30.h,
                                      //         width: 98.w,
                                      //         decoration: BoxDecoration(
                                      //           borderRadius:
                                      //               BorderRadius.circular(6.r),
                                      //           // color: PickColor.secondaryColor,
                                      //         ),
                                      //         alignment: Alignment.center,
                                      //         child: Text(
                                      //           'View Details',
                                      //           style: TextStyle(
                                      //               fontSize: 14.sp,
                                      //               color: Colors.white,
                                      //               fontWeight: FontWeight.w400),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else if (formController.apiResponse.status == Status.LOADING) {
                return Container(
                    width: Get.width,
                    height: Get.height,
                    color: Colors.black.withOpacity(0.2),
                    child: CommonCircular.showCircularIndicator());
              } else {
                return const Text('Something went wrong');
              }
            },
          ),
        );
      },
    );
  }
}
