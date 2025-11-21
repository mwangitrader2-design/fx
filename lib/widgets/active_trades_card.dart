import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ActiveTradesCard extends StatelessWidget {
  const ActiveTradesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 2,
      itemBuilder: (context, index) {
        return _buildTradeItem(
          context,
          ['EURUSD', 'GBPUSD'][index],
          ['BUY', 'SELL'][index],
          [100.00, 60.00][index],
          [1.83, 1.58][index],
        );
      },
    );
  }

  Widget _buildTradeItem(
    BuildContext context,
    String symbol,
    String type,
    double profit,
    double profitPercent,
  ) {
    final isBuy = type == 'BUY';
    final isProfit = profit >= 0;
    final signalColor = isBuy ? AppTheme.successColor : AppTheme.errorColor;

    return RepaintBoundary(
      child: Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: signalColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              isBuy ? Icons.arrow_upward : Icons.arrow_downward,
              color: signalColor,
            ),
          ),
          title: Text(
            symbol,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            type,
            style: TextStyle(fontSize: 12, color: signalColor),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${isProfit ? '+' : ''}\$${profit.toStringAsFixed(2)}',
                style: TextStyle(
                  color: isProfit ? AppTheme.successColor : AppTheme.errorColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                '${isProfit ? '+' : ''}${profitPercent.toStringAsFixed(2)}%',
                style: TextStyle(
                  color: isProfit ? AppTheme.successColor : AppTheme.errorColor,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
