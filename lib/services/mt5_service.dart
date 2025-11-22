import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MT5Service {
  // IMPORTANT: Change this to your PC's local IP address
  // Find your IP: Open CMD and run "ipconfig" - look for IPv4 Address (e.g., 192.168.1.100)
  // For Android emulator use: 'http://10.0.2.2:5000'
  // For physical device use: 'http://YOUR_PC_IP:5000' (e.g., 'http://192.168.1.100:5000')
  static const String _baseUrl =
      'http://192.168.100.4:5000'; // Your PC's IP address
  static const String _credentialsKey = 'mt5_credentials';

  // Store credentials locally
  Future<void> saveCredentials({
    required String username,
    required String password,
    required String server,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final credentials = {
      'username': username,
      'password': password,
      'server': server,
    };
    await prefs.setString(_credentialsKey, jsonEncode(credentials));
  }

  // Get stored credentials
  Future<Map<String, String>?> getCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final credentialsJson = prefs.getString(_credentialsKey);
    if (credentialsJson == null) return null;

    final decoded = jsonDecode(credentialsJson) as Map<String, dynamic>;
    return {
      'username': decoded['username'] as String,
      'password': decoded['password'] as String,
      'server': decoded['server'] as String,
    };
  }

  // Clear stored credentials
  Future<void> clearCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_credentialsKey);
  }

  // Test MT5 connection via Python bridge
  Future<Map<String, dynamic>> testConnection({
    required String username,
    required String password,
    required String server,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse('$_baseUrl/mt5/test_connection'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'username': username,
              'password': password,
              'server': server,
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return {
          'success': data['success'] ?? false,
          'message': data['message'] ?? 'Unknown error',
          'account_info': data['account_info'],
        };
      } else {
        return {
          'success': false,
          'message': 'Server error: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Connection failed: $e',
      };
    }
  }

  // Login to MT5
  Future<Map<String, dynamic>> login({
    required String username,
    required String password,
    required String server,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse('$_baseUrl/mt5/login'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'username': username,
              'password': password,
              'server': server,
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;

        if (data['success'] == true) {
          // Save credentials on successful login
          await saveCredentials(
            username: username,
            password: password,
            server: server,
          );
        }

        return {
          'success': data['success'] ?? false,
          'message': data['message'] ?? 'Unknown error',
          'account_info': data['account_info'],
          'balance': data['balance'],
          'equity': data['equity'],
          'margin': data['margin'],
        };
      } else {
        return {
          'success': false,
          'message': 'Server error: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Login failed: $e',
      };
    }
  }

  // Logout from MT5
  Future<Map<String, dynamic>> logout() async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/mt5/logout'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 5));

      await clearCredentials();

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return {
          'success': data['success'] ?? false,
          'message': data['message'] ?? 'Logged out',
        };
      } else {
        return {
          'success': true,
          'message': 'Logged out (offline)',
        };
      }
    } catch (e) {
      await clearCredentials();
      return {
        'success': true,
        'message': 'Logged out (offline)',
      };
    }
  }

  // Get account info
  Future<Map<String, dynamic>> getAccountInfo() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/mt5/account_info'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return {
          'success': data['success'] ?? false,
          'data': data['data'],
        };
      } else {
        return {
          'success': false,
          'message': 'Failed to get account info',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }

  // Place a trade order
  Future<Map<String, dynamic>> placeOrder({
    required String symbol,
    required String orderType,
    required double volume,
    required double price,
    required double stopLoss,
    required double takeProfit,
    String? comment,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse('$_baseUrl/mt5/place_order'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'symbol': symbol,
              'order_type': orderType,
              'volume': volume,
              'price': price,
              'stop_loss': stopLoss,
              'take_profit': takeProfit,
              'comment': comment ?? '',
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return {
          'success': data['success'] ?? false,
          'ticket': data['ticket'],
          'entryPrice': data['entry_price'] ?? price,
          'message': data['message'] ?? 'Order placed',
        };
      } else {
        return {
          'success': false,
          'message': 'Failed to place order: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error placing order: $e',
      };
    }
  }

  // Get position information by ticket ID
  Future<Map<String, dynamic>?> getPosition(String ticket) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/mt5/position/$ticket'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        if (data['success'] == true && data['position'] != null) {
          return data['position'] as Map<String, dynamic>;
        }
        return null;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Get closed trade history by ticket ID
  Future<Map<String, dynamic>?> getTradeHistory(String ticket) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/mt5/trade_history/$ticket'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        if (data['success'] == true && data['trade'] != null) {
          return data['trade'] as Map<String, dynamic>;
        }
        return null;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Modify position stop loss and take profit
  Future<Map<String, dynamic>> modifyPosition({
    required String ticket,
    required double stopLoss,
    required double takeProfit,
  }) async {
    try {
      final response = await http
          .put(
            Uri.parse('$_baseUrl/mt5/position/$ticket'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'stop_loss': stopLoss,
              'take_profit': takeProfit,
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return {
          'success': data['success'] ?? false,
          'message': data['message'] ?? 'Position modified',
        };
      } else {
        return {
          'success': false,
          'message': 'Failed to modify position: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error modifying position: $e',
      };
    }
  }

  // Close position
  Future<Map<String, dynamic>> closePosition(String ticket) async {
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/mt5/position/$ticket'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return {
          'success': data['success'] ?? false,
          'message': data['message'] ?? 'Position closed',
        };
      } else {
        return {
          'success': false,
          'message': 'Failed to close position: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error closing position: $e',
      };
    }
  }

  // Close partial position
  Future<Map<String, dynamic>> closePartialPosition(
    String ticket,
    double volume,
  ) async {
    try {
      final response = await http
          .post(
            Uri.parse('$_baseUrl/mt5/position/$ticket/close_partial'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'volume': volume,
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return {
          'success': data['success'] ?? false,
          'message': data['message'] ?? 'Partial position closed',
        };
      } else {
        return {
          'success': false,
          'message': 'Failed to close partial position: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error closing partial position: $e',
      };
    }
  }

  // Check if Python bridge server is running
  Future<bool> checkServerStatus() async {
    try {
      final response = await http
          .get(
            Uri.parse('$_baseUrl/health'),
          )
          .timeout(const Duration(seconds: 3));

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  // Get historical chart data for a symbol
  Future<Map<String, dynamic>> getChartData({
    required String symbol,
    String timeframe = 'H1',
    int count = 500,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(
            '$_baseUrl/mt5/chart_data/$symbol?timeframe=$timeframe&count=$count'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return {
          'success': data['success'] ?? false,
          'message': data['message'],
          'data': data['data'],
        };
      } else {
        return {
          'success': false,
          'message': 'Failed to get chart data: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error getting chart data: $e',
      };
    }
  }

  // Get chart data for multiple timeframes at once
  Future<Map<String, dynamic>> getMultiTimeframeData({
    required String symbol,
    List<String> timeframes = const ['M15', 'H1', 'H4', 'D1'],
    int count = 500,
  }) async {
    try {
      final timeframesParam = timeframes.join(',');
      final response = await http.get(
        Uri.parse(
            '$_baseUrl/mt5/chart_data_multi/$symbol?timeframes=$timeframesParam&count=$count'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return {
          'success': data['success'] ?? false,
          'message': data['message'],
          'data': data['data'],
        };
      } else {
        return {
          'success': false,
          'message':
              'Failed to get multi-timeframe data: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error getting multi-timeframe data: $e',
      };
    }
  }
}
