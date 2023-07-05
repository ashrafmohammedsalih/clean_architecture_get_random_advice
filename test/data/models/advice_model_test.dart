import 'package:get_advices/data/models/advice_model.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockJson extends Mock implements Map<String, dynamic> {}

void main() {
  group('AdviceModel.fromJson', () {
    test('should create an instance with the correct values', () {
      final mockJson = MockJson();

      const expectedId = 1;
      const expectedName = 'John Doe';
      when(mockJson['advice_id']).thenReturn(expectedId);
      when(mockJson['advice']).thenReturn(expectedName);

      // Act
      final myClass = AdviceModel.fromJson(mockJson);

      // Assert
      expect(myClass.id, equals(expectedId));
      expect(myClass.advice, equals(expectedName));
    });
  });
}
