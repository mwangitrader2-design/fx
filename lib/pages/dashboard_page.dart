import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/stat_card.dart';
import '../widgets/portfolio_chart.dart';
import '../widgets/active_trades_card.dart';
import '../widgets/recent_signals_list.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
          await Future.delayed(const Duration(milliseconds: 500));
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          cacheExtent: 1000,
          children: const [
            _PortfolioOverview(),
            SizedBox(height: 24),
            _StatsGrid(),
            SizedBox(height: 24),
            _PortfolioChartSection(),
            SizedBox(height: 24),
            _ActiveTradesSection(),
            SizedBox(height: 24),
            _RecentSignalsSection(),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _PortfolioOverview extends StatelessWidget {
  const _PortfolioOverview();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
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
                    color: Colors.white24,
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
      ),
    );
  }
}

class _StatsGrid extends StatelessWidget {
  const _StatsGrid();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: GridView.count(
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
      ),
    );
  }
}

class _PortfolioChartSection extends StatelessWidget {
  const _PortfolioChartSection();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Card(
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
                    value: '1W',
                    items: const [
                      DropdownMenuItem(value: '24H', child: Text('24H')),
                      DropdownMenuItem(value: '1W', child: Text('1W')),
                      DropdownMenuItem(value: '1M', child: Text('1M')),
                      DropdownMenuItem(value: '3M', child: Text('3M')),
                      DropdownMenuItem(value: '6M', child: Text('6M')),
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
      ),
    );
  }
}

class _ActiveTradesSection extends StatelessWidget {
  const _ActiveTradesSection();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Column(
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
      ),
    );
  }
}

class _RecentSignalsSection extends StatelessWidget {
  const _RecentSignalsSection();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Column(
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
      ),
    );
  }
}
