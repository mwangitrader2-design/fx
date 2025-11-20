import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class RecentSignalsList extends StatelessWidget {
  const RecentSignalsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        return _buildSignalItem(
          context,
          ['EURUSD', 'GBPUSD', 'USDJPY'][index],
          ['BUY', 'SELL', 'BUY'][index],
          [99.2, 97.5, 96.8][index],
          [true, true, false][index],
        );
      },
    );
  }

  Widget _buildSignalItem(
    BuildContext context,
    String symbol,
    String type,
    double confidence,
    bool confirmed,
  ) {
    final isBuy = type == 'BUY';
    final signalColor = isBuy ? AppTheme.successColor : AppTheme.errorColor;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: signalColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            isBuy ? Icons.trending_up : Icons.trending_down,
            color: signalColor,
          ),
        ),
        title: Text(
          symbol,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '$type • ${confidence.toStringAsFixed(1)}% confidence',
          style: const TextStyle(fontSize: 12),
        ),
        trailing: confirmed
            ? const Icon(Icons.check_circle, color: AppTheme.successColor)
            : const Icon(Icons.schedule, color: AppTheme.warningColor),
        onTap: () {},
      ),
    );
  }
}
