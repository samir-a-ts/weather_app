import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/translations/i18n.dart';
import 'package:weather_app/features/app/presentation/cubtis/init_cubit.dart';

class LanguageSet extends StatefulWidget {
  const LanguageSet({Key key}) : super(key: key);

  @override
  _LanguageSetState createState() => _LanguageSetState();
}

class _LanguageSetState extends State<LanguageSet> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<InitCubit, InitState>(
      listener: (context, state) {
        if (state is InitLoaded) {
          I18n.load(Locale(state.settings.locale));
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            I18n.language,
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: I18nDelegate.supportedLocals
                  .map<Widget>(
                    (e) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          final cubit = BlocProvider.of<InitCubit>(context);

                          final state = cubit.state as InitLoaded;

                          cubit.update(
                            state,
                            settings:
                                state.settings.copyWith(locale: e.languageCode),
                          );
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              e.toLanguageTag().toUpperCase(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
