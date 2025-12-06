import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/stat_card.dart';
import '../widgets/portfolio_chart.dart';
import '../widgets/active_trades_card.dart';
import '../widgets/recent_signals_list.dart';
import '../services/mt5_service.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with AutomaticKeepAliveClientMixin {
  final _mt5Service = MT5Service();
  final User? _currentUser = FirebaseAuth.instance.currentUser;
  Map<String, dynamic>? _accountInfo;
  bool _isLoading = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadAccountInfo();
  }

  Future<void> _loadAccountInfo() async {
    setState(() => _isLoading = true);

    try {
      final result = await _mt5Service.getAccountInfo();
      if (mounted && result['success'] == true) {
        setState(() {
          _accountInfo = result['data'];
          _isLoading = false;
        });
      } else {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

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
        onRefresh: _loadAccountInfo,
        child: ListView(
          padding: const EdgeInsets.all(16),
          cacheExtent: 1000,
          children: [
            _WelcomeHeader(displayName: _currentUser?.displayName),
            const SizedBox(height: 16),
            _PortfolioOverview(
              accountInfo: _accountInfo,
              isLoading: _isLoading,
            ),
            const SizedBox(height: 24),
            _StatsGrid(accountInfo: _accountInfo),
            const SizedBox(height: 24),
            const _PortfolioChartSection(),
            const SizedBox(height: 24),
            const _ActiveTradesSection(),
            const SizedBox(height: 24),
            const _RecentSignalsSection(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _WelcomeHeader extends StatelessWidget {
  final String? displayName;

  const _WelcomeHeader({this.displayName});

  @override
  Widget build(BuildContext context) {
    final greetingName = displayName?.trim().isNotEmpty == true
        ? displayName!
        : 'Trader';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome back, $greetingName',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Here is today\'s market overview.',
          style: TextStyle(
            fontSize: 14,
            color: AppTheme.textSecondaryColor,
          ),
        ),
      ],
    );
  }
}

class _PortfolioOverview extends StatelessWidget {
  final Map<String, dynamic>? accountInfo;
  final bool isLoading;

  const _PortfolioOverview({
    this.accountInfo,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final balance = accountInfo?['balance']?.toDouble() ?? 0.0;
    final equity = accountInfo?['equity']?.toDouble() ?? 0.0;
    final profit = accountInfo?['profit']?.toDouble() ?? 0.0;
    final currency = accountInfo?['currency'] ?? 'USD';
    final isConnected = accountInfo != null;

    return RepaintBoundary(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: AppTheme.primaryGradientDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'MT5 Account Balance',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                if (!isConnected)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Not Connected',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            isLoading
                ? const SizedBox(
                    height: 40,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                  )
                : Text(
                    isConnected
                        ? '\$$currency ${balance.toStringAsFixed(2)}'
                        : '\$0.00',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  profit >= 0 ? Icons.trending_up : Icons.trending_down,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 4),
                Text(
                  isConnected
                      ? '${profit >= 0 ? '+' : ''}${profit.toStringAsFixed(2)} (Equity: ${equity.toStringAsFixed(2)})'
                      : 'Connect MT5 to view balance',
                  style: const TextStyle(
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
  final Map<String, dynamic>? accountInfo;

  const _StatsGrid({this.accountInfo});

  @override
  Widget build(BuildContext context) {
    final equity = accountInfo?['equity']?.toDouble() ?? 0.0;
    final margin = accountInfo?['margin']?.toDouble() ?? 0.0;
    final marginFree = accountInfo?['margin_free']?.toDouble() ?? 0.0;
    final marginLevel = accountInfo?['margin_level']?.toDouble() ?? 0.0;
    final profit = accountInfo?['profit']?.toDouble() ?? 0.0;
    final leverage = accountInfo?['leverage'] ?? 0;

    return RepaintBoundary(
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.5,
        children: [
          StatCard(
            title: 'Equity',
            value: '\$${equity.toStringAsFixed(2)}',
            icon: Icons.account_balance_wallet,
            color: AppTheme.successColor,
            trend: profit >= 0
                ? '+${profit.toStringAsFixed(2)}'
                : profit.toStringAsFixed(2),
          ),
          StatCard(
            title: 'Leverage',
            value: '1:$leverage',
            icon: Icons.flash_on,
            color: AppTheme.primaryColor,
            trend: '',
          ),
          StatCard(
            title: 'Free Margin',
            value: '\$${marginFree.toStringAsFixed(2)}',
            icon: Icons.savings,
            color: AppTheme.infoColor,
            trend: '',
          ),
          StatCard(
            title: 'Margin Level',
            value: '${marginLevel.toStringAsFixed(0)}%',
            icon: Icons.trending_up,
            color:
                marginLevel > 100 ? AppTheme.successColor : AppTheme.errorColor,
            trend: margin > 0 ? 'Used: \$${margin.toStringAsFixed(2)}' : '',
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
