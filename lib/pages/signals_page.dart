import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/services.dart';
import '../models/models.dart';

class SignalsPage extends StatefulWidget {
  const SignalsPage({super.key});

  @override
  State<SignalsPage> createState() => _SignalsPageState();
}

class _SignalsPageState extends State<SignalsPage> {
  String _filter = 'all';
  final Set<String> _expandedSignals = {};
  final AISignalGenerator _signalGenerator = AISignalGenerator();
  final MT5Service _mt5Service = MT5Service();

  List<TradingSignal> _signals = [];
  bool _isLoading = false;
  bool _isInitialLoad = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadSignals();
  }

  Future<void> _loadSignals() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Check MT5 connection first
      final connectionStatus = await _mt5Service.testConnection(
        username: '506933', // Replace with actual username
        password: 'Mare-Dewy-09', // Replace with actual password
        server: 'EGMSecurities-Demo', // Replace with actual server
      );
      if (!connectionStatus['success']) {
        throw Exception('MT5 not connected. Please login first.');
      }

      // Generate signals for major currency pairs
      final symbols = [
        'EURUSD',
        'GBPUSD',
        'USDJPY',
        'AUDUSD',
        'USDCAD',
        'NZDUSD'
      ];
      final List<TradingSignal> generatedSignals = [];

      for (final symbol in symbols) {
        try {
          print('🔍 Analyzing $symbol...');
          final signal = await _signalGenerator.generateSignalFromMT5(
            symbol: symbol,
            primaryTimeframe: TimeframeType.H1,
            additionalTimeframes: [
              TimeframeType.M15,
              TimeframeType.H1,
              TimeframeType.H4,
              TimeframeType.D1,
            ],
          );

          if (signal != null) {
            print(
                '✅ Signal generated for $symbol: ${signal.type} (${(signal.confidenceScore * 100).toStringAsFixed(1)}%)');
            generatedSignals.add(signal);
          } else {
            print(
                '⚠️ No signal for $symbol (confidence too low or HOLD recommendation)');
          }
        } catch (e) {
          print('❌ Error generating signal for $symbol: $e');
          // Continue with other symbols
        }
      }

      print(
          '\n📊 Signal generation complete: ${generatedSignals.length} signals found\n');

      setState(() {
        _signals = generatedSignals;
        _isLoading = false;
        _isInitialLoad = false;
        if (generatedSignals.isEmpty) {
          _errorMessage =
              'No signals found. Market conditions may not be favorable right now.\nPull to refresh to try again.';
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _isInitialLoad = false;
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      });
    }
  }

  List<TradingSignal> get _filteredSignals {
    switch (_filter) {
      case 'confirmed':
        return _signals.where((s) => s.isConfirmedOnLowerTimeframe).toList();
      case 'pending':
        return _signals.where((s) => !s.isConfirmedOnLowerTimeframe).toList();
      case 'very_strong':
        return _signals
            .where((s) => s.strength == SignalStrength.veryStrong)
            .toList();
      default:
        return _signals;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signals'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isLoading ? null : _loadSignals,
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadSignals,
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_isInitialLoad && _isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Analyzing market data from MT5...'),
            SizedBox(height: 8),
            Text(
              'This may take a moment',
              style: TextStyle(
                color: AppTheme.textSecondaryColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 48,
                color: AppTheme.errorColor.withValues(alpha: 0.7),
              ),
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _loadSignals,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    final filteredSignals = _filteredSignals;

    if (filteredSignals.isEmpty && !_isLoading) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.trending_flat,
                size: 48,
                color: AppTheme.textSecondaryColor.withValues(alpha: 0.5),
              ),
              const SizedBox(height: 16),
              const Text(
                'No signals available',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'No high-confidence signals match your filter criteria.\nPull to refresh or adjust filters.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppTheme.textSecondaryColor,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _loadSignals,
                icon: const Icon(Icons.refresh),
                label: const Text('Refresh Signals'),
              ),
            ],
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (_isLoading)
          const Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        _buildFilterChips(),
        const SizedBox(height: 8),
        _buildSignalsInfo(),
        const SizedBox(height: 16),
        ...filteredSignals.map((signal) => _buildSignalCardFromModel(signal)),
      ],
    );
  }

  Widget _buildSignalsInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline,
              size: 16, color: AppTheme.primaryColor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '${_signals.length} high-confidence signal${_signals.length == 1 ? '' : 's'} (99%+ confidence)',
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.primaryColor,
              ),
            ),
          ),
        ],
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

  Widget _buildSignalCardFromModel(TradingSignal signal) {
    final timeframeStr =
        signal.primaryTimeframe.toString().split('.').last.toUpperCase();

    // Convert SignalStrength enum to display string
    String strengthStr;
    switch (signal.strength) {
      case SignalStrength.veryStrong:
        strengthStr = 'Very Strong';
        break;
      case SignalStrength.strong:
        strengthStr = 'Strong';
        break;
      case SignalStrength.moderate:
        strengthStr = 'Moderate';
        break;
      case SignalStrength.weak:
        strengthStr = 'Weak';
        break;
    }

    return _buildSignalCard(
      symbol: signal.symbol,
      type: signal.type == SignalType.buy ? 'BUY' : 'SELL',
      strength: strengthStr,
      confidence: signal.confidenceScore * 100,
      entry: signal.entryPrice,
      stopLoss: signal.stopLoss,
      takeProfit: signal.takeProfit,
      timeframe: timeframeStr,
      confirmedOnLowerTF: signal.isConfirmedOnLowerTimeframe,
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
