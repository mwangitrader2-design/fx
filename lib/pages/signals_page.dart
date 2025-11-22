import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SignalsPage extends StatefulWidget {
  const SignalsPage({super.key});

  @override
  State<SignalsPage> createState() => _SignalsPageState();
}

class _SignalsPageState extends State<SignalsPage> {
  String _filter = 'all';
  final Set<String> _expandedSignals = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signals'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildFilterChips(),
            const SizedBox(height: 16),
            _buildSignalCard(
              symbol: 'EURUSD',
              type: 'BUY',
              strength: 'Very Strong',
              confidence: 99.2,
              entry: 1.09450,
              stopLoss: 1.09250,
              takeProfit: 1.09850,
              timeframe: 'H4',
              confirmedOnLowerTF: true,
            ),
            _buildSignalCard(
              symbol: 'GBPUSD',
              type: 'SELL',
              strength: 'Strong',
              confidence: 97.5,
              entry: 1.26520,
              stopLoss: 1.26720,
              takeProfit: 1.26120,
              timeframe: 'H1',
              confirmedOnLowerTF: true,
            ),
            _buildSignalCard(
              symbol: 'USDJPY',
              type: 'BUY',
              strength: 'Strong',
              confidence: 96.8,
              entry: 148.520,
              stopLoss: 148.320,
              takeProfit: 148.920,
              timeframe: 'H4',
              confirmedOnLowerTF: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildFilterChip('All', 'all'),
          const SizedBox(width: 8),
          _buildFilterChip('Confirmed', 'confirmed'),
          const SizedBox(width: 8),
          _buildFilterChip('Pending', 'pending'),
          const SizedBox(width: 8),
          _buildFilterChip('Very Strong', 'very_strong'),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _filter == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _filter = value;
        });
      },
      selectedColor: AppTheme.primaryColor.withValues(alpha: 0.3),
      checkmarkColor: AppTheme.primaryColor,
    );
  }

  Widget _buildSignalCard({
    required String symbol,
    required String type,
    required String strength,
    required double confidence,
    required double entry,
    required double stopLoss,
    required double takeProfit,
    required String timeframe,
    required bool confirmedOnLowerTF,
  }) {
    final isBuy = type == 'BUY';
    final signalColor = isBuy ? AppTheme.successColor : AppTheme.errorColor;
    final signalId = '$symbol-$type-${entry.toString()}';
    final isExpanded = _expandedSignals.contains(signalId);

    // Get strength color
    Color strengthColor;
    switch (strength.toLowerCase()) {
      case 'very strong':
        strengthColor = AppTheme.successColor;
        break;
      case 'strong':
        strengthColor = AppTheme.primaryColor;
        break;
      default:
        strengthColor = AppTheme.warningColor;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          setState(() {
            if (isExpanded) {
              _expandedSignals.remove(signalId);
            } else {
              _expandedSignals.add(signalId);
            }
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Always visible: Header with symbol and signal type
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
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: AppTheme.textSecondaryColor,
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Always visible: Signal strength, confidence, and timeframe
              Row(
                children: [
                  Icon(Icons.bolt, size: 16, color: strengthColor),
                  const SizedBox(width: 6),
                  Text(
                    strength,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: strengthColor,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: strengthColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '${confidence.toStringAsFixed(1)}%',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: strengthColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppTheme.infoColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.access_time,
                            size: 12, color: AppTheme.infoColor),
                        const SizedBox(width: 4),
                        Text(
                          timeframe,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.infoColor,
                          ),
                        ),
                      ],
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

                    // Confirmation status
                    if (confirmedOnLowerTF)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.successColor
                                    .withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    size: 14,
                                    color: AppTheme.successColor,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'Confirmed on Lower Timeframe',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: AppTheme.successColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Price levels
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          _buildPriceRow('Entry', entry, Icons.input),
                          const Divider(height: 16),
                          _buildPriceRow('Stop Loss', stopLoss, Icons.shield),
                          const Divider(height: 16),
                          _buildPriceRow('Take Profit', takeProfit, Icons.flag),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Action buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.grey[700]!),
                            ),
                            child: const Text('Dismiss'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: signalColor,
                            ),
                            child: const Text('Execute Trade'),
                          ),
                        ),
                      ],
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

  Widget _buildPriceRow(String label, double price, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppTheme.textSecondaryColor),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.textSecondaryColor,
            fontSize: 13,
          ),
        ),
        const Spacer(),
        Text(
          price.toStringAsFixed(5),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Signals'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CheckboxListTile(
              title: const Text('Very Strong'),
              value: true,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: const Text('Strong'),
              value: true,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: const Text('Confirmed Only'),
              value: false,
              onChanged: (value) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }
}
