import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/components/menu_drawer.dart';
import 'package:demandium/feature/home/widget/category_view.dart';
import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class CategorySubCategoryScreen extends StatefulWidget {
  final String categoryID;
  final String categoryName;
  final String subCategoryIndex;
  const CategorySubCategoryScreen(
      {Key? key,
      required this.categoryID,
      required this.categoryName,
      required this.subCategoryIndex})
      : super(key: key);

  @override
  State<CategorySubCategoryScreen> createState() =>
      _CategorySubCategoryScreenState();
}

class _CategorySubCategoryScreenState extends State<CategorySubCategoryScreen> {
  //Widget color change
  ScrollController scrollController = ScrollController();
  int selectedIndex = -1;

  // @override
  // void initState() {
  //   // Get.find<CategoryController>().getCategoryList(1, false);
  //   // subCategoryIndex = widget.subCategoryIndex;
  //   // Get.find<CategoryController>().getSubCategoryList(
  //   //     widget.categoryID, int.parse(widget.subCategoryIndex),
  //   //     shouldUpdate: false);
  //   // Get.find<CategoryController>()
  //   //   .getSubCategoryList(widget.categoryID, shouldUpdate: false);

  //   if (!ResponsiveHelper.isWeb(context)) {
  //     // moved();
  //   }
  //   super.initState();
  // }

  // moved() async {
  //   Future.delayed(const Duration(seconds: 1), () {
  //     try {
  //       // Scrollable.ensureVisible(
  //       //   Get.find<CategoryController>()
  //       //       .categoryList!
  //       //       .elementAt(int.parse(subCategoryIndex!))
  //       //       .globalKey!
  //       //       .currentContext!,
  //       //   duration: const Duration(seconds: 1),
  //       // );
  //     } catch (e) {
  //       if (kDebugMode) {
  //         print('');
  //       }
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Get.find<CategoryController>().getCategoryList(1, false);

    Get.find<CategoryController>()
        .getSubCategoryList(widget.categoryID, shouldUpdate: false);

    return GetBuilder<CategoryController>(builder: (categoryController) {
      List<CategoryModel> categoryList = categoryController.categoryList!;
      return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColorLight,
          endDrawer:
              ResponsiveHelper.isDesktop(context) ? const MenuDrawer() : null,
          appBar: CustomAppBar(
            title: 'available_service'.tr,
          ),
          body: FooterBaseView(
            child: SizedBox(
              width: Dimensions.webMaxWidth,
              child: CustomScrollView(
                shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                slivers: [
                  // const SliverToBoxAdapter(
                  //   child: SizedBox(
                  //     height: Dimensions.paddingSizeExtraLarge,
                  //   ),
                  // ),
                  SliverToBoxAdapter(
                    child: (categoryController.categoryList != null &&
                            !categoryController.isSearching!)
                        ? Center(
                            child: Container(
                              height: ResponsiveHelper.isDesktop(context)
                                  ? MediaQuery.of(context).size.height * 1.2
                                  : Dimensions.webMaxWidth,
                              margin: EdgeInsets.only(
                                left: ResponsiveHelper.isDesktop(context)
                                    ? 0
                                    : Dimensions.paddingSizeDefault,
                              ),
                              width: ResponsiveHelper.isDesktop(context)
                                  ? MediaQuery.of(context).size.width * 0.65
                                  : ResponsiveHelper.isTab(context)
                                      ? 440
                                      : 430,
                              padding: ResponsiveHelper.isWeb(context)
                                  ? const EdgeInsets.all(0)
                                  : const EdgeInsets.only(
                                      bottom: Dimensions.paddingSizeExtraSmall,
                                      top: Dimensions.paddingSizeDefault),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.1),
                                child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        ResponsiveHelper.isWeb(context) ? 4 : 3,
                                    crossAxisSpacing:
                                        ResponsiveHelper.isWeb(context)
                                            ? 10.0
                                            : 6.0,
                                    mainAxisSpacing:
                                        ResponsiveHelper.isWeb(context)
                                            ? 30.0
                                            : 20.0,
                                  ),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount:
                                      categoryController.categoryList!.length,
                                  physics: ResponsiveHelper.isDesktop(context)
                                      ? const NeverScrollableScrollPhysics()
                                      : const BouncingScrollPhysics(),
                                  padding: EdgeInsets.only(
                                    left: ResponsiveHelper.isDesktop(context)
                                        ? 0
                                        : Dimensions.paddingSizeSmall,
                                    right: ResponsiveHelper.isDesktop(context)
                                        ? 0
                                        : Dimensions.paddingSizeSmall,
                                  ),
                                  itemBuilder: (context, index) {
                                    CategoryModel availableServices =
                                        categoryList[index];

                                    return InkWell(
                                      key: !ResponsiveHelper.isWeb(context)
                                          ? availableServices.globalKey
                                          : null,
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = index;
                                          //   availableServices.isSelected =
                                          //       !availableServices.isSelected;
                                          //   if (previousIndex != -1 &&
                                          //       (previousIndex != index)) {
                                          //     categoryList[previousIndex]
                                          //         .isSelected = false;
                                          //   } else if (previousIndex == index) {
                                          //     availableServices.isSelected = true;
                                          //   }
                                          //   previousIndex = index;
                                          // });
                                          // subCategoryIndex = index.toString();
                                          // Get.find<CategoryController>()
                                          //     .getSubCategoryList(
                                          //         categoryModel.id!, index);
                                        });
                                        Get.toNamed(
                                            RouteHelper.subCategoryScreenRoute(
                                                availableServices.name!,
                                                availableServices.id!,
                                                index));
                                      },
                                      hoverColor: Colors.transparent,
                                      child: Container(
                                        width: ResponsiveHelper.isDesktop(
                                                context)
                                            ? 150
                                            : ResponsiveHelper.isTab(context)
                                                ? 140
                                                : 100,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: Dimensions
                                                .paddingSizeExtraSmall),
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade400,
                                              blurRadius: 7,
                                              spreadRadius: 2,
                                              offset: const Offset(
                                                4,
                                                4,
                                              ),
                                            ),
                                            const BoxShadow(
                                              color: Colors.white,
                                              blurRadius: 5,
                                              spreadRadius: 2,
                                              offset: Offset(
                                                -4,
                                                -4,
                                              ),
                                            ),
                                          ],
                                          color: selectedIndex == index
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                              : Theme.of(context)
                                                  .primaryColorLight,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(
                                                Dimensions.radiusDefault),
                                          ),
                                        ),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions
                                                            .radiusDefault),
                                                child: CustomImage(
                                                  fit: BoxFit.contain,
                                                  height: ResponsiveHelper
                                                          .isDesktop(context)
                                                      ? 50
                                                      : ResponsiveHelper.isTab(
                                                              context)
                                                          ? 40
                                                          : 45,
                                                  width: ResponsiveHelper
                                                          .isDesktop(context)
                                                      ? 50
                                                      : ResponsiveHelper.isTab(
                                                              context)
                                                          ? 40
                                                          : 50,
                                                  image:
                                                      '${Get.find<SplashController>().configModel.content!.imageBaseUrl}'
                                                      '/category/${categoryController.categoryList![index].image}',
                                                ),
                                              ),
                                              const SizedBox(
                                                height:
                                                    Dimensions.paddingSizeSmall,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets
                                                        .symmetric(
                                                    horizontal: Dimensions
                                                        .paddingSizeDefault),
                                                child: Text(
                                                  categoryController
                                                      .categoryList![index]
                                                      .name!,
                                                  style: ubuntuRegular.copyWith(
                                                      fontSize: Dimensions
                                                          .fontSizeSmall,
                                                      color:
                                                          selectedIndex == index
                                                              ? Colors.white
                                                              : Colors.black),
                                                  maxLines: 2,
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ]),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          )
                        : ResponsiveHelper.isDesktop(context)
                            ? WebCategoryShimmer(
                                categoryController: categoryController,
                                fromHomeScreen: false,
                              )
                            : const SizedBox(),
                  ),
                  // SliverToBoxAdapter(
                  //   child: SizedBox(
                  //     width: Dimensions.webMaxWidth,
                  //     child: Padding(
                  //       padding: const EdgeInsets.symmetric(
                  //           vertical: Dimensions.paddingSizeLarge),
                  //       child: Center(
                  //         child: Text(
                  //           'sub_categories'.tr,
                  //           style: ubuntuRegular.copyWith(
                  //               fontSize: Dimensions.fontSizeDefault,
                  //               color: Get.isDarkMode
                  //                   ? Colors.white
                  //                   : Theme.of(context).colorScheme.primary),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  // SubCategoryView(
                  //   noDataText: "no_subcategory_found".tr,
                  //   isScrollable: true,
                  // ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
