import 'package:flutter/material.dart';
import 'package:mal3ab/core/cache_helper.dart';
import 'package:mal3ab/features/auth/presentation/login/views/login_view.dart';
import 'package:mal3ab/features/auth/presentation/login/views/widgets/custom_botton.dart';
import 'package:mal3ab/features/on_boarding/presentation/views/widgets/dot_section.dart';
import 'package:mal3ab/features/on_boarding/presentation/views/widgets/on_boarding_item.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  List<Widget> screens = [
    OnBoardingItem(
      title: 'Mal3ab',
      description: 'Book your place and join football matches',
      animation: 'assets/images/Footballer.json',
    ),
    OnBoardingItem(
      title: 'Matches',
      description: 'Discover who’s playing with you \n and stay connected',
      animation: 'assets/images/Soccer player kick on the ball.json',
    ),
  ];
  late PageController _pageController;
  int currentPage = 0;
  void initState() {
    _pageController = PageController();

    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page!.round();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: _pageController,
          itemBuilder: (context, index) {
            return screens[index];
          },
          itemCount: screens.length,
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.03,
          right: 0,
          left: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Builder(
              builder: (context) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 15,
                  children: [
                    DotSection(pageIndex: currentPage),

                    CustomButton(
                      titleColor: Colors.white,

                      title: 'Next',
                      onTap: () {
                        if (currentPage == 1) {
                          CacheHelper.setBool('isOnBoardingSeen', true);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => LoginView()),
                          );
                        } else {
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        }
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        Positioned(
          top: 20,
          right: 20,
          child: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginView()),
              );
              CacheHelper.setBool('isOnBoardingSeen', true);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Skip',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
