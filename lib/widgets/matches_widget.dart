import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kora_news/services/get_news_bloc.dart';
import 'package:kora_news/services/get_news_states.dart';

class MatchesWidget extends StatelessWidget {
  const MatchesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetNewsBloc, GetNewsStates>(
      builder: (context, state) {
        var cubit = GetNewsBloc.get(context);
        return state is! SucccesGetMatchesState
            ? CircularProgressIndicator()
            : Container(
                height: 200,
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                  child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: 45,
                                child: Text(
                                  cubit.matchesList[index].awayTeam,
                                )),
                            SizedBox(
                              width: 5,
                            ),
                            Image.network(
                              "${cubit.matchesList[index].awayTeamimage}",
                              width: 40,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  cubit.matchesList[index].matchState,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  cubit.matchesList[index].matchTime,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Image.network(
                              "${cubit.matchesList[index].homeTeamimage}",
                              width: 40,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              cubit.matchesList[index].homeTeam,
                            ),
                          ],
                        );
                      }),
                ),
              );
      },
    );
  }
}
