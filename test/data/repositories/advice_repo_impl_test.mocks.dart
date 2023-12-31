// Mocks generated by Mockito 5.4.2 from annotations
// in get_advices/test/data/repositories/advice_repo_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:get_advices/data/datasources/advice_remote_datasource.dart'
    as _i3;
import 'package:get_advices/data/models/advice_model.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeAdviceModel_0 extends _i1.SmartFake implements _i2.AdviceModel {
  _FakeAdviceModel_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AdviceRemoteDatasource].
///
/// See the documentation for Mockito's code generation for more information.
class MockAdviceRemoteDatasource extends _i1.Mock
    implements _i3.AdviceRemoteDatasource {
  @override
  _i4.Future<_i2.AdviceModel> getRandomAdviceFromApi() => (super.noSuchMethod(
        Invocation.method(
          #getRandomAdviceFromApi,
          [],
        ),
        returnValue: _i4.Future<_i2.AdviceModel>.value(_FakeAdviceModel_0(
          this,
          Invocation.method(
            #getRandomAdviceFromApi,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.AdviceModel>.value(_FakeAdviceModel_0(
          this,
          Invocation.method(
            #getRandomAdviceFromApi,
            [],
          ),
        )),
      ) as _i4.Future<_i2.AdviceModel>);
}
