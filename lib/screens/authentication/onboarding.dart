import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:invoice_pay/screens/authentication/login.dart';
import 'package:invoice_pay/styles/colors.dart';
import 'package:invoice_pay/utils/app_locales.dart';
import 'package:invoice_pay/widgets/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<Map<String, dynamic>> _pages(BuildContext context) => [
    {
      "title": AppLocale.onboardingTitle1.getString(context),
      "description": AppLocale.onboardingDesc1.getString(context),
      "icon": Icons.receipt_long,
      "color": Colors.blue,
    },
    {
      "title": AppLocale.onboardingTitle2.getString(context),
      "description": AppLocale.onboardingDesc2.getString(context),
      "icon": Icons.payment,
      "color": Colors.blue,
    },
    {
      "title": AppLocale.onboardingTitle3.getString(context),
      "description": AppLocale.onboardingDesc3.getString(context),
      "icon": Icons.trending_up,
      "color": Colors.purple,
    },
  ];

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_complete', true);
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 48),

              // Dots Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages(context).length,
                  (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    height: 10,
                    width: _currentPage == i ? 32 : 10,
                    decoration: BoxDecoration(
                      color: _currentPage == i
                          ? Colors.white
                          : Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (value) =>
                      setState(() => _currentPage = value),
                  itemCount: _pages(context).length,
                  itemBuilder: (context, index) {
                    return _OnboardingPage(data: _pages(context)[index]);
                  },
                ),
              ),

              // Dots + Button
              Column(
                children: [
                  // Action Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        onPressed: () {
                          if (_currentPage == _pages(context).length - 1) {
                            _completeOnboarding();
                          } else {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        text: _currentPage == _pages(context).length - 1
                            ? AppLocale.getStarted.getString(context)
                            : AppLocale.next.getString(context),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Skip Button
                  if (_currentPage < _pages(context).length - 1)
                    TextButton(
                      onPressed: _completeOnboarding,
                      child: Text(
                        AppLocale.skip.getString(context),
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    ),

                  const SizedBox(height: 10),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const _OnboardingPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Large Icon
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: (data['color'] as Color).withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(data['icon'], size: 100, color: data['color']),
          ),

          const SizedBox(height: 20),

          // Title
          Text(
            data['title'],
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.3,
            ),
          ),

          const SizedBox(height: 20),

          // Description
          Text(
            data['description'],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
