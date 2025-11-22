import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/mt5_service.dart';

class TradesPage extends StatefulWidget {
  const TradesPage({super.key});

  @override
  State<TradesPage> createState() => _TradesPageState();
}

class _TradesPageState extends State<TradesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Set<String> _expandedTrades = {};
  final Set<String> _closingTrades = {};
  final MT5Service _mt5Service = MT5Service();

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
            ticket: '12345678',
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
            ticket: '12345679',
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
    required String ticket,
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
    final tradeId = '$symbol-$type-${openedAt.millisecondsSinceEpoch}';
    final isExpanded = _expandedTrades.contains(tradeId);
    final pips = ((current - entry) * (isBuy ? 1 : -1) * 10000).abs();

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          setState(() {
            if (isExpanded) {
              _expandedTrades.remove(tradeId);
            } else {
              _expandedTrades.add(tradeId);
            }
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Always visible: Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: signalColor.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          type,
                          style: TextStyle(
                            color: signalColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        symbol,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
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
                            '${pips.toStringAsFixed(1)} pips',
                            style: TextStyle(
                              color: isProfit
                                  ? AppTheme.successColor
                                  : AppTheme.errorColor,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        isExpanded ? Icons.expand_less : Icons.expand_more,
                        color: AppTheme.textSecondaryColor,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Always visible: Basic info
              Row(
                children: [
                  Expanded(
                    child: _buildCompactInfo(
                      'Entry',
                      entry.toStringAsFixed(5),
                    ),
                  ),
                  Expanded(
                    child: _buildCompactInfo(
                      'Current',
                      current.toStringAsFixed(5),
                    ),
                  ),
                  Expanded(
                    child: _buildCompactInfo(
                      'Lot',
                      lotSize.toString(),
                    ),
                  ),
                ],
              ),

              // Expandable section
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Column(
                  children: [
                    const SizedBox(height: 16),
                    const Divider(height: 1),
                    const SizedBox(height: 16),

                    // Detailed info
                    Row(
                      children: [
                        Expanded(
                          child: _buildDetailedInfo(
                            'Stop Loss',
                            stopLoss.toStringAsFixed(5),
                            Icons.trending_down,
                            AppTheme.errorColor,
                          ),
                        ),
                        Expanded(
                          child: _buildDetailedInfo(
                            'Take Profit',
                            takeProfit.toStringAsFixed(5),
                            Icons.trending_up,
                            AppTheme.successColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Progress bar
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Progress to Target',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppTheme.textMutedColor,
                              ),
                            ),
                            Text(
                              '${(_calculateProgress(entry, current, stopLoss, takeProfit, isBuy) * 100).toStringAsFixed(0)}%',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isProfit
                                    ? AppTheme.successColor
                                    : AppTheme.errorColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: _calculateProgress(
                                entry, current, stopLoss, takeProfit, isBuy),
                            backgroundColor: Colors.grey[800],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              isProfit
                                  ? AppTheme.successColor
                                  : AppTheme.errorColor,
                            ),
                            minHeight: 8,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Time and profit details
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Opened',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: AppTheme.textMutedColor,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${_formatDuration(DateTime.now().difference(openedAt))} ago',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Profit %',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: AppTheme.textMutedColor,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${isProfit ? '+' : ''}${profitPercent.toStringAsFixed(2)}%',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: isProfit
                                        ? AppTheme.successColor
                                        : AppTheme.errorColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Close trade button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _closingTrades.contains(ticket)
                            ? null
                            : () => _showCloseTradeDialog(
                                ticket, symbol, type, profit),
                        icon: _closingTrades.contains(ticket)
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )
                            : const Icon(Icons.close, size: 18),
                        label: Text(_closingTrades.contains(ticket)
                            ? 'Closing...'
                            : 'Close Trade'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.errorColor,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                crossFadeState: isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
              ),
            ],
          ),
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
    final tradeId = '$symbol-$type-${closedAt.millisecondsSinceEpoch}';
    final isExpanded = _expandedTrades.contains(tradeId);
    final pips = ((exit - entry) * (isBuy ? 1 : -1) * 10000).abs();

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          setState(() {
            if (isExpanded) {
              _expandedTrades.remove(tradeId);
            } else {
              _expandedTrades.add(tradeId);
            }
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Always visible: Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: signalColor.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          type,
                          style: TextStyle(
                            color: signalColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        symbol,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
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
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        isExpanded ? Icons.expand_less : Icons.expand_more,
                        color: AppTheme.textSecondaryColor,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Always visible: Basic info
              Row(
                children: [
                  Expanded(
                    child: _buildCompactInfo(
                      'Entry',
                      entry.toStringAsFixed(5),
                    ),
                  ),
                  Expanded(
                    child: _buildCompactInfo(
                      'Exit',
                      exit.toStringAsFixed(5),
                    ),
                  ),
                  Expanded(
                    child: _buildCompactInfo(
                      'Pips',
                      pips.toStringAsFixed(1),
                    ),
                  ),
                ],
              ),

              // Expandable section
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Column(
                  children: [
                    const SizedBox(height: 16),
                    const Divider(height: 1),
                    const SizedBox(height: 16),

                    // Detailed info
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Trade Duration',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.textMutedColor,
                                ),
                              ),
                              Text(
                                _formatDuration(duration),
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Closed',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.textMutedColor,
                                ),
                              ),
                              Text(
                                _formatDateTime(closedAt),
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Price Movement',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.textMutedColor,
                                ),
                              ),
                              Text(
                                '${((exit - entry) * (isBuy ? 1 : -1) * 10000).toStringAsFixed(1)} pips',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: isProfit
                                      ? AppTheme.successColor
                                      : AppTheme.errorColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                crossFadeState: isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompactInfo(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: AppTheme.textMutedColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailedInfo(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: AppTheme.textMutedColor,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
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

  Future<void> _showCloseTradeDialog(
    String ticket,
    String symbol,
    String type,
    double currentProfit,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Close Trade'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Are you sure you want to close this trade?',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Symbol:',
                        style: TextStyle(
                          color: AppTheme.textMutedColor,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '$symbol ($type)',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Current P/L:',
                        style: TextStyle(
                          color: AppTheme.textMutedColor,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '${currentProfit >= 0 ? '+' : ''}\$${currentProfit.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: currentProfit >= 0
                              ? AppTheme.successColor
                              : AppTheme.errorColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Ticket:',
                        style: TextStyle(
                          color: AppTheme.textMutedColor,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '#$ticket',
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.errorColor,
            ),
            child: const Text('Close Trade'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await _closeTrade(ticket, symbol);
    }
  }

  Future<void> _closeTrade(String ticket, String symbol) async {
    setState(() {
      _closingTrades.add(ticket);
    });

    try {
      final result = await _mt5Service.closePosition(ticket);

      if (!mounted) return;

      if (result['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Trade Closed',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '$symbol position #$ticket closed successfully',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            backgroundColor: AppTheme.successColor,
            duration: const Duration(seconds: 4),
            behavior: SnackBarBehavior.floating,
          ),
        );

        // TODO: Refresh trades list here
        setState(() {});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Failed to Close Trade',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        result['message'] ?? 'Unknown error occurred',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            backgroundColor: AppTheme.errorColor,
            duration: const Duration(seconds: 5),
            behavior: SnackBarBehavior.floating,
            action: SnackBarAction(
              label: 'Retry',
              textColor: Colors.white,
              onPressed: () => _closeTrade(ticket, symbol),
            ),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Error',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Connection error: $e',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          backgroundColor: AppTheme.errorColor,
          duration: const Duration(seconds: 5),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _closingTrades.remove(ticket);
        });
      }
    }
  }
}
