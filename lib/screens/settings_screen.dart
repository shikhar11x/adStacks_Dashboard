import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _emailNotifications = true;
  bool _pushNotifications = false;
  bool _smsNotifications = true;
  bool _darkMode = false;
  bool _twoFactor = false;
  String _language = 'English';

  final _nameController = TextEditingController(text: 'Pooja Mishra');
  final _emailController = TextEditingController(text: 'pooja@adstacks.in');
  final _phoneController = TextEditingController(text: '+91 98765 43210');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 600;
          if (isNarrow) {
            return Column(children: [
              _buildProfileCard(),
              const SizedBox(height: AppDims.gapLg),
              _buildNotificationSettings(),
              const SizedBox(height: AppDims.gapLg),
              _buildAppPreferences(),
              const SizedBox(height: AppDims.gapLg),
              _buildSecuritySettings(),
            ]);
          }
          return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(child: Column(children: [
              _buildProfileCard(),
              const SizedBox(height: AppDims.gapLg),
              _buildSecuritySettings(),
            ])),
            const SizedBox(width: AppDims.gapLg),
            Expanded(child: Column(children: [
              _buildNotificationSettings(),
              const SizedBox(height: AppDims.gapLg),
              _buildAppPreferences(),
            ])),
          ]);
        }),
        const SizedBox(height: AppDims.gapLg),
        _buildSaveButton(),
      ],
    );
  }

  Widget _buildProfileCard() {
    return _SettingsCard(
      title: 'Profile Settings',
      icon: Icons.person_rounded,
      child: Column(
        children: [
          // Avatar
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.primaryPurple.withValues(alpha: 0.15),
                  child: const Icon(Icons.person_rounded, size: 44, color: AppColors.primaryPurple),
                ),
                Positioned(
                  bottom: 0, right: 0,
                  child: Container(
                    width: 28, height: 28,
                    decoration: const BoxDecoration(color: AppColors.primaryPurple, shape: BoxShape.circle),
                    child: const Icon(Icons.camera_alt_rounded, size: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildTextField('Full Name', _nameController, Icons.badge_rounded),
          const SizedBox(height: 12),
          _buildTextField('Email Address', _emailController, Icons.email_rounded),
          const SizedBox(height: 12),
          _buildTextField('Phone Number', _phoneController, Icons.phone_rounded),
          const SizedBox(height: 12),
          // Department (dropdown)
          DropdownButtonFormField<String>(
            value: 'Management',
            decoration: InputDecoration(
              labelText: 'Department',
              prefixIcon: const Icon(Icons.business_rounded, size: 18),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            ),
            items: ['Management', 'Engineering', 'Creative', 'Sales', 'HR', 'Finance', 'Marketing']
                .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                .toList(),
            onChanged: (_) {},
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 18),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      ),
    );
  }

  Widget _buildNotificationSettings() {
    return _SettingsCard(
      title: 'Notifications',
      icon: Icons.notifications_rounded,
      child: Column(
        children: [
          _SwitchTile(
            label: 'Email Notifications',
            subtitle: 'Receive updates via email',
            value: _emailNotifications,
            onChanged: (v) => setState(() => _emailNotifications = v),
          ),
          const Divider(height: 1),
          _SwitchTile(
            label: 'Push Notifications',
            subtitle: 'In-app alerts and reminders',
            value: _pushNotifications,
            onChanged: (v) => setState(() => _pushNotifications = v),
          ),
          const Divider(height: 1),
          _SwitchTile(
            label: 'SMS Notifications',
            subtitle: 'Critical alerts via SMS',
            value: _smsNotifications,
            onChanged: (v) => setState(() => _smsNotifications = v),
          ),
        ],
      ),
    );
  }

  Widget _buildAppPreferences() {
    return _SettingsCard(
      title: 'App Preferences',
      icon: Icons.tune_rounded,
      child: Column(
        children: [
          _SwitchTile(
            label: 'Dark Mode',
            subtitle: 'Switch to dark theme',
            value: _darkMode,
            onChanged: (v) => setState(() => _darkMode = v),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(children: [
              const Icon(Icons.language_rounded, size: 20, color: AppColors.textSecondary),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Language', style: AppTextStyles.bodyDark.copyWith(fontWeight: FontWeight.w600)),
                Text('App display language', style: AppTextStyles.caption),
              ])),
              DropdownButton<String>(
                value: _language,
                underline: const SizedBox.shrink(),
                items: ['English', 'Hindi', 'Marathi']
                    .map((l) => DropdownMenuItem(value: l, child: Text(l, style: AppTextStyles.body)))
                    .toList(),
                onChanged: (v) => setState(() => _language = v!),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildSecuritySettings() {
    return _SettingsCard(
      title: 'Security',
      icon: Icons.security_rounded,
      child: Column(
        children: [
          _SwitchTile(
            label: 'Two-Factor Authentication',
            subtitle: 'Extra layer of login security',
            value: _twoFactor,
            onChanged: (v) => setState(() => _twoFactor = v),
          ),
          const Divider(height: 1),
          _ActionTile(
            label: 'Change Password',
            subtitle: 'Last changed 90 days ago',
            icon: Icons.lock_rounded,
            onTap: () {},
          ),
          const Divider(height: 1),
          _ActionTile(
            label: 'Active Sessions',
            subtitle: '2 devices logged in',
            icon: Icons.devices_rounded,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.primaryPurple),
            foregroundColor: AppColors.primaryPurple,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDims.pillRadius)),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          ),
          child: const Text('Cancel'),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryPurple,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDims.pillRadius)),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          ),
          child: const Text('Save Changes'),
        ),
      ],
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.title, required this.icon, required this.child});
  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDims.cardRadius),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(
              width: 36, height: 36,
              decoration: BoxDecoration(color: AppColors.primaryPurple.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: AppColors.primaryPurple, size: 18),
            ),
            const SizedBox(width: 12),
            Text(title, style: AppTextStyles.h3),
          ]),
          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  const _SwitchTile({required this.label, required this.subtitle, required this.value, required this.onChanged});
  final String label, subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: AppTextStyles.bodyDark.copyWith(fontWeight: FontWeight.w600)),
          Text(subtitle, style: AppTextStyles.caption),
        ])),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.primaryPurple,
        ),
      ]),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({required this.label, required this.subtitle, required this.icon, required this.onTap});
  final String label, subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(children: [
          Icon(icon, size: 20, color: AppColors.textSecondary),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label, style: AppTextStyles.bodyDark.copyWith(fontWeight: FontWeight.w600)),
            Text(subtitle, style: AppTextStyles.caption),
          ])),
          const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textSecondary),
        ]),
      ),
    );
  }
}