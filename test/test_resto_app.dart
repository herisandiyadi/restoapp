import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/data/model/restaurant_search.dart';
import 'package:restaurant_app/data/service/api_service.dart';

import 'test_resto_app.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('Restaurant API Check', () {
    test('Return List Restaurant', () async {
      final client = MockClient();
      when(client.get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
          .thenAnswer((_) async => http.Response(
              '{"error":false,"message":"success","count":20,"restaurants":[]}',
              200));

      expect(await ApiService(client: client).getData(), isA<Restaurant>());
    });
    test('Return Detail Restaurant', () async {
      final client = MockClient();
      when(client.get(Uri.parse(
              'https://restaurant-api.dicoding.dev/detail/s1knt6za9kkfw1e867')))
          .thenAnswer((_) async => http.Response(
              '{"error":false,"message":"success","restaurant":{"id":"s1knt6za9kkfw1e867","name":"Kafe Kita","description":"Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,","city":"Gorontalo","address":"Jln. Pustakawan no 9","pictureId":"25","categories":[{"name":"Sop"},{"name":"Modern"}],"menus":{"foods":[{"name":"Kari kacang dan telur"},{"name":"Ikan teri dan roti"},{"name":"roket penne"},{"name":"Salad lengkeng"},{"name":"Tumis leek"},{"name":"Salad yuzu"},{"name":"Sosis squash dan mint"}],"drinks":[{"name":"Jus tomat"},{"name":"Minuman soda"},{"name":"Jus apel"},{"name":"Jus mangga"},{"name":"Es krim"},{"name":"Kopi espresso"},{"name":"Jus alpukat"},{"name":"Coklat panas"},{"name":"Es kopi"},{"name":"Teh manis"},{"name":"Sirup"},{"name":"Jus jeruk"}]},"rating":4,"customerReviews":[{"name":"Ahmad","review":"Tidak ada duanya!","date":"13 November 2019"},{"name":"Arif","review":"Tidak rekomendasi untuk pelajar!","date":"13 November 2019"},{"name":"Gilang","review":"Tempatnya bagus namun menurut saya masih sedikit mahal.","date":"14 Agustus 2018"}]}}',
              200));
      expect(await ApiService(client: client).getDetail('s1knt6za9kkfw1e867'),
          isA<RestaurantDetail>());
    });
    test('Throws exception if detail error', () async {
      final client = MockClient();

      when(client.get(Uri.parse(
              'https://restaurant-api.dicoding.dev/detail/s1knt6za9kkfw1e867')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(ApiService(client: client).getDetail('s1knt6za9kkfw1e867'),
          throwsException);
    });

    test('Return Search Restaurant', () async {
      final client = MockClient();
      when(client.get(
              Uri.parse('https://restaurant-api.dicoding.dev/search?q=kita')))
          .thenAnswer((_) async => http.Response(
              '{"error":false,"founded":1,"restaurants":[{"id":"s1knt6za9kkfw1e867","name":"Kafe Kita","description":"Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,","pictureId":"25","city":"Gorontalo","rating":4}]}',
              200));
      expect(await ApiService(client: client).getSearch('kita'),
          isA<RestaurantSearch>());
    });
    test('Throws exception if search error', () async {
      final client = MockClient();

      when(client.get(
              Uri.parse('https://restaurant-api.dicoding.dev/search?q=kita')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(ApiService(client: client).getSearch('kita'), throwsException);
    });
  });
}
