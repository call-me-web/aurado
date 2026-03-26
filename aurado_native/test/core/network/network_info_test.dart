import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aurado/core/network/network_info.dart';

/// Hand-rolled fake for [Connectivity].
/// Avoids any dependency on mockito/mocktail while keeping tests pure.
class _FakeConnectivity implements Connectivity {
  _FakeConnectivity(this._result);

  final List<ConnectivityResult> _result;

  @override
  Future<List<ConnectivityResult>> checkConnectivity() async => _result;

  @override
  Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      Stream.value(_result);

  // Unused API surface — delegate to satisfy the interface.
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  group('NetworkInfoImpl', () {
    group('isConnected', () {
      test('returns true when wifi is available', () async {
        final sut = NetworkInfoImpl(
          _FakeConnectivity([ConnectivityResult.wifi]),
        );
        expect(await sut.isConnected, isTrue);
      });

      test('returns true when mobile data is available', () async {
        final sut = NetworkInfoImpl(
          _FakeConnectivity([ConnectivityResult.mobile]),
        );
        expect(await sut.isConnected, isTrue);
      });

      test('returns false when result is none', () async {
        final sut = NetworkInfoImpl(
          _FakeConnectivity([ConnectivityResult.none]),
        );
        expect(await sut.isConnected, isFalse);
      });

      test('returns true when multiple results include wifi', () async {
        final sut = NetworkInfoImpl(
          _FakeConnectivity([ConnectivityResult.wifi, ConnectivityResult.mobile]),
        );
        expect(await sut.isConnected, isTrue);
      });

      test('returns false when all results are none', () async {
        final sut = NetworkInfoImpl(
          _FakeConnectivity([ConnectivityResult.none]),
        );
        expect(await sut.isConnected, isFalse);
      });
    });

    group('onConnectivityChanged', () {
      test('exposes the connectivity stream', () async {
        final sut = NetworkInfoImpl(
          _FakeConnectivity([ConnectivityResult.wifi]),
        );
        final result = await sut.onConnectivityChanged.first;
        expect(result, contains(ConnectivityResult.wifi));
      });
    });
  });
}
