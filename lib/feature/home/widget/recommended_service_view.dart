import 'package:get/get.dart';
import 'package:demandium/feature/home/web/web_recommended_service_view.dart';
import 'package:demandium/core/core_export.dart';

class RecommendedServiceView extends StatelessWidget {
  const RecommendedServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return GetBuilder<ServiceController>(
      builder: (serviceController) {
        if (serviceController.recommendedServiceList != null &&
            serviceController.recommendedServiceList!.isEmpty) {
          return const SizedBox();
        } else {
          if (serviceController.recommendedServiceList != null) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    Dimensions.paddingSizeDefault,
                    15,
                    Dimensions.paddingSizeDefault,
                    Dimensions.paddingSizeSmall,
                  ),
                  child: TitleWidget(
                    title: 'recommended_for_you'.tr,
                    onTap: () => Get.toNamed(RouteHelper.allServiceScreenRoute(
                        "fromRecommendedScreen")),
                  ),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.30,
                    child: ListView.builder(
                      controller: scrollController,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeSmall),
                      itemCount:
                          serviceController.recommendedServiceList!.length > 10
                              ? 10
                              : serviceController
                                  .recommendedServiceList!.length,
                      itemBuilder: (context, index) {
                        Discount discountValue =
                            PriceConverter.discountCalculation(serviceController
                                .recommendedServiceList![index]);
                        return InkWell(
                          onTap: () {
                            Get.toNamed(
                              RouteHelper.getServiceRoute(serviceController
                                  .recommendedServiceList![index].id!),
                              arguments: ServiceDetailsScreen(
                                  serviceID: serviceController
                                      .recommendedServiceList![index].id!),
                            );
                          },
                          child: SizedBox(
                            height: ResponsiveHelper.isDesktop(context)
                                ? 300
                                : MediaQuery.of(context).size.height * 0.30,
                            width: MediaQuery.of(context).size.width * 1.40,
                            child: ServiceModelViewPhone(
                              serviceList:
                                  serviceController.recommendedServiceList!,
                              discountAmountType:
                                  discountValue.discountAmountType,
                              discountAmount: discountValue.discountAmount,
                              index: index,
                            ),
                          ),
                        );
                      },
                    )),
                const SizedBox(
                  height: Dimensions.paddingSizeDefault,
                )
              ],
            );
          } else {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeSmall),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                          color:
                              Get.isDarkMode ? Colors.grey[700] : Colors.white,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radiusSmall),
                          boxShadow: Get.isDarkMode
                              ? null
                              : [
                                  BoxShadow(
                                      color: Colors.grey[300]!,
                                      blurRadius: 10,
                                      spreadRadius: 1)
                                ],
                        ),
                        child: Center(
                          child: Container(
                            height: ResponsiveHelper.isMobile(context)
                                ? 10
                                : ResponsiveHelper.isTab(context)
                                    ? 15
                                    : 20,
                            color: Colors.grey[
                                Get.find<ThemeController>().darkTheme
                                    ? 600
                                    : 300],
                            margin: const EdgeInsets.symmetric(
                                horizontal: Dimensions.paddingSizeSmall),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 80,
                        decoration: BoxDecoration(
                          color:
                              Get.isDarkMode ? Colors.grey[700] : Colors.white,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radiusSmall),
                          boxShadow: Get.isDarkMode
                              ? null
                              : [
                                  BoxShadow(
                                      color: Colors.grey[300]!,
                                      blurRadius: 10,
                                      spreadRadius: 1)
                                ],
                        ),
                        child: Center(
                          child: Container(
                            height: ResponsiveHelper.isMobile(context)
                                ? 10
                                : ResponsiveHelper.isTab(context)
                                    ? 15
                                    : 20,
                            color: Colors.grey[
                                Get.find<ThemeController>().darkTheme
                                    ? 600
                                    : 300],
                            margin: const EdgeInsets.symmetric(
                                horizontal: Dimensions.paddingSizeSmall),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: Dimensions.paddingSizeSmall,
                ),
                const SizedBox(
                    height: 115,
                    child: RecommendedServiceShimmer(enabled: true)),
                const SizedBox(
                  height: Dimensions.paddingSizeSmall,
                ),
              ],
            );
          }
        }
      },
    );
  }
}

class RecommendedServiceShimmer extends StatelessWidget {
  final bool enabled;
  const RecommendedServiceShimmer({super.key, required this.enabled});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(
        right: Dimensions.paddingSizeSmall,
        left: Dimensions.paddingSizeSmall,
        top: Dimensions.paddingSizeSmall,
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          width: MediaQuery.of(context).size.width / 1.20,
          margin: const EdgeInsets.only(
              right: Dimensions.paddingSizeSmall, bottom: 5),
          padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
          decoration: BoxDecoration(
            color: Get.isDarkMode ? Colors.grey[700] : Colors.white,
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            boxShadow: Get.isDarkMode
                ? null
                : [
                    BoxShadow(
                        color: Colors.grey[300]!,
                        blurRadius: 10,
                        spreadRadius: 1)
                  ],
          ),
          child: Shimmer(
            duration: const Duration(seconds: 1),
            interval: const Duration(seconds: 1),
            enabled: enabled,
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                    color: Colors.grey[
                        Get.find<ThemeController>().darkTheme ? 600 : 300]),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 15,
                            width: 100,
                            color: Colors.grey[
                                Get.find<ThemeController>().darkTheme
                                    ? 600
                                    : 300]),
                        const SizedBox(height: 5),
                        Container(
                            height: 10,
                            width: 130,
                            color: Colors.grey[
                                Get.find<ThemeController>().darkTheme
                                    ? 700
                                    : 300]),
                        const SizedBox(height: 5),
                        const RatingBar(rating: 0.0, size: 12, ratingCount: 0),
                      ]),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}

class ServiceModelViewPhone extends StatelessWidget {
  final List<Service> serviceList;
  final int index;
  final num? discountAmount;
  final String? discountAmountType;

  const ServiceModelViewPhone({
    Key? key,
    required this.serviceList,
    required this.index,
    required this.discountAmount,
    required this.discountAmountType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double lowestPrice = 0.0;
    if (serviceList[index].variationsAppFormat!.zoneWiseVariations != null) {
      lowestPrice = serviceList[index]
          .variationsAppFormat!
          .zoneWiseVariations![0]
          .price!
          .toDouble();
      for (var i = 0;
          i <
              serviceList[index]
                  .variationsAppFormat!
                  .zoneWiseVariations!
                  .length;
          i++) {
        if (serviceList[index]
                .variationsAppFormat!
                .zoneWiseVariations![i]
                .price! <
            lowestPrice) {
          lowestPrice = serviceList[index]
              .variationsAppFormat!
              .zoneWiseVariations![i]
              .price!
              .toDouble();
        }
      }
    }
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        boxShadow: Get.isDarkMode ? null : cardShadow,
      ),
      child: Row(children: [
        Stack(children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeSmall,
              vertical: Dimensions.paddingSizeSmall,
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                  child: CustomImage(
                    image:
                        '${Get.find<SplashController>().configModel.content!.imageBaseUrl!}/service/${serviceList[index].thumbnail}',
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width * 1.30,
                    fit: BoxFit.cover,
                  ),
                ),
                if (discountAmount != null &&
                    discountAmountType != null &&
                    discountAmount! > 0)
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        padding: const EdgeInsets.all(
                            Dimensions.paddingSizeExtraSmall),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.error,
                          borderRadius: const BorderRadius.only(
                            bottomLeft:
                                Radius.circular(Dimensions.radiusDefault),
                            topRight: Radius.circular(Dimensions.radiusSmall),
                          ),
                        ),
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            PriceConverter.percentageOrAmount(
                                '$discountAmount', discountAmountType!),
                            style: ubuntuMedium.copyWith(
                                overflow: TextOverflow.ellipsis,
                                color: Theme.of(context).primaryColorLight),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ]),
      ]),
    );
  }
}
