import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class ProfileCardItem extends StatelessWidget {
  final String leadingIcon;
  final bool? isDarkItem;
  final String title;
  final IconData? trailingIcon;
  final Function()? onTap;
  const ProfileCardItem(
      {Key? key,
      this.trailingIcon = Icons.arrow_forward_ios,
      required this.title,
      required this.leadingIcon,
      this.onTap,
      this.isDarkItem = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeExtraSmall),
      child: Card(
        elevation: 3,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        // height: 70,
        // width: Get.width,
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        //   // color: Theme.of(context).hoverColor,
        //   color: Colors.white,
        //   boxShadow: Get.isDarkMode ? null : cardShadow,
        // ),
        child: Center(
          child: ListTile(
            title: Row(
              children: [
                Image.asset(
                  leadingIcon,
                  width: Dimensions.profileImageSize,
                  // color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(
                  width: Dimensions.paddingSizeDefault,
                ),
                Text(title),
              ],
            ),
            trailing: isDarkItem == false
                ? Icon(
                    trailingIcon,
                    size: Dimensions.fontSizeDefault,
                    color: Theme.of(context).colorScheme.primary,
                  )
                : GetBuilder<ThemeController>(builder: (themeController) {
                    return Switch(
                        value: themeController.darkTheme,
                        onChanged: (value) {
                          themeController.toggleTheme();
                        });
                  }),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
