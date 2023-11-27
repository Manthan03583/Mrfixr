import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class CartWidget extends GetView<CartController> {
  final Color color;
  final double size;
  final bool fromRestaurant;
  const CartWidget(
      {super.key,
      required this.color,
      required this.size,
      this.fromRestaurant = false});

  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: [
      Image.asset(
        Images.cart,
        width: size,
        height: size,
        color: Get.isDarkMode ? Colors.white : Colors.black,
      ),
      GetBuilder<CartController>(builder: (cartController) {
        return cartController.cartList.isNotEmpty
            ? Positioned(
                top: -5,
                right: -5,
                child: Container(
                  height: size < 20 ? 10 : size / 2,
                  width: size < 20 ? 10 : size / 2,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Get.isDarkMode ? Colors.white : Colors.red,
                  ),
                  child: Text(
                    cartController.cartList.length.toString(),
                    style: ubuntuRegular.copyWith(
                      fontSize: size < 20 ? size / 3 : size / 3.8,
                      color: Colors.black,
                    ),
                  ),
                ),
              )
            : const SizedBox();
      }),
    ]);
  }
}
