import 'dart:convert';
import 'package:http/http.dart' as http;

Future<double> rateCalculator(String currency) async {
  final url = Uri.parse(
    'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=${currency.toLowerCase()}',
  );
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['bitcoin'][currency.toLowerCase()];
  } else {
    print('Error: ${response.statusCode}');
    return 0.0;
  }
}
