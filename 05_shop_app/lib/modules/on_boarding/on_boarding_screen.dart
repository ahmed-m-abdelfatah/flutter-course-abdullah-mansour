import 'package:flutter/material.dart';
import '../../app_router.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/my_main_styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final List<BoardingModel> _boarding = [
    BoardingModel(
      image: 'assets/images/onboard_1.jpg',
      title: 'On Board 1 Title',
      body: 'On Board 1 Body',
    ),
    BoardingModel(
      image: 'assets/images/onboard_1.jpg',
      title: 'On Board 2 Title',
      body: 'On Board 2 Body',
    ),
    BoardingModel(
      image: 'assets/images/onboard_1.jpg',
      title: 'On Board 3 Title',
      body: 'On Board 3 Body',
    ),
  ];

  final PageController _pageBordingController = PageController();

  bool _isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      actions: [
        defaultTextButton(
          onPressedFunction: () => _goToLoginScreen(),
          text: 'Skip',
        ),
      ],
    );
  }

  Padding _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: [
          _buildPageView(),
          const SizedBox(height: 40),
          _buildIndicators(),
        ],
      ),
    );
  }

  Expanded _buildPageView() {
    return Expanded(
      child: PageView.builder(
        controller: _pageBordingController,
        physics: BouncingScrollPhysics(),
        itemBuilder: _itemBuilder,
        itemCount: _boarding.length,
        onPageChanged: _checkIfLastPage,
      ),
    );
  }

  void _checkIfLastPage(int index) {
    if (index == _boarding.length - 1) {
      setState(() {
        _isLastPage = true;
      });
    } else {
      setState(() {
        _isLastPage = false;
      });
    }
  }

  Widget _itemBuilder(context, index) {
    return _buildBoardingItem(context, _boarding[index]);
  }

  Column _buildBoardingItem(BuildContext context, BoardingModel model) {
    return Column(
      children: [
        Expanded(
          child: Image(
            image: AssetImage(model.image),
          ),
        ),
        const SizedBox(height: 30),
        Text(
          model.title,
          style: Theme.of(context).textTheme.headline5,
        ),
        const SizedBox(height: 15),
        Text(
          model.body,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Row _buildIndicators() {
    return Row(
      children: [
        SmoothPageIndicator(
          controller: _pageBordingController,
          count: _boarding.length,
          effect: ExpandingDotsEffect(
            dotColor: MyMainColors.myGrey,
            activeDotColor: MyMainColors.myBlue,
            dotHeight: 10,
            dotWidth: 10,
            expansionFactor: 4,
            spacing: 5,
          ),
        ),
        Spacer(),
        FloatingActionButton(
          onPressed: () {
            if (_isLastPage) {
              _goToLoginScreen();
            } else {
              _pageBordingController.nextPage(
                duration: Duration(milliseconds: 750),
                curve: Curves.fastLinearToSlowEaseIn,
              );
            }
          },
          child: Icon(Icons.arrow_forward_ios),
        )
      ],
    );
  }

  void _goToLoginScreen() {
    CacheHelper.saveCacheData(key: 'onBoarding', value: true).then((_) {
      Navigator.pushReplacementNamed(context, AppRouter.loginScreen);
    });
  }
}
