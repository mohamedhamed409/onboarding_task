import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tadhil/core/utils/colors.dart';
import 'package:tadhil/features/onboarding/data/onboarding_model.dart';

import '../../view_model/cubit/cubit.dart';

class OnBoardingItem extends StatelessWidget {
  final OnboardingModel onboardingModel;

  const OnBoardingItem({super.key, required this.onboardingModel});

  @override
  Widget build(BuildContext context) {
    var cubit = OnboardingCubit.get(context);

    return Stack(
      children: [
        Container(
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColor.shamwa.withOpacity(0),
                AppColor.shamwa,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                onboardingModel.backgroundImg,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 60, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                onboardingModel.logo,
                width: 120,
                height: 53,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                onboardingModel.description,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 16,
              ),
              SmoothPageIndicator(
                controller: cubit.pageController,
                count: cubit.onboardingList.length,

                ///lang ar or en
                textDirection: TextDirection.rtl,
                effect: const ExpandingDotsEffect(
                  dotColor: AppColor.unSelectedDots,
                  activeDotColor: Colors.white,
                  dotHeight: 5,
                  dotWidth: 10,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 163,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        onPressed: () {
                          if (cubit.isLast.value) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Scaffold(
                                body: Center(
                                  child: Text('Login'),
                                ),
                              ),
                            ));
                          } else {
                            cubit.pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        child: ValueListenableBuilder<bool>(
                          valueListenable: cubit.isLast,
                          builder: (context, isLast, child) => Text(
                            !isLast ? "استمرار" : "تسجيل الدخول",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        )),
                  ),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        cubit.pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: const Text(
                        'تخطي',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}