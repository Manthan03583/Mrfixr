import 'package:demandium/core/core_export.dart';
import 'package:get/get.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool? backButton;
  const SearchAppBar({super.key, this.backButton = true});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context)
        ? const WebMenuBar()
        : SafeArea(
            child: AppBar(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              title: Container(
                decoration: BoxDecoration(
                  color: Get.isDarkMode
                      ? Theme.of(context).cardColor.withOpacity(0.0)
                      : Theme.of(context).colorScheme.primary,
                  border: Border(
                      bottom: BorderSide(
                          width: .4,
                          color: Theme.of(context)
                              .primaryColorLight
                              .withOpacity(.2))),
                ),
                child: const SearchWidget(),
              ),
              titleSpacing: 0,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                ),
                color: Theme.of(context).primaryColorLight,
                onPressed: () => Navigator.pop(context),
              ),
            ),
          );
  }

  @override
  Size get preferredSize => Size(
      Dimensions.webMaxWidth,
      ResponsiveHelper.isDesktop(Get.context)
          ? Dimensions.preferredSizeWhenDesktop
          : Dimensions.preferredSize);
}
