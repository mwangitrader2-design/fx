import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TradesPage extends StatefulWidget {
  const TradesPage({super.key});

  @override
  State<TradesPage> createState() => _TradesPageState();
}

class _TradesPageState extends State<TradesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trades'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.primaryColor,
          tabs: const [
            Tab(text: 'Active'),
            Tab(text: 'History'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildActiveTrades(),
          _buildTradeHistory(),
        ],
      ),
    );
  }

  Widget _buildActiveTrades() {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildActiveTradeCard(
            symbol: 'EURUSD',
            type: 'BUY',
            entry: 1.09250,
            current: 1.09450,
            stopLoss: 1.09050,
            takeProfit: 1.09650,
            lotSize: 0.5,
            profit: 100.00,
            profitPercent: 1.83,
            openedAt: DateTime.now().subtract(const Duration(hours: 2)),
          ),
          _buildActiveTradeCard(
            symbol: 'GBPUSD',
            type: 'SELL',
            entry: 1.26720,
            current: 1.26520,
            stopLoss: 1.26920,
            takeProfit: 1.26320,
            lotSize: 0.3,
            profit: 60.00,
            profitPercent: 1.58,
            openedAt: DateTime.now().subtract(const Duration(hours: 5)),
          ),
        ],
      ),
    );
  }

  Widget _buildTradeHistory() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildHistoryTradeCard(
          symbol: 'USDJPY',
          type: 'BUY',
          entry: 148.250,
          exit: 148.650,
          profit: 200.00,
          profitPercent: 2.70,
          closedAt: DateTime.now().subtract(const Duration(days: 1)),
          duration: const Duration(hours: 8),
        ),
        _buildHistoryTradeCard(
            symbol: 'AUDUSD',
            type: 'SELL',
            entry: 0.65720,
            exit: 0.65580,
            profit: 70.00,
            profitPercent: 2.13,
            closedAt: DateTime.now().subtract(const Duration(days: 2)),
            duration: const Duration(hours: 3)),
      ],
    );
  }

  Widget _buildActiveTradeCard({
    required String symbol,
    required String type,
    required double entry,
    required double current,
    required double stopLoss,
    required double takeProfit,
    required double lotSize,
    required double profit,
    required double profitPercent,
    required DateTime openedAt,
  }) {
    final isBuy = type == 'BUY';
    final isProfit = profit >= 0;
    final signalColor = isBuy ? AppTheme.successColor : AppTheme.errorColor;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: signalColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        type,
                        style: TextStyle(
                          color: signalColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      symbol,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color:
                        (isProfit ? AppTheme.successColor : AppTheme.errorColor)
                            .withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${isProfit ? '+' : ''}\$${profit.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: isProfit
                          ? AppTheme.successColor
                          : AppTheme.errorColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildTradeInfo('Entry', entry.toStringAsFixed(5)),
                ),
                Expanded(
                  child: _buildTradeInfo('Current', current.toStringAsFixed(5)),
                ),
                Expanded(
                  child: _buildTradeInfo('Lot', lotSize.toString()),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child:
                      _buildTradeInfo('Stop Loss', stopLoss.toStringAsFixed(5)),
                ),
                Expanded(
                  child: _buildTradeInfo(
                      'Take Profit', takeProfit.toStringAsFixed(5)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: _calculateProgress(
                  entry, current, stopLoss, takeProfit, isBuy),
              backgroundColor: Colors.grey[800],
              valueColor: AlwaysStoppedAnimation<Color>(
                isProfit ? AppTheme.successColor : AppTheme.errorColor,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Opened ${_formatDuration(DateTime.now().difference(openedAt))} ago',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textMutedColor,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.errorColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                  child: const Text('Close Trade'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryTradeCard({
    required String symbol,
    required String type,
    required double entry,
    required double exit,
    required double profit,
    required double profitPercent,
    required DateTime closedAt,
    required Duration duration,
  }) {
    final isBuy = type == 'BUY';
    final isProfit = profit >= 0;
    final signalColor = isBuy ? AppTheme.successColor : AppTheme.errorColor;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: signalColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        type,
                        style: TextStyle(
                          color: signalColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      symbol,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${isProfit ? '+' : ''}\$${profit.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: isProfit
                            ? AppTheme.successColor
                            : AppTheme.errorColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '${isProfit ? '+' : ''}${profitPercent.toStringAsFixed(2)}%',
                      style: TextStyle(
                        color: isProfit
                            ? AppTheme.successColor
                            : AppTheme.errorColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildTradeInfo('Entry', entry.toStringAsFixed(5)),
                ),
                Expanded(
                  child: _buildTradeInfo('Exit', exit.toStringAsFixed(5)),
                ),
                Expanded(
                  child: _buildTradeInfo('Duration', _formatDuration(duration)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Closed ${_formatDateTime(closedAt)}',
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.textMutedColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTradeInfo(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.textMutedColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  double _calculateProgress(
    double entry,
    double current,
    double stopLoss,
    double takeProfit,
    bool isBuy,
  ) {
    if (isBuy) {
      final range = takeProfit - stopLoss;
      final progress = current - stopLoss;
      return (progress / range).clamp(0.0, 1.0);
    } else {
      final range = stopLoss - takeProfit;
      final progress = stopLoss - current;
      return (progress / range).clamp(0.0, 1.0);
    }
  }

  String _formatDuration(Duration duration) {
    if (duration.inDays > 0) {
      return '${duration.inDays}d';
    } else if (duration.inHours > 0) {
      return '${duration.inHours}h';
    } else {
      return '${duration.inMinutes}m';
    }
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else {
      return '${difference.inDays} days ago';
    }
  }
}
