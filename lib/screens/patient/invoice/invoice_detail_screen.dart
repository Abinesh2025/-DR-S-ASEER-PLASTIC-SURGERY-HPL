import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_app_bar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/invoice_controller/invoice_details_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';

class InvoiceDetailScreen extends StatelessWidget {
  InvoiceDetailScreen({Key? key, required this.status}) : super(key: key);
  final bool status;
  final InvoiceDetailsController invoiceDetailsController =
      Get.put(InvoiceDetailsController());

  @override
  Widget build(BuildContext context) {
    var res = ModalRoute.of(context)!.settings.arguments as int;
    invoiceDetailsController.getInvoiceDetails(res);

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConst.whiteColor,
        appBar: CommonAppBar(
          title: "Invoice Details",
          leadOnTap: () {
            Get.back();
          },
          leadIcon: const Icon(
            Icons.arrow_back_rounded,
            color: ColorConst.blackColor,
          ),
        ),
        body: Obx(
          () => invoiceDetailsController.isApiCall.value == false
              ?  Center(
                  child:
                      CircularProgressIndicator(color: ColorConst.primaryColor))
              : Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        // ─── HERO SECTION ───
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5)),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: height * 0.03),
                              // App Logo
                              Container(
                                height: 75,
                                width: 75,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 10,
                                        offset: const Offset(0, 2)),
                                  ],
                                  border: Border.all(
                                      color: Colors.grey.shade100, width: 2),
                                ),
                                child: ClipOval(
                                  child: invoiceDetailsController
                                                  .invoiceDetailsModel
                                                  ?.data
                                                  ?.app_logo ==
                                              null ||
                                          invoiceDetailsController
                                              .invoiceDetailsModel!
                                              .data!
                                              .app_logo!
                                              .isEmpty
                                      ? Image.asset(ImageUtils.appLogo,
                                          fit: BoxFit.cover)
                                      : FadeInImage(
                                          placeholder: const AssetImage(
                                              ImageUtils.appLogo),
                                          image: NetworkImage(
                                              invoiceDetailsController
                                                  .invoiceDetailsModel!
                                                  .data!
                                                  .app_logo!),
                                          imageErrorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                                ImageUtils.appLogo,
                                                fit: BoxFit.cover);
                                          },
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              SizedBox(height: height * 0.02),
                              // Invoice Name
                              Text(
                                "Invoice ${invoiceDetailsController.invoiceDetailsModel?.data?.invoice_id ?? ""}",
                                style: TextStyleConst.boldTextStyle(
                                    ColorConst.blackColor, width * 0.055),
                              ),
                              SizedBox(height: height * 0.005),
                              Text(
                                "${invoiceDetailsController.invoiceDetailsModel?.data?.invoice_date ?? ""}",
                                style: TextStyleConst.mediumTextStyle(
                                    Colors.grey.shade500, width * 0.038),
                              ),
                              SizedBox(height: height * 0.02),

                              // Status Badge
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: status
                                      ? Colors.green.withOpacity(0.1)
                                      : Colors.orange.withOpacity(0.1),
                                  border: Border.all(
                                      color: status
                                          ? Colors.green.withOpacity(0.3)
                                          : Colors.orange.withOpacity(0.3)),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      status
                                          ? Icons.check_circle_outline
                                          : Icons.access_time_rounded,
                                      color: status
                                          ? Colors.green.shade600
                                          : Colors.orange.shade800,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      status ? "Paid" : "Pending",
                                      style: TextStyleConst.boldTextStyle(
                                        status
                                            ? Colors.green.shade700
                                            : Colors.orange.shade800,
                                        width * 0.038,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: height * 0.03),
                            ],
                          ),
                        ),
                        SizedBox(height: height * 0.025),
                        // ─── RECEIPT BODY (Details & Items) ───
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5)),
                            ],
                            border: Border.all(color: Colors.grey.shade100),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Parties (Billed To / Issued By)
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Billed To",
                                              style: TextStyleConst
                                                  .mediumTextStyle(
                                                      ColorConst.hintGreyColor,
                                                      width * 0.035)),
                                          const SizedBox(height: 8),
                                          Text(
                                            invoiceDetailsController
                                                    .invoiceDetailsModel
                                                    ?.data
                                                    ?.patient_name ??
                                                "N/A",
                                            style: TextStyleConst.boldTextStyle(
                                                ColorConst.blackColor,
                                                width * 0.04),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            "${invoiceDetailsController.invoiceDetailsModel?.data?.address ?? ""}\n${invoiceDetailsController.invoiceDetailsModel?.data?.city ?? ""} ${invoiceDetailsController.invoiceDetailsModel?.data?.zip ?? ""}",
                                            style:
                                                TextStyleConst.mediumTextStyle(
                                                    Colors.grey.shade600,
                                                    width * 0.035),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Issued By",
                                              style: TextStyleConst
                                                  .mediumTextStyle(
                                                      ColorConst.hintGreyColor,
                                                      width * 0.035)),
                                          const SizedBox(height: 8),
                                          Text(
                                            invoiceDetailsController
                                                    .invoiceDetailsModel
                                                    ?.data
                                                    ?.issued_by ??
                                                "N/A",
                                            style: TextStyleConst.boldTextStyle(
                                                ColorConst.blackColor,
                                                width * 0.04),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            invoiceDetailsController
                                                    .invoiceDetailsModel
                                                    ?.data
                                                    ?.hospital_address ??
                                                "",
                                            style:
                                                TextStyleConst.mediumTextStyle(
                                                    Colors.grey.shade600,
                                                    width * 0.035),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Zig-zag Divider equivalent (Dashed line)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  children: List.generate(
                                    150 ~/ 2,
                                    (index) => Expanded(
                                      child: Container(
                                        color: index % 2 == 0
                                            ? Colors.transparent
                                            : Colors.grey.shade300,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // Invoice Items
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      StringUtils.itemDetails,
                                      style: TextStyleConst.boldTextStyle(
                                          ColorConst.blackColor, width * 0.045),
                                    ),
                                    SizedBox(height: height * 0.02),
                                    Column(
                                      children: List.generate(
                                        invoiceDetailsController
                                                .invoiceDetailsModel
                                                ?.data
                                                ?.invoice_items
                                                ?.length ??
                                            0,
                                        (index) => Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 16),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      invoiceDetailsController
                                                              .invoiceDetailsModel
                                                              ?.data
                                                              ?.invoice_items?[
                                                                  index]
                                                              .account_name ??
                                                          "N/A",
                                                      style: TextStyleConst
                                                          .boldTextStyle(
                                                              ColorConst
                                                                  .blackColor,
                                                              width * 0.04),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    if (invoiceDetailsController
                                                            .invoiceDetailsModel
                                                            ?.data
                                                            ?.invoice_items?[
                                                                index]
                                                            .description !=
                                                        null)
                                                      Text(
                                                        invoiceDetailsController
                                                            .invoiceDetailsModel!
                                                            .data!
                                                            .invoice_items![
                                                                index]
                                                            .description!,
                                                        style: TextStyleConst
                                                            .mediumTextStyle(
                                                                Colors.grey
                                                                    .shade500,
                                                                width * 0.035),
                                                      ),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      "${invoiceDetailsController.invoiceDetailsModel?.data?.invoice_items?[index].quantity ?? 1} x ${invoiceDetailsController.invoiceDetailsModel?.data?.currencySymbol ?? ""}${invoiceDetailsController.invoiceDetailsModel?.data?.invoice_items?[index].price ?? 0}",
                                                      style: TextStyleConst
                                                          .mediumTextStyle(
                                                              Colors.grey
                                                                  .shade600,
                                                              width * 0.035),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                "${invoiceDetailsController.invoiceDetailsModel?.data?.currencySymbol ?? ""}${invoiceDetailsController.invoiceDetailsModel?.data?.invoice_items?[index].total ?? "0"}",
                                                style: TextStyleConst
                                                    .boldTextStyle(
                                                        ColorConst.blackColor,
                                                        width * 0.045),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Totals Output
                              Container(
                                decoration: BoxDecoration(
                                  color: ColorConst.bgGreyColor,
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                ),
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(StringUtils.subTotal,
                                            style:
                                                TextStyleConst.mediumTextStyle(
                                                    Colors.grey.shade700,
                                                    width * 0.04)),
                                        Text(
                                          "${invoiceDetailsController.invoiceDetailsModel?.data?.currencySymbol ?? ""}${invoiceDetailsController.invoiceDetailsModel?.data?.sub_total ?? "0"}",
                                          style: TextStyleConst.boldTextStyle(
                                              ColorConst.blackColor,
                                              width * 0.04),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(StringUtils.discount,
                                            style:
                                                TextStyleConst.mediumTextStyle(
                                                    ColorConst.orangeColor,
                                                    width * 0.04)),
                                        Text(
                                          "- ${invoiceDetailsController.invoiceDetailsModel?.data?.currencySymbol ?? ""}${invoiceDetailsController.invoiceDetailsModel?.data?.discount ?? "0"}",
                                          style: TextStyleConst.boldTextStyle(
                                              ColorConst.orangeColor,
                                              width * 0.04),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: Divider(
                                          color: Colors.grey.shade300,
                                          thickness: 1),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(StringUtils.totalAmount,
                                            style: TextStyleConst.boldTextStyle(
                                                ColorConst.blackColor,
                                                width * 0.048)),
                                        Text(
                                          "${invoiceDetailsController.invoiceDetailsModel?.data?.currencySymbol ?? ""}${invoiceDetailsController.invoiceDetailsModel?.data?.total_amount ?? "0"}",
                                          style: TextStyleConst.boldTextStyle(
                                              ColorConst.primaryColor,
                                              width * 0.055),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: height * 0.04),
                        // Download Button Redesign
                        Center(
                          child: Obx(
                            () =>
                                invoiceDetailsController.isDownloading.value ==
                                        true
                                    ?  Center(
                                        child: CircularProgressIndicator(
                                            color: ColorConst.primaryColor))
                                    : SizedBox(
                                        width: width * 0.8,
                                        height: 55,
                                        child: ElevatedButton.icon(
                                          onPressed: () {
                                            invoiceDetailsController.downloadPDF(
                                                invoiceDetailsController
                                                        .invoiceDetailsModel
                                                        ?.data
                                                        ?.invoice_download ??
                                                    "");
                                          },
                                          icon: const Icon(
                                              Icons.file_download_outlined,
                                              color: Colors.white),
                                          label: Text(
                                            StringUtils.downInvoice,
                                            style: TextStyleConst.boldTextStyle(
                                                Colors.white, width * 0.045),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                ColorConst.primaryColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            elevation: 5,
                                            shadowColor: ColorConst.primaryColor
                                                .withOpacity(0.4),
                                          ),
                                        ),
                                      ),
                          ),
                        ),
                        SizedBox(height: height * 0.04),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
