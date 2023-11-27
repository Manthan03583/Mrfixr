import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:demandium/components/ripple_button.dart';
import 'package:demandium/components/service_center_dialog.dart';
import 'package:demandium/core/core_export.dart';

class ServiceWidgetVertical extends StatelessWidget {
  final Service service;
  final bool isAvailable;
  final String fromType;
  final String fromPage;

  const ServiceWidgetVertical(
      {Key? key,
      required this.service,
      required this.isAvailable,
      required this.fromType,
      this.fromPage = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    num lowestPrice = 0.0;

    if (fromType == 'fromCampaign') {
      if (service.variations != null) {
        lowestPrice = service.variations![0].price!;
        print('PRICE1: $lowestPrice');
        for (var i = 0; i < service.variations!.length; i++) {
          if (service.variations![i].price! < lowestPrice) {
            lowestPrice = service.variations![i].price!;
            print('PRICE2: $lowestPrice');
          }
        }
      }
    } else {
      if (service.variationsAppFormat != null) {
        if (service.variationsAppFormat!.zoneWiseVariations != null) {
          lowestPrice =
              service.variationsAppFormat!.zoneWiseVariations![0].price!;
          debugPrint('LOWEST PRICE 1---- =${lowestPrice.toString()}');
          for (var i = 0;
              i < service.variationsAppFormat!.zoneWiseVariations!.length;
              i++) {
            if (service.variationsAppFormat!.zoneWiseVariations![i].price! <
                lowestPrice) {
              lowestPrice =
                  service.variationsAppFormat!.zoneWiseVariations![i].price!;
              debugPrint('LOWEST PRICE---- =${lowestPrice.toString()}');
            }
          }
        }
      }
    }

    Discount discountModel = PriceConverter.discountCalculation(service);
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                // color: Theme.of(context).cardColor,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                boxShadow: Get.isDarkMode ? null : cardShadow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //cover image and service name
                  Column(
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(Dimensions.radiusSmall)),
                            child: CustomImage(
                              image:
                                  '${Get.find<SplashController>().configModel.content!.imageBaseUrl!}/service/${service.thumbnail}',
                              fit: BoxFit.cover,
                              width: double.maxFinite,
                              height: Dimensions.homeImageSize,
                            ),
                          ),
                          discountModel.discountAmount! > 0
                              ? Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    padding: const EdgeInsets.all(
                                        Dimensions.paddingSizeExtraSmall),
                                    decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(
                                            Dimensions.radiusDefault),
                                        topRight: Radius.circular(
                                            Dimensions.radiusSmall),
                                      ),
                                    ),
                                    child: Text(
                                      PriceConverter.percentageOrAmount(
                                          '${discountModel.discountAmount}',
                                          '${discountModel.discountAmountType}'),
                                      style: ubuntuRegular.copyWith(
                                          overflow: TextOverflow.ellipsis,
                                          color: Theme.of(context)
                                              .primaryColorLight),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                      const SizedBox(
                        height: Dimensions.paddingSizeEight,
                      ),
                    ],
                  ),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Padding(
                          padding: EdgeInsets.only(
                            left: constraints.maxWidth * 0.05,
                            right: constraints.maxWidth * 0.05,
                            bottom: constraints.maxHeight * 0.05,
                          ),
                          child: Container(
                            height: constraints.maxHeight,
                            width: constraints.maxWidth,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: constraints.maxWidth * 0.05,
                                    right: constraints.maxWidth * 0.01,
                                    top: constraints.maxWidth * 0.05,
                                  ),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        //-----------Category Description----------
                                        Text(
                                          service.name!,
                                          style: ubuntuMedium.copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  Dimensions.fontSizeDefault),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        //----------------------------------------
                                        SizedBox(
                                          width: constraints.maxWidth,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,    
                                            children: [
                                              Text(
                                                "${"starts_from".tr} ",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: ubuntuRegular.copyWith(
                                                  
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: Dimensions
                                                        .fontSizeExtraSmall,
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .color!
                                                        .withOpacity(.6)),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    if (discountModel
                                                            .discountAmount! >
                                                        0)
                                                      Directionality(
                                                        textDirection:
                                                            TextDirection.ltr,
                                                        child: Text(
                                                          
                                                          PriceConverter
                                                              .convertPrice(
                                                                  lowestPrice
                                                                      .toDouble()),
                                                          maxLines: 1,
                                                          style: ubuntuRegular.copyWith(
                                                            
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              fontSize: Dimensions
                                                        .fontSizeExtraSmall,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .error
                                                                  .withOpacity(
                                                                      .8)),
                                                        ),
                                                      ),
                                                    discountModel
                                                                .discountAmount! >
                                                            0
                                                        ? Directionality(
                                                            textDirection:
                                                                TextDirection.ltr,
                                                            //
                                                            child: Text(
                                                              PriceConverter.convertPrice(
                                                                  lowestPrice
                                                                      .toDouble(),
                                                                  discount: discountModel
                                                                      .discountAmount!
                                                                      .toDouble(),
                                                                  discountType:
                                                                      discountModel
                                                                          .discountAmountType),
                                                              style: ubuntuMedium.copyWith(
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  fontSize: Dimensions
                                                        .fontSizeExtraSmall,
                                                                  color: Get
                                                                          .isDarkMode
                                                                      ? Theme.of(
                                                                              context)
                                                                          .primaryColorLight
                                                                      : Theme.of(
                                                                              context)
                                                                          .primaryColor),
                                                            ),
                                                          )
                                                        : Directionality(
                                                            textDirection:
                                                                TextDirection.ltr,
                                                            child: Text(
                                                              PriceConverter
                                                                  .convertPrice(
                                                                      lowestPrice
                                                                          .toDouble()),
                                                              style: ubuntuMedium.copyWith(
                                                                  overflow:
                                                                      TextOverflow
                                                                          .fade,
                                                                  fontSize:
                                                                      Dimensions
                                                                          .fontSizeLarge,
                                                                  color: Get
                                                                          .isDarkMode
                                                                      ? Theme.of(
                                                                              context)
                                                                          .primaryColorLight
                                                                      : Theme.of(
                                                                              context)
                                                                          .colorScheme
                                                                          .primary),
                                                            ),
                                                          ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: ResponsiveHelper.isDesktop(
                                                  context)
                                              ? 7
                                              : 0,
                                        )
                                      ]),
                                ),

                                //------------add to cart button----------------------
                                if (fromType != 'fromCampaign')
                                  Align(
                                    alignment:
                                        Get.find<LocalizationController>().isLtr
                                            ? Alignment.bottomRight
                                            : Alignment.bottomLeft,
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 6,
                                            right:
                                                Dimensions.paddingSizeDefault,
                                          ),
                                          child: Icon(Icons.add,
                                              // color: Get.isDarkMode
                                              //     ? Theme.of(context).primaryColorLight
                                              //     : Theme.of(context).primaryColor,
                                              color: Get.isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                              size:
                                                  Dimensions.paddingSizeLarge),
                                        ),
                                        Positioned.fill(
                                            child: RippleButton(onTap: () {
                                          if (fromType != "provider_details") {
                                            Get.find<CartController>()
                                                .resetPreselectedProviderInfo();
                                          }
                                          showModalBottomSheet(
                                              useRootNavigator: true,
                                              isScrollControlled: true,
                                              backgroundColor:
                                                  Colors.transparent,
                                              context: context,
                                              builder: (context) =>
                                                  ServiceCenterDialog(
                                                      service: service));
                                        }))
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  //-----------Using LayoutBuilder--------------
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       top: 1, bottom: 18, left: 10, right: 10),
                  //   child: Container(
                  //     height: MediaQuery.of(context).size.height * 0.11,
                  //     width: MediaQuery.of(context).size.width * 0.40,
                  //     color: Colors.amber,
                  //   ),
                  // )
                  //------------------------------------------------
                ],
              ),
            ),
            Positioned.fill(
              child: RippleButton(onTap: () {
                if (fromPage == "search_page") {
                  Get.toNamed(
                    RouteHelper.getServiceRoute(service.id!,
                        fromPage: "search_page"),
                  );
                } else {
                  Get.toNamed(
                    RouteHelper.getServiceRoute(service.id!),
                  );
                }
              }),
            ),
          ],
        ),
        // //------------add to cart button----------------------
        // if (fromType != 'fromCampaign')
        //   Align(
        //     alignment: Get.find<LocalizationController>().isLtr
        //         ? Alignment.bottomRight
        //         : Alignment.bottomLeft,
        //     child: Stack(
        //       children: [
        //         Padding(
        //           padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        //           child: Icon(Icons.add,
        //               // color: Get.isDarkMode
        //               //     ? Theme.of(context).primaryColorLight
        //               //     : Theme.of(context).primaryColor,
        //               color: Get.isDarkMode ? Colors.white : Colors.black,
        //               size: Dimensions.paddingSizeLarge),
        //         ),
        //         Positioned.fill(child: RippleButton(onTap: () {
        //           if (fromType != "provider_details") {
        //             Get.find<CartController>().resetPreselectedProviderInfo();
        //           }
        //           showModalBottomSheet(
        //               useRootNavigator: true,
        //               isScrollControlled: true,
        //               backgroundColor: Colors.transparent,
        //               context: context,
        //               builder: (context) =>
        //                   ServiceCenterDialog(service: service));
        //         }))
        //       ],
        //     ),
        //   ),
      ],
    );
  }
}
