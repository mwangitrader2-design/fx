import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/mt5_service.dart';
import '../state/account_state.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final _mt5Service = MT5Service();
  final AccountState _accountState = AccountState.instance;
  Map<String, dynamic>? _accountInfo;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    final cachedInfo = _accountState.accountInfo;
    if (cachedInfo != null) {
      _accountInfo = cachedInfo;
      _isLoading = false;
    }
    _accountState.addListener(_handleAccountUpdate);
    _loadAccountInfo();
  }

  @override
  void dispose() {
    _accountState.removeListener(_handleAccountUpdate);
    super.dispose();
  }

  void _handleAccountUpdate() {
    if (!mounted) return;
    setState(() {
      _accountInfo = _accountState.accountInfo;
    });
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
        final data = result['data'] as Map<String, dynamic>?;
        if (data != null) {
          _accountState.updateFromAccountInfo(Map<String, dynamic>.from(data));
        }
      } else {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Portfolio'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadAccountInfo,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadAccountInfo,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBalanceCard(),
              const SizedBox(height: 24),
              _buildPerformanceStats(),
              const SizedBox(height: 24),
              _buildAccountDetails(),
              const SizedBox(height: 24),
              _buildRiskMetrics(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    final balance = _accountInfo?['balance']?.toDouble() ?? 0.0;
    final equity = _accountInfo?['equity']?.toDouble() ?? 0.0;
    final profit = _accountInfo?['profit']?.toDouble() ?? 0.0;
    final currency = _accountInfo?['currency'] ?? 'USD';
    final isConnected = _accountInfo != null;

    // Calculate growth percentage
    final growthPercent = balance > 0 ? (profit / balance) * 100 : 0.0;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: AppTheme.primaryGradientDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'MT5 Account Equity',
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
          _isLoading
              ? const SizedBox(
                  height: 44,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  ),
                )
              : Text(
                  isConnected
                      ? '\$$currency ${equity.toStringAsFixed(2)}'
                      : '\$0.00',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildBalanceItem(
                  'Balance',
                  isConnected
                      ? '\$$currency ${balance.toStringAsFixed(2)}'
                      : '\$0.00',
                ),
              ),
              Expanded(
                child: _buildBalanceItem(
                  'Profit/Loss',
                  isConnected
                      ? '${profit >= 0 ? '+' : ''}\$$currency ${profit.toStringAsFixed(2)}'
                      : '\$0.00',
                ),
              ),
              Expanded(
                child: _buildBalanceItem(
                  'Growth',
                  isConnected
                      ? '${growthPercent >= 0 ? '+' : ''}${growthPercent.toStringAsFixed(2)}%'
                      : '0.00%',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white60,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildPerformanceStats() {
    final balance = _accountInfo?['balance']?.toDouble() ?? 0.0;
    final equity = _accountInfo?['equity']?.toDouble() ?? 0.0;
    final profit = _accountInfo?['profit']?.toDouble() ?? 0.0;
    final marginFree = _accountInfo?['margin_free']?.toDouble() ?? 0.0;
    final isConnected = _accountInfo != null;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Account Performance',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildStatRow(
              'Balance',
              isConnected ? '\$${balance.toStringAsFixed(2)}' : 'N/A',
              AppTheme.infoColor,
            ),
            const SizedBox(height: 12),
            _buildStatRow(
              'Equity',
              isConnected ? '\$${equity.toStringAsFixed(2)}' : 'N/A',
              AppTheme.successColor,
            ),
            const SizedBox(height: 12),
            _buildStatRow(
              'Floating P/L',
              isConnected
                  ? '${profit >= 0 ? '+' : ''}\$${profit.toStringAsFixed(2)}'
                  : 'N/A',
              profit >= 0 ? AppTheme.successColor : AppTheme.errorColor,
            ),
            const SizedBox(height: 12),
            _buildStatRow(
              'Free Margin',
              isConnected ? '\$${marginFree.toStringAsFixed(2)}' : 'N/A',
              AppTheme.successColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountDetails() {
    final login = _accountInfo?['login']?.toString() ?? 'N/A';
    final server = _accountInfo?['server']?.toString() ?? 'N/A';
    final name = _accountInfo?['name']?.toString() ?? 'N/A';
    final company = _accountInfo?['company']?.toString() ?? 'N/A';
    final leverage = _accountInfo?['leverage']?.toString() ?? 'N/A';
    final currency = _accountInfo?['currency']?.toString() ?? 'N/A';
    final isConnected = _accountInfo != null;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Account Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatBox(
                      'Account', isConnected ? login : 'Not Connected'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatBox(
                      'Leverage', isConnected ? '1:$leverage' : 'N/A'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildStatBox('Server', isConnected ? server : 'N/A'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child:
                      _buildStatBox('Currency', isConnected ? currency : 'N/A'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildStatBox('Name', isConnected ? name : 'N/A'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatBox('Broker', isConnected ? company : 'N/A'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRiskMetrics() {
    final margin = _accountInfo?['margin']?.toDouble() ?? 0.0;
    final marginLevel = _accountInfo?['margin_level']?.toDouble() ?? 0.0;
    final equity = _accountInfo?['equity']?.toDouble() ?? 0.0;
    final balance = _accountInfo?['balance']?.toDouble() ?? 0.0;
    final isConnected = _accountInfo != null;

    // Calculate exposure (margin used as percentage of equity)
    final exposure = equity > 0 ? (margin / equity) * 100 : 0.0;

    // Calculate drawdown (difference between balance and equity as percentage)
    final drawdown = balance > 0 ? ((balance - equity) / balance) * 100 : 0.0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Risk Metrics',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildStatRow(
              'Margin Used',
              isConnected ? '\$${margin.toStringAsFixed(2)}' : 'N/A',
              margin > 0 ? AppTheme.warningColor : AppTheme.successColor,
            ),
            const SizedBox(height: 12),
            _buildStatRow(
              'Margin Level',
              isConnected ? '${marginLevel.toStringAsFixed(0)}%' : 'N/A',
              marginLevel > 100 ? AppTheme.successColor : AppTheme.errorColor,
            ),
            const SizedBox(height: 12),
            _buildStatRow(
              'Current Exposure',
              isConnected ? '${exposure.toStringAsFixed(2)}%' : 'N/A',
              exposure < 50 ? AppTheme.successColor : AppTheme.warningColor,
            ),
            const SizedBox(height: 12),
            _buildStatRow(
              'Current Drawdown',
              isConnected ? '${drawdown.abs().toStringAsFixed(2)}%' : 'N/A',
              drawdown < 5 ? AppTheme.successColor : AppTheme.warningColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.textSecondaryColor,
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildStatBox(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppTheme.textMutedColor,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
