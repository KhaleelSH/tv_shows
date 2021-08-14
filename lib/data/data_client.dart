import 'package:tv_shows/data/api_data_client.dart';
import 'package:tv_shows/data/local_data_client.dart';

class DataClient {
  final ApiDataClient api;
  final LocalDataClient local;

  DataClient({
    required this.api,
    required this.local,
  });
}
