import 'package:demandium/core/core_export.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
          border: Border.all(
            width: 1.5,
            color: Theme.of(context).colorScheme.primary,
          ),
          // color: Colors.grey,
          // color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.radiusExtraMoreLarge)),
      alignment: Alignment.center,

      // child: CircularProgressIndicator(
      //   color: Theme.of(context).colorScheme.primary,
      // ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            Images.appbarLogo,
            fit: BoxFit.cover,
            height: 60,
            width: 60,
          ),
          // CircularProgressIndicator(
          //   color: Theme.of(context).colorScheme.primary,
          //   strokeWidth: 0.7,
          // )
        ],
      ),
    ));
  }
}
