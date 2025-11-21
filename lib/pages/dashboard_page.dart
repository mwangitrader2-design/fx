import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/stat_card.dart';
import '../widgets/portfolio_chart.dart';
import '../widgets/active_trades_card.dart';
import '../widgets/recent_signals_list.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Refresh data
          await Future.delayed(const Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Portfolio Overview
              _buildPortfolioOverview(),
              const SizedBox(height: 24),

              // Stats Grid
              _buildStatsGrid(),
              const SizedBox(height: 24),

              // Portfolio Chart
              _buildPortfolioChart(),
              const SizedBox(height: 24),

              // Active Trades
              _buildActiveTradesSection(),
              const SizedBox(height: 24),

              // Recent Signals
              _buildRecentSignalsSection(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPortfolioOverview() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.primaryGradientDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total Balance',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '\$125,450.00',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.trending_up,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 4),
              const Text(
                '+12.5% (\$13,950)',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Last 30 days',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: const [
        StatCard(
          title: 'Win Rate',
          value: '87.5%',
          icon: Icons.check_circle_outline,
          color: AppTheme.successColor,
          trend: '+2.3%',
        ),
        StatCard(
          title: 'Active Signals',
          value: '12',
          icon: Icons.flash_on,
          color: AppTheme.primaryColor,
          trend: '+3',
        ),
        StatCard(
          title: 'Open Trades',
          value: '8',
          icon: Icons.swap_horiz,
          color: AppTheme.infoColor,
          trend: '0',
        ),
        StatCard(
          title: 'Profit Today',
          value: '\$2,450',
          icon: Icons.attach_money,
          color: AppTheme.successColor,
          trend: '+15.2%',
        ),
      ],
    );
  }

  Widget _buildPortfolioChart() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Portfolio Growth',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                DropdownButton<String>(
                  value: '7D',
                  items: const [
                    DropdownMenuItem(value: '24H', child: Text('24H')),
                    DropdownMenuItem(value: '7D', child: Text('7D')),
                    DropdownMenuItem(value: '30D', child: Text('30D')),
                    DropdownMenuItem(value: '1Y', child: Text('1Y')),
                  ],
                  onChanged: (value) {},
                  underline: const SizedBox(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const SizedBox(
              height: 200,
              child: PortfolioChart(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveTradesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Active Trades',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const ActiveTradesCard(),
      ],
    );
  }

  Widget _buildRecentSignalsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Signals',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const RecentSignalsList(),
      ],
    );
  }
}
