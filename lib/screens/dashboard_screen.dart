import 'package:flutter/material.dart';
import '/theme/app_theme.dart';
import '/utils/responsive.dart';
import '/widgets/sidebar.dart';
import '/widgets/top_bar.dart';
import '/widgets/top_banner.dart';
import '/widgets/all_projects_card.dart';
import '/widgets/top_creators_card.dart';
import '/widgets/performance_chart.dart';
import '/widgets/calendar_card.dart';
import '/widgets/birthday_anniversary_card.dart';
import '/screens/employees_screen.dart';
import '/screens/attendance_screen.dart';
import '/screens/summary_screen.dart';
import '/screens/information_screen.dart';
import '/screens/settings_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedNavIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Returns the screen title for TopBar
  String get _currentTitle {
    switch (_selectedNavIndex) {
      case 1:
        return 'Employees';
      case 2:
        return 'Attendance';
      case 3:
        return 'Summary';
      case 4:
        return 'Information';
      case 5:
        return 'Settings';
      default:
        return 'Home';
    }
  }

  // Returns the body widget for the selected nav item
  Widget _buildCurrentScreen() {
    switch (_selectedNavIndex) {
      case 1:
        return const EmployeesScreen();
      case 2:
        return const AttendanceScreen();
      case 3:
        return const SummaryScreen();
      case 4:
        return const InformationScreen();
      case 5:
        return const SettingsScreen();
      default:
        return _buildHomeContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.scaffoldBg,
      drawer: isMobile
          ? Drawer(
              width: 280,
              child: AppSidebar(
                selectedIndex: _selectedNavIndex,
                onItemSelected: (i) {
                  setState(() => _selectedNavIndex = i);
                  Navigator.of(context).pop();
                },
                onClose: () => Navigator.of(context).pop(),
              ),
            )
          : null,
      body: SafeArea(
        child: ResponsiveLayout(
          mobile: (_) => _buildStackedLayout(),
          tablet: (_) => _buildWideLayout(railBelowMain: true),
          desktop: (_) => _buildWideLayout(railBelowMain: false),
        ),
      ),
    );
  }

  Widget _buildWideLayout({required bool railBelowMain}) {
    final sidebarWidth = Responsive.isTablet(context) ? 220.0 : 260.0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          width: sidebarWidth,
          child: AppSidebar(
            selectedIndex: _selectedNavIndex,
            onItemSelected: (i) => setState(() => _selectedNavIndex = i),
          ),
        ),
        Expanded(
          child: MaxWidthBox(
            maxWidth: 1700,
            child: Padding(
              padding: EdgeInsets.all(Responsive.pagePadding(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopBar(title: _currentTitle),
                  const SizedBox(height: AppDims.gapLg),
                  Expanded(
                    child: _selectedNavIndex == 0
                        ? (railBelowMain
                            ? _buildHomeStacked()
                            : _buildHomeSideBySide())
                        : SingleChildScrollView(
                            child: _buildCurrentScreen(),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHomeSideBySide() {
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 3, child: _buildHomeContent()),
          const SizedBox(width: AppDims.gapLg),
          SizedBox(width: 320, child: _buildRightRail()),
        ],
      ),
    );
  }

  Widget _buildHomeStacked() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHomeContent(),
          const SizedBox(height: AppDims.gapLg),
          _buildRightRail(),
        ],
      ),
    );
  }

  Widget _buildStackedLayout() {
    return Padding(
      padding: EdgeInsets.all(Responsive.pagePadding(context)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopBar(
              title: _currentTitle,
              onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
            ),
            const SizedBox(height: AppDims.gapLg),
            _selectedNavIndex == 0
                ? Column(
                    children: [
                      _buildHomeContent(),
                      const SizedBox(height: AppDims.gapLg),
                      _buildRightRail(),
                    ],
                  )
                : _buildCurrentScreen(),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TopBanner(),
        const SizedBox(height: AppDims.gapLg),
        LayoutBuilder(
          builder: (context, constraints) {
            final isNarrow = constraints.maxWidth < 640;
            if (isNarrow) {
              return const Column(
                children: [
                  AllProjectsCard(),
                  SizedBox(height: AppDims.gapLg),
                  TopCreatorsCard(),
                ],
              );
            }
            return const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: AllProjectsCard()),
                SizedBox(width: AppDims.gapLg),
                Expanded(child: TopCreatorsCard()),
              ],
            );
          },
        ),
        const SizedBox(height: AppDims.gapLg),
        const PerformanceChartCard(),
      ],
    );
  }

  Widget _buildRightRail() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CalendarCard(),
        SizedBox(height: AppDims.gapLg),
        CelebrationCard(
          title: 'Today Birthday',
          total: 2,
          buttonLabel: 'Birthday Wishing',
          badgeIcon: Icons.cake_rounded,
          avatarCount: 2,
        ),
        SizedBox(height: AppDims.gapLg),
        CelebrationCard(
          title: 'Anniversary',
          total: 3,
          buttonLabel: 'Anniversary Wishing',
          badgeIcon: Icons.favorite_rounded,
          avatarCount: 3,
        ),
      ],
    );
  }
}