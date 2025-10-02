import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:mal3ab/core/cache_helper.dart';
import 'package:mal3ab/features/auth/presentation/login/views/login_view.dart';
import 'package:mal3ab/onboarding/presentation/data/model/onboarding_model.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController pageController = PageController();
  int currentIndex = 0;
  List<OnboardingModel> onBoardingData = [
    OnboardingModel(
      title: 'Mal3ab',
      subTitle: 'Book your place and join football matches',
      image: 'assets/images/Footballer.json',
    ),
    OnboardingModel(
      title: 'Matches',
      subTitle: 'Discover who’s playing with you \n and stay connected',
      image: 'assets/images/Soccer player kick on the ball.json',
    ),
  ];

  void goToHome() {
    CacheHelper.setBool('isOnBoardingSeen', true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,

          children: [
            PageView.builder(
              controller: pageController,
              itemCount: onBoardingData.length,
              onPageChanged: (index) => setState(() => currentIndex = index),
              itemBuilder: (context, index) {
                final item = onBoardingData[index];

                return Column(
                  children: [
                    SizedBox(height: 16.h),

                    Text(item.title, style: TextStyle(fontSize: 24.w)),
                    SizedBox(height: 16.h),
                    Lottie.asset(
                      height: MediaQuery.sizeOf(context).height * .5,
                      fit: BoxFit.contain,
                      item.image,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      item.subTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18.w),
                    ),
                  ],
                );
              },
            ),

            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.only(bottom: 200.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onBoardingData.length,
                  (index) => AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 3.w),
                    width: currentIndex == index ? 24 : 8,
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: currentIndex == index ? Colors.blue : Colors.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * .6,
                    height: 40.w.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(8),
                        ),
                      ),
                      onPressed: currentIndex == onBoardingData.length - 1
                          ? goToHome
                          : () => pageController.nextPage(
                              duration: Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            ),
                      child: Text(
                        style: TextStyle(color: Colors.white),
                        currentIndex == onBoardingData.length - 1
                            ? 'start'
                            : 'next',
                      ),
                    ),
                  ),
                  SizedBox(height: 8.w.h),
                  TextButton(
                    onPressed: goToHome,
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * .6,
                      height: 40.w.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          'skip',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:lottie/lottie.dart';
// import 'package:mal3ab/core/cache_helper.dart';
// import 'package:mal3ab/features/auth/presentation/login/views/login_view.dart';
// import 'package:mal3ab/onboarding/presentation/data/model/onboarding_model.dart';

// class OnboardingView extends StatefulWidget {
//   const OnboardingView({super.key});

//   @override
//   State<OnboardingView> createState() => _OnboardingViewState();
// }

// class _OnboardingViewState extends State<OnboardingView> {
//   final PageController _pageController = PageController();
//   int _currentIndex = 0;

//   final List<OnboardingModel> _onBoardingData = [
//     OnboardingModel(
//       title: 'Mal3ab',
//       subTitle: 'book your place in match',
//       image: 'assets/images/Footballer.json',
//     ),
//     OnboardingModel(
//       title: 'Players',
//       subTitle: 'look who will play woth you \n stay tuned',
//       image: 'assets/images/Soccer player kick on the ball.json',
//     ),
//   ];

//   void _goToHome() {
//     CacheHelper.setBool('isOnBoardingSeen', true);
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (_) => const LoginView()),
//     );
//   }

//   Widget _buildImage(String path) {
//     if (path.endsWith('.json')) {
//       return Lottie.asset(
//         path,
//         height: MediaQuery.sizeOf(context).height * 0.45,
//         fit: BoxFit.contain,
//       );
//     } else {
//       return Image.asset(
//         path,
//         height: MediaQuery.sizeOf(context).height * 0.45,
//         fit: BoxFit.cover,
//       );
//     }
//   }

//   Widget _buildDots() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List.generate(
//         _onBoardingData.length,
//         (index) => AnimatedContainer(
//           duration: const Duration(milliseconds: 300),
//           margin: EdgeInsets.symmetric(horizontal: 3.w),
//           width: _currentIndex == index ? 24.w : 8.w,
//           height: 8.h,
//           decoration: BoxDecoration(
//             color: _currentIndex == index ? Colors.blue : Colors.grey,
//             borderRadius: BorderRadius.circular(8),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildBottomButtons() {
//     final bool isLastPage = _currentIndex == _onBoardingData.length - 1;

//     return Column(
//       children: [
//         SizedBox(
//           width: MediaQuery.sizeOf(context).width * .7,
//           height: 45.h,
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.blue,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             onPressed: isLastPage
//                 ? _goToHome
//                 : () => _pageController.nextPage(
//                     duration: const Duration(milliseconds: 400),
//                     curve: Curves.easeInOut,
//                   ),
//             child: Text(
//               isLastPage ? 'Start' : 'Next',
//               style: const TextStyle(color: Colors.white, fontSize: 16),
//             ),
//           ),
//         ),
//         SizedBox(height: 12.h),
//         TextButton(
//           onPressed: _goToHome,
//           child: Container(
//             width: MediaQuery.sizeOf(context).width * .7,
//             height: 45.h,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//               color: Colors.grey.shade200,
//             ),
//             child: const Center(
//               child: Text(
//                 'Skip',
//                 style: TextStyle(color: Colors.black, fontSize: 16),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: PageView.builder(
//                 controller: _pageController,
//                 itemCount: _onBoardingData.length,
//                 onPageChanged: (index) => setState(() => _currentIndex = index),
//                 itemBuilder: (context, index) {
//                   final item = _onBoardingData[index];
//                   return Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 16.w),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         SizedBox(height: 24.h),
//                         Text(
//                           item.title,
//                           style: TextStyle(
//                             fontSize: 24.sp,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 16.h),
//                         _buildImage(item.image),
//                         SizedBox(height: 16.h),
//                         Text(
//                           item.subTitle,
//                           textAlign: TextAlign.center,
//                           style: TextStyle(fontSize: 18.sp),
//                         ),
//                         const Spacer(),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//             SizedBox(height: 20.h),
//             _buildDots(),
//             SizedBox(height: 20.h),
//             _buildBottomButtons(),
//             SizedBox(height: 24.h),
//           ],
//         ),
//       ),
//     );
//   }
// }
