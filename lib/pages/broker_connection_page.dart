import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/mt5_service.dart';

class BrokerConnectionPage extends StatefulWidget {
  const BrokerConnectionPage({super.key});

  @override
  State<BrokerConnectionPage> createState() => _BrokerConnectionPageState();
}

class _BrokerConnectionPageState extends State<BrokerConnectionPage> {
  final _mt5Service = MT5Service();
  String? _selectedBroker = 'MetaTrader 5';
  bool _isConnected = false;
  bool _isLoading = false;
  Map<String, dynamic>? _accountInfo;

  final _accountIdController = TextEditingController(text: '130798');
  final _passwordController = TextEditingController(text: 'Mare-Dewy-09');
  final _serverController = TextEditingController(text: 'EGMSecurities-Demo');

  final List<Map<String, dynamic>> _brokers = [
    {'name': 'MetaTrader 5', 'icon': Icons.trending_up, 'supported': true},
    {'name': 'MetaTrader 4', 'icon': Icons.show_chart, 'supported': true},
  ];

  @override
  void initState() {
    super.initState();
    _loadStoredCredentials();
    _checkServerStatus();
  }

  @override
  void dispose() {
    _accountIdController.dispose();
    _passwordController.dispose();
    _serverController.dispose();
    super.dispose();
  }

  Future<void> _loadStoredCredentials() async {
    final credentials = await _mt5Service.getCredentials();
    if (credentials != null && mounted) {
      setState(() {
        _accountIdController.text = credentials['username'] ?? '';
        _passwordController.text = credentials['password'] ?? '';
        _serverController.text = credentials['server'] ?? '';
      });
    }
  }

  Future<void> _checkServerStatus() async {
    final isRunning = await _mt5Service.checkServerStatus();
    if (!isRunning && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('MT5 Bridge Server is not running. Please start it first.'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 5),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Broker Connection'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (_isConnected) _buildConnectionStatus(),
          if (_isConnected) const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select Your Broker',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ..._brokers.map((broker) => _buildBrokerTile(broker)),
                ],
              ),
            ),
          ),
          if (_selectedBroker != null) ...[
            const SizedBox(height: 24),
            _buildConnectionForm(),
          ],
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Connection Guide',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildGuideStep(
                    1,
                    'Start MT5 Bridge Server',
                    'Run: python mt5_bridge_server.py',
                  ),
                  _buildGuideStep(
                    2,
                    'Open MetaTrader 5',
                    'Make sure MT5 application is running on your PC',
                  ),
                  _buildGuideStep(
                    3,
                    'Enter your credentials',
                    'Account ID, Password, and Server name from your broker',
                  ),
                  _buildGuideStep(
                    4,
                    'Test & Login',
                    'Test the connection first, then login to start trading',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildConnectionStatus() {
    return Card(
      color: AppTheme.successColor.withValues(alpha: 0.1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppTheme.successColor.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: AppTheme.successColor,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Connected',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.successColor,
                        ),
                      ),
                      Text(
                        _accountInfo?['server'] ?? 'MT5',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: AppTheme.errorColor),
                  onPressed: _disconnect,
                ),
              ],
            ),
            if (_accountInfo != null) ...[
              const Divider(height: 24),
              _buildInfoRow('Account', '${_accountInfo!['login']}'),
              const SizedBox(height: 8),
              _buildInfoRow('Name', _accountInfo!['name'] ?? 'N/A'),
              const SizedBox(height: 8),
              _buildInfoRow('Balance',
                  '\$${_accountInfo!['balance']?.toStringAsFixed(2) ?? '0.00'}'),
              const SizedBox(height: 8),
              _buildInfoRow('Equity',
                  '\$${_accountInfo!['equity']?.toStringAsFixed(2) ?? '0.00'}'),
              const SizedBox(height: 8),
              _buildInfoRow('Leverage', '1:${_accountInfo!['leverage']}'),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildBrokerTile(Map<String, dynamic> broker) {
    final isSelected = _selectedBroker == broker['name'];
    final isSupported = broker['supported'] as bool;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected
              ? AppTheme.primaryColor
              : Colors.grey.withValues(alpha: 0.2),
          width: isSelected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          broker['icon'] as IconData,
          color: isSupported ? AppTheme.primaryColor : Colors.grey,
        ),
        title: Text(broker['name'] as String),
        subtitle: Text(
          isSupported ? 'Supported' : 'Coming Soon',
          style: TextStyle(
            color: isSupported ? AppTheme.successColor : Colors.grey,
            fontSize: 12,
          ),
        ),
        trailing: isSelected
            ? const Icon(Icons.check_circle, color: AppTheme.primaryColor)
            : null,
        onTap: isSupported
            ? () {
                setState(() {
                  _selectedBroker = broker['name'] as String;
                  _isConnected = false;
                });
              }
            : null,
      ),
    );
  }

  Widget _buildConnectionForm() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Connect to $_selectedBroker',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _accountIdController,
              decoration: const InputDecoration(
                labelText: 'Account ID',
                prefixIcon: Icon(Icons.account_circle_outlined),
                border: OutlineInputBorder(),
                hintText: 'e.g., 130798',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock_outline),
                border: OutlineInputBorder(),
                hintText: 'Enter your MT5 password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _serverController,
              decoration: const InputDecoration(
                labelText: 'Server',
                prefixIcon: Icon(Icons.dns_outlined),
                border: OutlineInputBorder(),
                hintText: 'e.g., EGMSecurities-Demo',
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _isLoading ? null : _testConnection,
                    icon: _isLoading
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.play_arrow),
                    label: const Text('Test'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _login,
                    icon: _isLoading
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.login),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                    ),
                    label: const Text('Login'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuideStep(int step, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                step.toString(),
                style: const TextStyle(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _testConnection() async {
    if (_accountIdController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _serverController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    final result = await _mt5Service.testConnection(
      username: _accountIdController.text,
      password: _passwordController.text,
      server: _serverController.text,
    );

    setState(() => _isLoading = false);

    if (!mounted) return;

    if (result['success'] == true) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: AppTheme.successColor),
              SizedBox(width: 8),
              Text('Test Successful'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Connection test passed!'),
              const SizedBox(height: 16),
              if (result['account_info'] != null) ...[
                Text('Account: ${result['account_info']['login']}'),
                Text('Server: ${result['account_info']['server']}'),
                Text(
                    'Balance: \$${result['account_info']['balance']?.toStringAsFixed(2)}'),
              ],
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      final errorMessage = result['message'] ?? 'Connection test failed';
      final isInvalidAccount =
          errorMessage.toLowerCase().contains('invalid account') ||
              errorMessage.toLowerCase().contains('authorization failed');

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.error, color: AppTheme.errorColor),
              SizedBox(width: 8),
              Text('Test Failed'),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(errorMessage),
                if (isInvalidAccount) ...[
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 8),
                  const Text(
                    '🔧 Possible Solutions:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '1. Verify credentials in MT5:\n   File → Login to Trade Account\n\n'
                    '2. Check if demo account expired\n   (Demo accounts last 30-90 days)\n\n'
                    '3. Verify server name is correct\n   (e.g., EGMSecurities-Demo)\n\n'
                    '4. Create new demo account:\n   File → Open an Account',
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _login() async {
    if (_accountIdController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _serverController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    final result = await _mt5Service.login(
      username: _accountIdController.text,
      password: _passwordController.text,
      server: _serverController.text,
    );

    setState(() => _isLoading = false);

    if (!mounted) return;

    if (result['success'] == true) {
      setState(() {
        _isConnected = true;
        _accountInfo = {
          'login': result['account_info']['login'],
          'server': result['account_info']['server'],
          'name': result['account_info']['name'],
          'balance': result['balance'],
          'equity': result['equity'],
          'leverage': result['account_info']['leverage'],
        };
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Successfully logged in to MT5'),
          backgroundColor: AppTheme.successColor,
        ),
      );
    } else {
      final errorMessage = result['message'] ?? 'Login failed';
      final isInvalidAccount =
          errorMessage.toLowerCase().contains('invalid account') ||
              errorMessage.toLowerCase().contains('authorization failed');

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.error, color: AppTheme.errorColor),
              SizedBox(width: 8),
              Text('Login Failed'),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(errorMessage),
                if (isInvalidAccount) ...[
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 8),
                  const Text(
                    '🔧 Possible Solutions:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '1. Verify credentials in MT5:\n   File → Login to Trade Account\n\n'
                    '2. Check if demo account expired\n   (Demo accounts last 30-90 days)\n\n'
                    '3. Verify server name is correct\n   (e.g., EGMSecurities-Demo)\n\n'
                    '4. Create new demo account:\n   File → Open an Account',
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _disconnect() async {
    setState(() => _isLoading = true);

    await _mt5Service.logout();

    setState(() {
      _isConnected = false;
      _accountInfo = null;
      _isLoading = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Disconnected from MT5'),
        ),
      );
    }
  }
}
