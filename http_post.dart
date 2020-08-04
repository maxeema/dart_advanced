
import 'package:http/http.dart' as http;

main() async {

  final url = 'https://httpbin.org/post';
  final resp = await http.post(url, body: 'name=Makism&color=black');

  print('response status: ${resp.statusCode}');
  print('body: ${resp.body}');

}