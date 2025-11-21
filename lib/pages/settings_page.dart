import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'profile_page.dart';
import 'broker_connection_page.dart';
import 'subscription_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _autoTrading = true;
  bool _pushNotifications = true;
  bool _emailNotifications = false;
  double _riskPercentage = 2.0;
  int _maxOpenTrades = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            'Trading Settings',
            [
              _buildSwitchTile(
                'Auto Trading',
                'Automatically execute confirmed signals',
                _autoTrading,
                (value) => setState(() => _autoTrading = value),
              ),
              _buildSliderTile(
                'Risk Per Trade',
                '${_riskPercentage.toStringAsFixed(1)}%',
                _riskPercentage,
                1.0,
                5.0,
                (value) => setState(() => _riskPercentage = value),
              ),
              _buildSliderTile(
                'Max Open Trades',
                _maxOpenTrades.toString(),
                _maxOpenTrades.toDouble(),
                1.0,
                10.0,
                (value) => setState(() => _maxOpenTrades = value.round()),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            'Notifications',
            [
              _buildSwitchTile(
                'Push Notifications',
                'Get notified about signals and trades',
                _pushNotifications,
                (value) => setState(() => _pushNotifications = value),
              ),
              _buildSwitchTile(
                'Email Notifications',
                'Receive email alerts',
                _emailNotifications,
                (value) => setState(() => _emailNotifications = value),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            'Account',
            [
              _buildListTile(
                'Profile',
                Icons.person_outline,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ),
                  );
                },
              ),
              _buildListTile(
                'Broker Connection',
                Icons.link,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BrokerConnectionPage(),
                    ),
                  );
                },
              ),
              _buildListTile(
                'Subscription',
                Icons.star_outline,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SubscriptionPage(),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.errorColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Logout'),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 12),
      ),
      value: value,
      onChanged: onChanged,
      activeColor: AppTheme.primaryColor,
    );
  }

  Widget _buildSliderTile(
    String title,
    String value,
    double currentValue,
    double min,
    double max,
    ValueChanged<double> onChanged,
  ) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryColor,
            ),
          ),
        ],
      ),
      subtitle: Slider(
        value: currentValue,
        min: min,
        max: max,
        divisions: ((max - min) * (title.contains('Risk') ? 10 : 1)).round(),
        activeColor: AppTheme.primaryColor,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildListTile(
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryColor),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
