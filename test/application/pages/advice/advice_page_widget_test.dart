import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:get_advices/application/pages/advice/advice_page.dart';
import 'package:get_advices/application/pages/advice/cubit/advice_cubit.dart';
import 'package:get_advices/application/pages/advice/widgets/advice_filed.dart';
import 'package:get_advices/application/pages/advice/widgets/error_message.dart';
import 'package:provider/provider.dart';

class MockAdvicerCubit extends MockCubit<AdviceCubitState> implements AdviceCubit {}

void main() {
  Widget widgetUnderTest({required AdviceCubit cubit}) {
    return MaterialApp(
      home: BlocProvider<AdviceCubit>(
        create: (context) => cubit,
        child: const AdvicerPage(),
      ),
    );
  }

  group(
    'AdvicerPage',
        () {
      late AdviceCubit mockAdvicerCubit;

      setUp(
            () {
          mockAdvicerCubit = MockAdvicerCubit();
        },
      );
      group(
        'should be displayed in ViewState',
            () {
          testWidgets(
            'Initial when cubits emits AdvicerInitial()',
                (widgetTester) async {
              whenListen(
                mockAdvicerCubit,
                Stream.fromIterable(const [AdviceInitial()]),
                initialState: const AdviceInitial(),
              );

              await widgetTester.pumpWidget(widgetUnderTest(cubit: mockAdvicerCubit));

              final advicerInitalTextFinder = find.text('Your Advice is waiting for you!');

              expect(advicerInitalTextFinder, findsOneWidget);
            },
          );

          testWidgets(
            'Loading when cubits emits AdvicerStateLoading()',
                (widgetTester) async {
              whenListen(
                mockAdvicerCubit,
                Stream.fromIterable(const [AdvicerStateLoading()]),
                initialState: const AdviceInitial(),
              );

              await widgetTester.pumpWidget(widgetUnderTest(cubit: mockAdvicerCubit));
              await widgetTester.pump();

              final advicerLoadingFinder = find.byType(CircularProgressIndicator);

              expect(advicerLoadingFinder, findsOneWidget);
            },
          );

          testWidgets(
            'advice text when cubits emits AdvicerStateLoaded()',
                (widgetTester) async {
              whenListen(
                mockAdvicerCubit,
                Stream.fromIterable(const [AdvicerStateLoaded(advice: '42')]),
                initialState: const AdviceInitial(),
              );

              await widgetTester.pumpWidget(widgetUnderTest(cubit: mockAdvicerCubit));
              await widgetTester.pump();

              final advicerLoadedStateFinder = find.byType(AdviceField);
              final adviceText = widgetTester.widget<AdviceField>(advicerLoadedStateFinder).advice;

              expect(advicerLoadedStateFinder, findsOneWidget);
              expect(adviceText, '42');
            },
          );

          testWidgets(
            'Error when cubits emits AdvicerStateError()',
                (widgetTester) async {
              whenListen(
                mockAdvicerCubit,
                Stream.fromIterable(const [AdvicerStateError(message: 'error')]),
                initialState: const AdviceInitial(),
              );

              await widgetTester.pumpWidget(widgetUnderTest(cubit: mockAdvicerCubit));
              await widgetTester.pump();

              final advicerErrorFinder = find.byType(ErrorMessage);

              expect(advicerErrorFinder, findsOneWidget);
            },
          );
        },
      );
    },
  );
}