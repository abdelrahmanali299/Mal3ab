import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mal3ab/core/function/custom_snack_bar.dart';
import 'package:mal3ab/features/admin/data/models/match_model.dart';
import 'package:mal3ab/features/admin/presentation/manager/admin_cubit.dart';
import 'package:mal3ab/features/admin/presentation/views/widgets/pick_date_time.dart';
import 'package:mal3ab/features/auth/presentation/login/views/widgets/custom_botton.dart';
import 'package:uuid/uuid.dart';

class AdminViewBody extends StatefulWidget {
  const AdminViewBody({super.key});

  @override
  State<AdminViewBody> createState() => _AdminViewBodyState();
}

class _AdminViewBodyState extends State<AdminViewBody> {
  MatchModel matchModel = MatchModel();

  @override
  Widget build(BuildContext context) {
    var hight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: hight * .2),

            CustomButton(
              title: 'Add Match',
              titleColor: Colors.white,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (_) {
                    matchModel.startDate = matchModel.endDate = DateTime.now();
                    return BlocProvider.value(
                      value: BlocProvider.of<AdminCubit>(context)
                        ..getNewestMatch(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: hight * .1),
                            Text(
                              'Add Match',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  spacing: 5,
                                  children: [
                                    Text(
                                      'Start Date',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    PickDateTime(
                                      lastMatchDate:
                                          context
                                              .watch<AdminCubit>()
                                              .matchModel
                                              .startDate ??
                                          DateTime.now(),
                                      onDateSelected: (value) {
                                        context
                                            .read<AdminCubit>()
                                            .getNewestMatch();
                                        if (value.day == DateTime.now().day &&
                                            value.month ==
                                                DateTime.now().month &&
                                            value.year == DateTime.now().year) {
                                          matchModel.startDate = DateTime.now();
                                        } else {
                                          matchModel.startDate = value;
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(width: 20),
                                Column(
                                  spacing: 5,
                                  children: [
                                    Text(
                                      'End Date',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    PickDateTime(
                                      lastMatchDate:
                                          context
                                              .read<AdminCubit>()
                                              .matchModel
                                              .endDate ??
                                          DateTime.now(),
                                      onDateSelected: (value) {
                                        if (value.day == DateTime.now().day &&
                                            value.month ==
                                                DateTime.now().month &&
                                            value.year == DateTime.now().year) {
                                          matchModel.endDate = DateTime.now();
                                        } else {
                                          matchModel.endDate = value;
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Spacer(),
                            BlocConsumer<AdminCubit, AdminState>(
                              listenWhen: (previous, current) =>
                                  current is AddMatchSuccess ||
                                  current is AddMatchError,
                              listener: (context, state) {
                                if (state is AddMatchSuccess) {
                                  Navigator.pop(context);
                                  customSnackBar(
                                    context,
                                    'Add Match Successfully',
                                    Colors.green,
                                  );
                                } else if (state is AddMatchError) {
                                  Navigator.pop(context);

                                  customSnackBar(
                                    context,
                                    state.failure,
                                    Colors.red,
                                  );
                                }
                              },
                              builder: (context, state) {
                                return state is AddMatchLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : CustomButton(
                                        title: 'Add',
                                        titleColor: Colors.white,
                                        onTap: () async {
                                          if (matchModel.endDate!.isBefore(
                                            matchModel.startDate ??
                                                DateTime.now(),
                                          )) {
                                            Navigator.pop(context);
                                            customSnackBar(
                                              context,
                                              'End Date must be after Start Date',
                                              Colors.red,
                                            );
                                            return;
                                          }
                                          matchModel.players = [];
                                          matchModel.id = Uuid().v4();
                                          await context
                                              .read<AdminCubit>()
                                              .addMatch(matchModel: matchModel);
                                          context
                                              .read<AdminCubit>()
                                              .getNewestMatch();
                                        },
                                      );
                              },
                            ),
                            SizedBox(height: hight * .1),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
