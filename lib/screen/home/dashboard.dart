import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/services/dashboard_control.dart';
import 'package:car_rental/core/services/auth.dart';
import 'package:car_rental/screen/home/order/order.dart';
import 'package:car_rental/widget/boxtext.dart';
import 'package:car_rental/widget/car_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with AutomaticKeepAliveClientMixin {
  final DashboardController controller = Get.find<DashboardController>();
  final AuthController authController = Get.find<AuthController>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFFF1908),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 300,
            left: 0,
            right: 0,
            child: Image.asset("assets/image/coverred.jpg", fit: BoxFit.cover),
          ),
          GestureDetector(
            onTap: controller.unfocusSearch,
            child: SafeArea(
              child: ScrollConfiguration(
                behavior: NoGlowScrollBehavior(),
                child: CustomScrollView(
                  physics: const ClampingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      stretch: false,
                      automaticallyImplyLeading: false,
                      backgroundColor: const Color(0xFFFF1908),
                      expandedHeight: 100,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            left: 20,
                            right: 20,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Hello",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: onInverseSurfaceColor(context),
                                      ),
                                    ),
                                    Obx(() {
                                      return Text(
                                        authController.username.value,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: onInverseSurfaceColor(context),
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                              Obx(() {
                                final path = authController.userPhotoPath.value;
                                return Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: ClipOval(
                                    child:
                                        (authController.isLoggedIn.value &&
                                            path != null &&
                                            path.isNotEmpty &&
                                            controller.userPhoto.value != null)
                                        ? Image.file(
                                            controller.userPhoto.value!,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            'assets/image/man.png',
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverAppBar(
                      stretch: false,
                      automaticallyImplyLeading: false,
                      backgroundColor: const Color(0xFFFF1908),
                      expandedHeight: 210,
                      toolbarHeight: 220,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: BoxText(
                                label: "search cars",
                                iconData: Icons.search,
                                onChanged: controller.searchCars,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Text(
                                "List Cars",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: onInverseSurfaceColor(context),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 100,
                              child: ListView.builder(
                                controller: controller.brandScrollController,
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.brand.length,
                                itemBuilder: (context, index) {
                                  final brandName = controller.brand[index]
                                      .split('/')
                                      .last
                                      .split('.')
                                      .first
                                      .toLowerCase();
                                  return Obx(() {
                                    final isSelected =
                                        controller.selectedBrand.value
                                            .toLowerCase() ==
                                        brandName;
                                    return GestureDetector(
                                      onTap: () =>
                                          controller.selectBrand(brandName),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 5,
                                        ),
                                        child: Container(
                                          width: 90,
                                          margin: const EdgeInsets.all(10),
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                            color: isSelected
                                                ? Colors.grey.shade400
                                                : onInverseSurfaceColor(
                                                    context,
                                                  ),
                                          ),
                                          child: Image.asset(
                                            controller.brand[index],
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Obx(() {
                        if (controller.isLoading.value) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                              () => CarList(
                                key: PageStorageKey('carList'),
                                cars: controller.cars,
                                selectedBrand: controller.selectedBrand.value,
                                searchText: controller.searchText.value,
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
