import 'package:faker/faker.dart';
import 'package:flutter_fordev/data/http/http.dart';
import 'package:flutter_fordev/infra/http/http_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'http_adapter_test.mocks.dart';

@GenerateMocks([Client])
void main() {
  late MockClient client;
  late HttpAdapter sut;
  late String url;
  late Uri uri;

  setUp(() {
    client = MockClient();
    sut = HttpAdapter(client);
    url = faker.internet.httpUrl();
    uri = Uri.parse(url);
  });

  group('post', () {
    PostExpectation mockRequest() => when(client.post(uri, headers: anyNamed('headers'), body: anyNamed('body')));

    void mockResponse(int statusCode, {String body = '{"any_key":"any_value"}'}) {
      mockRequest().thenAnswer((_) async => Response(body, statusCode));
    }

    setUp(() {
      mockResponse(200);
    });

    test('Should call post with correct values', () async {
      await sut.request(url: url, method: 'post', body: {"any_key": "any_value"});

      verify(
        client.post(uri,
            headers: {
              'content-type': 'application/json',
              'accept': 'application/json',
            },
            body: '{"any_key":"any_value"}'),
      );
    });

    test('Should call post with no body values', () async {
      await sut.request(url: url, method: 'post');

      verify(client.post(uri, headers: anyNamed('headers')));
    });

    test('Should return data if post return 200', () async {
      var response = await sut.request(url: url, method: 'post');

      expect(response, {"any_key": "any_value"});
    });

    test('Should return empty map if post return 200 with no data', () async {
      mockResponse(200, body: '');

      var response = await sut.request(url: url, method: 'post');

      expect(response, {});
    });

    test('Should return empty map if post return 204', () async {
      mockResponse(204, body: '');

      var response = await sut.request(url: url, method: 'post');

      expect(response, {});
    });

    test('Should return BadRequestError if post returns 400', () async {
      mockResponse(400);

      var response = sut.request(url: url, method: 'post');

      expect(response, throwsA(HttpError.badRequest));
    });

    test('Should return ServerError if post returns 500', () async {
      mockResponse(500);

      var response = sut.request(url: url, method: 'post');

      expect(response, throwsA(HttpError.serverError));
    });

    test('Should return Unauthorized if post returns 401', () async {
      mockResponse(401);

      var response = sut.request(url: url, method: 'post');

      expect(response, throwsA(HttpError.unauthorized));
    });

    test('Should return Forbidden if post returns 403', () async {
      mockResponse(403);

      var response = sut.request(url: url, method: 'post');

      expect(response, throwsA(HttpError.forbidden));
    });

    test('Should return NotFound if post returns 404', () async {
      mockResponse(404);

      var response = sut.request(url: url, method: 'post');

      expect(response, throwsA(HttpError.notFound));
    });
  });
}
