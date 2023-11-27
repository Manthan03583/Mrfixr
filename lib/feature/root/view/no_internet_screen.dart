import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';
import 'package:lottie/lottie.dart';

class NoInternetScreen extends StatelessWidget {
  final Widget? child;
  const NoInternetScreen({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/animations/no_internet2.json',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.35),

            // Image.asset('assets/images/internet_loading.gif', height: 250),
            const SizedBox(height: 40),
            Text('Whoops!'.tr,
                style: ubuntuBold.copyWith(
                  fontSize: 30,
                  color: Colors.red,
                )),
            const SizedBox(height: 10),
            Text(
              'no_internet_connection'.tr,
              textAlign: TextAlign.center,
              style: ubuntuBold.copyWith(
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'You seem to have lost your internet connection.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Please check your settings & try again',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: CustomButton(
                      height: 30,
                      width: 100,
                      radius: 20.0,
                      onPressed: () async {
                        if (await Connectivity().checkConnectivity() !=
                            ConnectivityResult.none) {
                          Navigator.pushReplacement(Get.context!,
                              MaterialPageRoute(builder: (_) => child!));
                        }
                      },
                      buttonText: 'retry'.tr,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  'or'.tr,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: CustomButton(
                      height: 30,
                      width: 100,
                      radius: 20.0,
                      onPressed: () async {},
                      buttonText: 'Call Us'.tr,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
