import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen({super.key});

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      setState(() => _currentTab = _tabController.index);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tab bar card
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppDims.cardRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
              )
            ],
          ),
          child: TabBar(
            controller: _tabController,
            labelColor: AppColors.primaryPurple,
            unselectedLabelColor: AppColors.textSecondary,
            indicatorColor: AppColors.primaryPurple,
            indicatorWeight: 3,
            labelStyle:
                AppTextStyles.bodyDark.copyWith(fontWeight: FontWeight.w600),
            tabs: const [
              Tab(text: 'Announcements'),
              Tab(text: 'Company Info'),
              Tab(text: 'Policies'),
            ],
          ),
        ),
        const SizedBox(height: AppDims.gapLg),
        // Content — rendered directly (no fixed height)
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: KeyedSubtree(
            key: ValueKey(_currentTab),
            child: _buildCurrentTab(),
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentTab() {
    switch (_currentTab) {
      case 1:
        return _buildCompanyInfo();
      case 2:
        return _buildPolicies();
      default:
        return _buildAnnouncements();
    }
  }

  Widget _buildAnnouncements() {
    final items = [
      _Announcement(
        title: 'Office Closed on 30 June',
        date: '27 Jun 2026',
        body:
            'The office will remain closed on Monday, 30 June 2026 on account of a public holiday. All employees are requested to plan their tasks accordingly.',
        icon: Icons.event_rounded,
        color: AppColors.primaryPurple,
        tag: 'Holiday',
      ),
      _Announcement(
        title: 'Salary Revision Effective July',
        date: '25 Jun 2026',
        body:
            'Annual salary revisions will be effective from 1st July 2026. HR will share individual letters by 28 June. Please reach out to hr@adstacks.in for any queries.',
        icon: Icons.payments_rounded,
        color: const Color(0xFF22C55E),
        tag: 'HR',
      ),
      _Announcement(
        title: 'New Leave Policy Update',
        date: '20 Jun 2026',
        body:
            'The leave policy has been updated to include 2 additional casual leaves per year. The updated policy document is available in the Policies tab.',
        icon: Icons.policy_rounded,
        color: const Color(0xFFF59E0B),
        tag: 'Policy',
      ),
      _Announcement(
        title: 'Team Outing — 5 July',
        date: '18 Jun 2026',
        body:
            'The quarterly team outing is scheduled for 5th July 2026. Please fill the attendance form shared on the company WhatsApp group by 30 June.',
        icon: Icons.celebration_rounded,
        color: const Color(0xFF3B82F6),
        tag: 'Event',
      ),
    ];

    return Column(
      children: items
          .map((a) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppDims.cardRadius),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 8,
                      )
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: a.color.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(a.icon, color: a.color, size: 22),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Expanded(
                                child: Text(
                                  a.title,
                                  style: AppTextStyles.bodyDark
                                      .copyWith(fontWeight: FontWeight.w700),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                decoration: BoxDecoration(
                                  color: a.color.withValues(alpha: 0.12),
                                  borderRadius:
                                      BorderRadius.circular(AppDims.pillRadius),
                                ),
                                child: Text(
                                  a.tag,
                                  style: AppTextStyles.caption.copyWith(
                                    color: a.color,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ]),
                            const SizedBox(height: 4),
                            Text(a.date, style: AppTextStyles.caption),
                            const SizedBox(height: 6),
                            Text(a.body, style: AppTextStyles.body),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildCompanyInfo() {
    final info = [
      ('Company Name', 'Adstacks Pvt. Ltd.', Icons.business_rounded),
      ('Founded', '2018', Icons.calendar_today_rounded),
      ('Industry', 'Digital Marketing & Technology', Icons.computer_rounded),
      ('CEO', 'Pooja Mishra', Icons.person_rounded),
      ('Headquarters', 'Mumbai, Maharashtra, India', Icons.location_on_rounded),
      ('Employees', '120+', Icons.people_rounded),
      ('Website', 'www.adstacks.in', Icons.language_rounded),
      ('Email', 'contact@adstacks.in', Icons.email_rounded),
      ('Phone', '+91 98765 43210', Icons.phone_rounded),
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDims.cardRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: AppGradients.purpleButton,
                borderRadius: BorderRadius.circular(14),
              ),
              child:
                  const Icon(Icons.bolt_rounded, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 16),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Adstacks', style: AppTextStyles.h2),
              Text('Digital Marketing & Technology',
                  style: AppTextStyles.caption),
            ]),
          ]),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 12),
          ...info.map((i) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Row(children: [
                  Icon(i.$3, size: 18, color: AppColors.primaryPurple),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 140,
                    child: Text(
                      i.$1,
                      style: AppTextStyles.caption
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    child: Text(i.$2, style: AppTextStyles.bodyDark),
                  ),
                ]),
              )),
        ],
      ),
    );
  }

  Widget _buildPolicies() {
    final policies = [
      (
        'Leave Policy',
        'Updated 20 Jun 2026',
        Icons.beach_access_rounded,
        'Employees are entitled to 12 casual leaves, 12 sick leaves, and 15 earned leaves per year. 2 additional casual leaves added effective 2026.',
      ),
      (
        'Work From Home Policy',
        'Updated 1 Jan 2026',
        Icons.home_work_rounded,
        'Employees may work from home up to 2 days per week, subject to manager approval. Core hours are 10 AM – 5 PM IST.',
      ),
      (
        'Code of Conduct',
        'Updated 1 Apr 2025',
        Icons.gavel_rounded,
        'All employees are expected to maintain professional behavior, respect colleagues, and protect company confidential information at all times.',
      ),
      (
        'Travel & Expense Policy',
        'Updated 15 Mar 2026',
        Icons.receipt_long_rounded,
        'Business travel must be approved 5 days in advance. Expense claims must be submitted within 7 days of travel with supporting receipts.',
      ),
    ];

    return Column(
      children: policies
          .map((p) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppDims.cardRadius),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 8,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color:
                                AppColors.primaryPurple.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(p.$3,
                              color: AppColors.primaryPurple, size: 20),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                p.$1,
                                style: AppTextStyles.bodyDark
                                    .copyWith(fontWeight: FontWeight.w700),
                              ),
                              Text(p.$2, style: AppTextStyles.caption),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.download_rounded, size: 20),
                          color: AppColors.primaryPurple,
                          onPressed: () {},
                        ),
                      ]),
                      const SizedBox(height: 10),
                      Text(p.$4, style: AppTextStyles.body),
                    ],
                  ),
                ),
              ))
          .toList(),
    );
  }
}

class _Announcement {
  const _Announcement({
    required this.title,
    required this.date,
    required this.body,
    required this.icon,
    required this.color,
    required this.tag,
  });
  final String title, date, body, tag;
  final IconData icon;
  final Color color;
}
