import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/service/api_service.dart';
import 'package:restaurant_app/provider/resto_provider.dart';

void main() {
  late ApiService apiService;
  test(
    'Should contain new item when module completed',
    (() {
      var restoProvider = RestoProvider(apiService: ApiService());
      var testModuleName = 'Test Module';

      restoProvider.apiService.getData();
    }),
  );
}
