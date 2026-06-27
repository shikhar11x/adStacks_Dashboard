import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class _Employee {
  const _Employee({
    required this.name,
    required this.role,
    required this.department,
    required this.status,
    required this.joinDate,
    required this.salary,
  });
  final String name, role, department, status, joinDate, salary;
}

const List<_Employee> _kEmployees = [
  _Employee(name: 'Shikhar bajpai', role: 'Admin', department: 'Management', status: 'Active', joinDate: '01 Jan 2021', salary: '₹85,000'),
  _Employee(name: 'Rahul Sharma', role: 'Developer', department: 'Engineering', status: 'Active', joinDate: '15 Mar 2022', salary: '₹72,000'),
  _Employee(name: 'Anjali Verma', role: 'Designer', department: 'Creative', status: 'Active', joinDate: '10 Jun 2022', salary: '₹68,000'),
  _Employee(name: 'Vikram Singh', role: 'Manager', department: 'Sales', status: 'On Leave', joinDate: '05 Feb 2020', salary: '₹90,000'),
  _Employee(name: 'Priya Nair', role: 'HR Executive', department: 'HR', status: 'Active', joinDate: '20 Aug 2023', salary: '₹55,000'),
  _Employee(name: 'Amit Patel', role: 'DevOps', department: 'Engineering', status: 'Active', joinDate: '12 Nov 2021', salary: '₹78,000'),
  _Employee(name: 'Sneha Joshi', role: 'Content Writer', department: 'Marketing', status: 'Inactive', joinDate: '03 Apr 2022', salary: '₹45,000'),
  _Employee(name: 'Rohan Gupta', role: 'Analyst', department: 'Finance', status: 'Active', joinDate: '18 Jul 2023', salary: '₹62,000'),
];

class EmployeesScreen extends StatefulWidget {
  const EmployeesScreen({super.key});

  @override
  State<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  String _search = '';

  List<_Employee> get _filtered => _kEmployees
      .where((e) =>
          e.name.toLowerCase().contains(_search.toLowerCase()) ||
          e.department.toLowerCase().contains(_search.toLowerCase()) ||
          e.role.toLowerCase().contains(_search.toLowerCase()))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStatRow(),
        const SizedBox(height: AppDims.gapLg),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppDims.cardRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Text('All Employees', style: AppTextStyles.h3),
                    const Spacer(),
                    SizedBox(
                      width: 220,
                      child: TextField(
                        onChanged: (v) => setState(() => _search = v),
                        decoration: InputDecoration(
                          hintText: 'Search employees…',
                          hintStyle: AppTextStyles.caption,
                          prefixIcon: const Icon(Icons.search_rounded, size: 18),
                          contentPadding: const EdgeInsets.symmetric(vertical: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppDims.pillRadius),
                            borderSide: BorderSide(color: AppColors.divider),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppDims.pillRadius),
                            borderSide: BorderSide(color: AppColors.divider),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    _AddButton(),
                  ],
                ),
              ),
              const Divider(height: 1),
              // Full width table
              LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minWidth: constraints.maxWidth),
                      child: _buildTable(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatRow() {
    final stats = [
      ('Total Employees', '${_kEmployees.length}', Icons.people_rounded, AppColors.primaryPurple),
      ('Active', '${_kEmployees.where((e) => e.status == 'Active').length}', Icons.check_circle_outline_rounded, const Color(0xFF22C55E)),
      ('On Leave', '${_kEmployees.where((e) => e.status == 'On Leave').length}', Icons.event_busy_rounded, const Color(0xFFF59E0B)),
      ('Inactive', '${_kEmployees.where((e) => e.status == 'Inactive').length}', Icons.cancel_outlined, const Color(0xFFEF4444)),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 500;
        final cards = stats
            .map((s) => _StatCard(label: s.$1, value: s.$2, icon: s.$3, color: s.$4))
            .toList();
        if (isNarrow) {
          return Column(
            children: [
              Row(children: [
                Expanded(child: cards[0]),
                const SizedBox(width: 12),
                Expanded(child: cards[1]),
              ]),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(child: cards[2]),
                const SizedBox(width: 12),
                Expanded(child: cards[3]),
              ]),
            ],
          );
        }
        return Row(
          children: cards
              .expand((c) => [Expanded(child: c), if (c != cards.last) const SizedBox(width: 12)])
              .toList(),
        );
      },
    );
  }

  Widget _buildTable() {
    final employees = _filtered;
    return DataTable(
      headingRowColor: WidgetStateProperty.all(AppColors.scaffoldBg),
      dataRowMinHeight: 60,
      dataRowMaxHeight: 60,
      columnSpacing: 40,
      horizontalMargin: 24,
      dividerThickness: 1,
      columns: [
        DataColumn(label: Text('Name', style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w700))),
        DataColumn(label: Text('Role', style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w700))),
        DataColumn(label: Text('Department', style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w700))),
        DataColumn(label: Text('Join Date', style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w700))),
        DataColumn(label: Text('Salary', style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w700))),
        DataColumn(label: Text('Status', style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w700))),
      ],
      rows: employees.map((e) {
        Color statusColor;
        switch (e.status) {
          case 'Active':
            statusColor = const Color(0xFF22C55E);
            break;
          case 'On Leave':
            statusColor = const Color(0xFFF59E0B);
            break;
          default:
            statusColor = const Color(0xFFEF4444);
        }
        return DataRow(cells: [
          DataCell(Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.primaryPurple.withValues(alpha: 0.12),
                child: Text(
                  e.name[0],
                  style: const TextStyle(
                    color: AppColors.primaryPurple,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                e.name,
                style: AppTextStyles.bodyDark.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          )),
          DataCell(Text(e.role, style: AppTextStyles.body)),
          DataCell(Text(e.department, style: AppTextStyles.body)),
          DataCell(Text(e.joinDate, style: AppTextStyles.body)),
          DataCell(Text(
            e.salary,
            style: AppTextStyles.bodyDark.copyWith(fontWeight: FontWeight.w600),
          )),
          DataCell(
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppDims.pillRadius),
              ),
              child: Text(
                e.status,
                style: AppTextStyles.caption.copyWith(
                  color: statusColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ]);
      }).toList(),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });
  final String label, value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDims.cardRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: AppTextStyles.h2.copyWith(color: color)),
              Text(label, style: AppTextStyles.caption),
            ],
          ),
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.add_rounded, size: 18),
      label: const Text('Add Employee'),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryPurple,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDims.pillRadius),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}