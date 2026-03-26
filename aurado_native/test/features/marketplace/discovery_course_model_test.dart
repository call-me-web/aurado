import 'package:flutter_test/flutter_test.dart';
import 'package:aurado/features/marketplace/domain/models/discovery_course_model.dart';

void main() {
  group('DiscoveryCourseModel.fromJson', () {
    const minimalJson = {
      'id': 'course-1',
      'tenant_id': 'tenant-abc',
      'title': 'Flutter Fundamentals',
    };

    test('parses required fields correctly', () {
      final model = DiscoveryCourseModel.fromJson(minimalJson);

      expect(model.id, 'course-1');
      expect(model.tenantId, 'tenant-abc');
      expect(model.title, 'Flutter Fundamentals');
    });

    test('defaults price to 0.0 when absent', () {
      final model = DiscoveryCourseModel.fromJson(minimalJson);
      expect(model.price, 0.0);
    });

    test('defaults currency to BDT when absent', () {
      final model = DiscoveryCourseModel.fromJson(minimalJson);
      expect(model.currency, 'BDT');
    });

    test('defaults list fields to empty when absent', () {
      final model = DiscoveryCourseModel.fromJson(minimalJson);
      expect(model.hashtags, isEmpty);
      expect(model.whatYouWillLearn, isEmpty);
      expect(model.requirements, isEmpty);
      expect(model.learningMaterials, isEmpty);
      expect(model.courseCategory, isEmpty);
    });

    test('optional string fields default to null when absent', () {
      final model = DiscoveryCourseModel.fromJson(minimalJson);
      expect(model.description, isNull);
      expect(model.thumbnailUrl, isNull);
      expect(model.level, isNull);
      expect(model.duration, isNull);
      expect(model.language, isNull);
      expect(model.courseType, isNull);
      expect(model.tenantName, isNull);
      expect(model.tenantLogoUrl, isNull);
    });

    test('parses full payload correctly', () {
      final fullJson = {
        'id': 'course-2',
        'tenant_id': 'tenant-xyz',
        'title': 'Advanced Dart',
        'description': 'Deep dive into Dart.',
        'thumbnail_url': 'https://example.com/thumb.jpg',
        'price': 1500.0,
        'currency': 'USD',
        'level': 'Advanced',
        'duration': '12 hours',
        'language': 'English',
        'course_type': 'recorded',
        'hashtags': ['dart', 'flutter'],
        'what_you_will_learn': ['Isolates', 'Extensions'],
        'requirements': ['Basic Dart'],
        'learning_materials': ['Videos', 'PDFs'],
        'course_category': ['Programming'],
        'tenant_name': 'Tech Academy',
        'tenant_logo_url': 'https://example.com/logo.png',
        'course_id': 'course-2',
      };

      final model = DiscoveryCourseModel.fromJson(fullJson);

      expect(model.id, 'course-2');
      expect(model.tenantId, 'tenant-xyz');
      expect(model.title, 'Advanced Dart');
      expect(model.description, 'Deep dive into Dart.');
      expect(model.thumbnailUrl, 'https://example.com/thumb.jpg');
      expect(model.price, 1500.0);
      expect(model.currency, 'USD');
      expect(model.level, 'Advanced');
      expect(model.duration, '12 hours');
      expect(model.language, 'English');
      expect(model.courseType, 'recorded');
      expect(model.hashtags, ['dart', 'flutter']);
      expect(model.whatYouWillLearn, ['Isolates', 'Extensions']);
      expect(model.requirements, ['Basic Dart']);
      expect(model.learningMaterials, ['Videos', 'PDFs']);
      expect(model.courseCategory, ['Programming']);
      expect(model.tenantName, 'Tech Academy');
      expect(model.tenantLogoUrl, 'https://example.com/logo.png');
    });

    test('price field is parsed as double from int json value', () {
      final json = {...minimalJson, 'price': 500};
      final model = DiscoveryCourseModel.fromJson(json);
      expect(model.price, 500.0);
      expect(model.price, isA<double>());
    });

    test('course is considered free when price is 0', () {
      final model = DiscoveryCourseModel.fromJson(minimalJson);
      expect(model.price <= 0, isTrue);
    });

    test('course is considered paid when price is positive', () {
      final json = {...minimalJson, 'price': 999.0};
      final model = DiscoveryCourseModel.fromJson(json);
      expect(model.price > 0, isTrue);
    });
  });
}
