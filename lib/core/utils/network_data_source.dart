import 'package:connectivity/connectivity.dart';

/// Datasource for checking internet connection.
abstract class NetworkDataSource {
  /// Method for getting
  /// user device connection status.
  Future<bool> checkInternetConnection();
}

class NetworkDataSourceImpl extends NetworkDataSource {
  final Connectivity _connectivity;

  NetworkDataSourceImpl(this._connectivity);

  @override
  Future<bool> checkInternetConnection() async {
    /// Check connection status.
    final connectionStatus = await _connectivity.checkConnectivity();

    /// If it is none, then connection to internet
    /// doesnt exist.
    return connectionStatus != ConnectivityResult.none;
  }
}
