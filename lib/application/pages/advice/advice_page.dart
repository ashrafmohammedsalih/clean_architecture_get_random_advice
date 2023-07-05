import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_advices/application/pages/advice/cubit/advice_cubit.dart';
import 'package:get_advices/application/pages/advice/widgets/advice_filed.dart';
import 'package:get_advices/application/pages/advice/widgets/custom_button.dart';
import 'package:get_advices/application/pages/advice/widgets/error_message.dart';
import 'package:get_advices/injection.dart';


class AdvicerPageWrapperProvider extends StatelessWidget {
  const AdvicerPageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AdviceCubit>(),
      child: const AdvicerPage(),
    );
  }
}

class AdvicerPage extends StatelessWidget {
  const AdvicerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Advicer',
            style: themeData.textTheme.headline1,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: [
              Expanded(child:
                  Center(child: BlocBuilder<AdviceCubit, AdviceCubitState>(
                builder: (context, state) {
                  if (state is AdviceInitial) {
                    return Text(
                      'Your Advice is waiting for you!',
                      style: themeData.textTheme.headline1,
                    );
                  } else if (state is AdvicerStateLoading) {
                    return CircularProgressIndicator(
                      color: themeData.colorScheme.secondary,
                    );
                  } else if (state is AdvicerStateLoaded) {
                    return AdviceField(
                      advice: state.advice,
                    );
                  } else if (state is AdvicerStateError) {
                    return ErrorMessage(message: state.message);
                  }
                  return const SizedBox();
                },
              ))),
               SizedBox(height: 200, child: Center(child: CustomButton(
                onTap: () => BlocProvider.of<AdviceCubit>(context).aviceRequested(),
              )))
            ],
          ),
        ));
  }
}
