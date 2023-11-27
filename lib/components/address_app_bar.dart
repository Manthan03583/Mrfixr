import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class AddressAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool? backButton;
  const AddressAppBar({super.key, this.backButton = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Get.isDarkMode
          ? Theme.of(context).cardColor.withOpacity(.2)
          : Theme.of(context).primaryColor,
      shape: Border(
          bottom: BorderSide(
              width: .4,
              color: Theme.of(context).primaryColorLight.withOpacity(.2))),
      elevation: 0,
      leadingWidth: backButton! ? Dimensions.paddingSizeLarge : 0,
      leading: backButton!
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: Theme.of(context).cardColor,
              onPressed: () => Navigator.pop(context),
            )
          : const SizedBox(),
      title: Row(children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
          ),
          // color: Colors.amber,
          height: 33,
          width: 33,
          child: Image.asset(
            Images.appbarLogo,
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(
          width: 7,
        ),
        Expanded(
          child: InkWell(
            hoverColor: Colors.transparent,
            onTap: () {
              Get.toNamed(RouteHelper.getAccessLocationRoute('address'));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('services_in'.tr,
                    style: ubuntuRegular.copyWith(
                        color: Get.isDarkMode
                            ? Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .color!
                                .withOpacity(.6)
                            : Colors.black,
                        // color: Theme.of(context).primaryColorLight,
                        fontSize: Dimensions.fontSizeExtraSmall)),
                const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveHelper.isDesktop(context)
                        ? Dimensions.paddingSizeSmall
                        : 0,
                  ),
                  child: GetBuilder<LocationController>(
                      builder: (locationController) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (locationController.getUserAddress() != null)
                          Flexible(
                            child: Text(
                              
                              locationController.getUserAddress()!.address!.toString(),
                              style: ubuntuRegular.copyWith(
                                  color: Get.isDarkMode
                                      ? Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color!
                                          .withOpacity(.6)
                                      : Colors.black,
                                  fontSize: Dimensions.fontSizeSmall),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        Icon(Icons.arrow_forward_ios_rounded,
                            color: Get.isDarkMode
                                ? Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color!
                                    .withOpacity(.6)
                                : Colors.black,
                            size: 12),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
        InkWell(
            hoverColor: Colors.transparent,
            // onTap: () => Get.toNamed(RouteHelper.getNotificationRoute()),
            child: Icon(
              Icons.shopping_bag,
              size: 25,
              color: Get.isDarkMode
                  ? Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color!
                      .withOpacity(.6)
                  : Theme.of(context).colorScheme.primary,
            )),
        const SizedBox(
          width: 5,
        ),
        InkWell(
            hoverColor: Colors.transparent,
            onTap: () => Get.toNamed(RouteHelper.getNotificationRoute()),
            child: Icon(
              Icons.notifications_none,
              size: 25,
              color: Get.isDarkMode
                  ? Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color!
                      .withOpacity(.6)
                  : Theme.of(context).colorScheme.primary,
            )),
      ]),
    );
  }

  @override
  Size get preferredSize =>
      Size(Dimensions.webMaxWidth, GetPlatform.isDesktop ? 70 : 56);
}
