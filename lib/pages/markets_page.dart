import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class MarketsPage extends StatefulWidget {
  const MarketsPage({super.key});

  @override
  State<MarketsPage> createState() => _MarketsPageState();
}

class _MarketsPageState extends State<MarketsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
        title: const Text('Markets'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.primaryColor,
          tabs: const [
            Tab(text: 'Majors'),
            Tab(text: 'Minors'),
            Tab(text: 'Exotics'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMarketList(_majorPairs),
          _buildMarketList(_minorPairs),
          _buildMarketList(_exoticPairs),
        ],
      ),
    );
  }

  Widget _buildMarketList(List<Map<String, dynamic>> pairs) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: pairs.length,
        itemBuilder: (context, index) {
          final pair = pairs[index];
          return _buildMarketCard(pair);
        },
      ),
    );
  }

  Widget _buildMarketCard(Map<String, dynamic> pair) {
    final isPositive = pair['change'] >= 0;

    return RepaintBoundary(
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: InkWell(
          onTap: () {
            // Navigate to market details
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      pair['symbol'].substring(0, 3),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pair['symbol'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        pair['name'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      pair['price'].toStringAsFixed(5),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: isPositive
                            ? AppTheme.successColor.withValues(alpha: 0.2)
                            : AppTheme.errorColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isPositive
                                ? Icons.arrow_upward
                                : Icons.arrow_downward,
                            size: 12,
                            color: isPositive
                                ? AppTheme.successColor
                                : AppTheme.errorColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${isPositive ? '+' : ''}${pair['change'].toStringAsFixed(2)}%',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isPositive
                                  ? AppTheme.successColor
                                  : AppTheme.errorColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final List<Map<String, dynamic>> _majorPairs = [
    {
      'symbol': 'EURUSD',
      'name': 'Euro vs US Dollar',
      'price': 1.09450,
      'change': 0.45,
    },
    {
      'symbol': 'GBPUSD',
      'name': 'British Pound vs US Dollar',
      'price': 1.26520,
      'change': -0.23,
    },
    {
      'symbol': 'USDJPY',
      'name': 'US Dollar vs Japanese Yen',
      'price': 148.520,
      'change': 0.67,
    },
    {
      'symbol': 'AUDUSD',
      'name': 'Australian Dollar vs US Dollar',
      'price': 0.65510,
      'change': 0.12,
    },
  ];

  final List<Map<String, dynamic>> _minorPairs = [
    {
      'symbol': 'EURGBP',
      'name': 'Euro vs British Pound',
      'price': 0.86520,
      'change': 0.15,
    },
    {
      'symbol': 'EURJPY',
      'name': 'Euro vs Japanese Yen',
      'price': 162.450,
      'change': -0.34,
    },
  ];

  final List<Map<String, dynamic>> _exoticPairs = [
    {
      'symbol': 'USDTRY',
      'name': 'US Dollar vs Turkish Lira',
      'price': 32.4520,
      'change': 1.25,
    },
    {
      'symbol': 'USDZAR',
      'name': 'US Dollar vs South African Rand',
      'price': 18.5420,
      'change': -0.45,
    },
  ];
}
