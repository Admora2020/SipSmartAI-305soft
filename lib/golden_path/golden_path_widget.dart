import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/add_drink_widget.dart';
import '/components/drink_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'golden_path_model.dart';
export 'golden_path_model.dart';

class GoldenPathWidget extends StatefulWidget {
  const GoldenPathWidget({super.key});

  static String routeName = 'GoldenPath';
  static String routePath = '/GoldenPath';

  @override
  State<GoldenPathWidget> createState() => _GoldenPathWidgetState();
}

class _GoldenPathWidgetState extends State<GoldenPathWidget> {
  late GoldenPathModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GoldenPathModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('screen_view');
      _model.totalMlResult = await actions.getTotalMl(
        context,
      );
      FFAppState().totalMl = _model.totalMlResult!;
      safeSetState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFFFEAB6),
        body: Align(
          alignment: AlignmentDirectional(0.0, 0.0),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: () {
                if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                  return 360.0;
                } else if (MediaQuery.sizeOf(context).width >= kBreakpointMedium
                    ? false
                    : false) {
                  return 400.0;
                } else {
                  return 500.0;
                }
              }(),
            ),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
            ),
            child: Stack(
              children: [
                Stack(
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 0.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(1.0, -1.0),
                              child: LinearPercentIndicator(
                                percent: functions.progressRatio(
                                    valueOrDefault<double>(
                                      FFAppState().totalMl,
                                      0.0,
                                    ),
                                    250),
                                lineHeight: 50.0,
                                animation: true,
                                animateFromLastPercent: true,
                                progressColor:
                                    FlutterFlowTheme.of(context).primary,
                                backgroundColor:
                                    FlutterFlowTheme.of(context).accent4,
                                center: Text(
                                  functions.formatProgressString(
                                      valueOrDefault<double>(
                                        FFAppState().totalMl,
                                        0.0,
                                      ),
                                      250),
                                  style: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .override(
                                        font: GoogleFonts.poppins(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .headlineSmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .headlineSmall
                                                  .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .headlineSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .headlineSmall
                                            .fontStyle,
                                      ),
                                ),
                                barRadius: Radius.circular(15.0),
                                padding: EdgeInsets.zero,
                              ),
                            ),
                            StreamBuilder<List<DrinkTotalsRecord>>(
                              stream: queryDrinkTotalsRecord(
                                queryBuilder: (drinkTotalsRecord) =>
                                    drinkTotalsRecord
                                        .where(
                                          'ownerUid',
                                          isEqualTo: currentUserReference?.id,
                                        )
                                        .where(
                                          'removed',
                                          isEqualTo: false,
                                        )
                                        .orderBy('name'),
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 50.0,
                                      height: 50.0,
                                      child: SpinKitWave(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 50.0,
                                      ),
                                    ),
                                  );
                                }
                                List<DrinkTotalsRecord>
                                    listViewDrinkTotalsRecordList =
                                    snapshot.data!;

                                return ListView.separated(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount:
                                      listViewDrinkTotalsRecordList.length,
                                  separatorBuilder: (_, __) =>
                                      SizedBox(height: 20.0),
                                  itemBuilder: (context, listViewIndex) {
                                    final listViewDrinkTotalsRecord =
                                        listViewDrinkTotalsRecordList[
                                            listViewIndex];
                                    return DrinkWidget(
                                      key: Key(
                                          'Keydun_${listViewIndex}_of_${listViewDrinkTotalsRecordList.length}'),
                                      drinksTotalsDoc:
                                          listViewDrinkTotalsRecord,
                                    );
                                  },
                                );
                              },
                            ),
                          ].divide(SizedBox(height: 25.0)),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.83),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 60.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FlutterFlowIconButton(
                              borderColor: Color(0xFFFFFF00),
                              borderRadius: 20.0,
                              borderWidth: 2.0,
                              buttonSize: 40.0,
                              fillColor: FlutterFlowTheme.of(context).error,
                              icon: Icon(
                                Icons.undo,
                                color: Colors.white,
                                size: 25.0,
                              ),
                              onPressed: () async {
                                _model.undoLog = await actions.undoLastDrink(
                                  context,
                                );
                                _model.totalMlUndo = await actions.getTotalMl(
                                  context,
                                );
                                FFAppState().totalMl = _model.totalMlUndo!;
                                safeSetState(() {});

                                safeSetState(() {});
                              },
                            ),
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5.0,
                                    color: Color(0x33FC0303),
                                    offset: Offset(
                                      0.0,
                                      2.0,
                                    ),
                                    spreadRadius: 5.0,
                                  )
                                ],
                                gradient: LinearGradient(
                                  colors: [
                                    FlutterFlowTheme.of(context).primary,
                                    FlutterFlowTheme.of(context).secondary
                                  ],
                                  stops: [0.0, 1.0],
                                  begin: AlignmentDirectional(0.0, -1.0),
                                  end: AlignmentDirectional(0, 1.0),
                                ),
                                borderRadius: BorderRadius.circular(24.0),
                                border: Border.all(
                                  color: Color(0xFF050505),
                                ),
                              ),
                              child: FlutterFlowTimer(
                                initialTime: _model.timerInitialTimeMs,
                                getDisplayTime: (value) =>
                                    StopWatchTimer.getDisplayTime(value,
                                        milliSecond: false),
                                controller: _model.timerController,
                                updateStateInterval:
                                    Duration(milliseconds: 1000),
                                onChanged: (value, displayTime, shouldUpdate) {
                                  _model.timerMilliseconds = value;
                                  _model.timerValue = displayTime;
                                  if (shouldUpdate) safeSetState(() {});
                                },
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .override(
                                      font: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .headlineSmall
                                            .fontStyle,
                                      ),
                                      color: Colors.black,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .headlineSmall
                                          .fontStyle,
                                    ),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              elevation: 10.0,
                              shape: const CircleBorder(),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.contain,
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    image: Image.asset(
                                      'assets/images/AnotherAIGeneratedImageOfABeer.png',
                                    ).image,
                                  ),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Color(0xFFFAFF00),
                                  ),
                                ),
                                child: Opacity(
                                  opacity: 0.0,
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 25.0, 0.0, 0.0),
                                    child: FlutterFlowIconButton(
                                      key: ValueKey('addDrinkButton_cyik'),
                                      borderRadius: 20.0,
                                      buttonSize: 74.7,
                                      icon: Icon(
                                        Icons.add,
                                        size: 35.0,
                                      ),
                                      onPressed: () async {
                                        await showModalBottomSheet(
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (context) {
                                            return GestureDetector(
                                              onTap: () {
                                                FocusScope.of(context)
                                                    .unfocus();
                                                FocusManager
                                                    .instance.primaryFocus
                                                    ?.unfocus();
                                              },
                                              child: Padding(
                                                padding:
                                                    MediaQuery.viewInsetsOf(
                                                        context),
                                                child: AddDrinkWidget(),
                                              ),
                                            );
                                          },
                                        ).then((value) => safeSetState(() {}));
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ].divide(SizedBox(width: () {
                            if (MediaQuery.sizeOf(context).width <
                                kBreakpointSmall) {
                              return 60.0;
                            } else if (MediaQuery.sizeOf(context).width <
                                kBreakpointMedium) {
                              return 80.0;
                            } else if (MediaQuery.sizeOf(context).width <
                                kBreakpointLarge) {
                              return 125.0;
                            } else {
                              return 80.0;
                            }
                          }())),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(1.0, 1.01),
                      child: Container(
                        width: double.infinity,
                        height: 89.0,
                        constraints: BoxConstraints(
                          minWidth: double.infinity,
                          maxWidth: double.infinity,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              FlutterFlowTheme.of(context).primary,
                              FlutterFlowTheme.of(context).secondary
                            ],
                            stops: [0.0, 1.0],
                            begin: AlignmentDirectional(0.0, -1.0),
                            end: AlignmentDirectional(0, 1.0),
                          ),
                          shape: BoxShape.rectangle,
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              FlutterFlowIconButton(
                                borderRadius: 8.0,
                                buttonSize: 50.0,
                                icon: Icon(
                                  Icons.query_stats,
                                  color: FlutterFlowTheme.of(context).info,
                                  size: 35.0,
                                ),
                                onPressed: () {
                                  print('Progress pressed ...');
                                },
                              ),
                              FlutterFlowIconButton(
                                borderRadius: 8.0,
                                buttonSize: 50.0,
                                icon: Icon(
                                  Icons.timer_sharp,
                                  color: FlutterFlowTheme.of(context).info,
                                  size: 35.0,
                                ),
                                onPressed: () {
                                  print('Timer pressed ...');
                                },
                              ),
                              FlutterFlowIconButton(
                                borderRadius: 8.0,
                                buttonSize: 50.0,
                                icon: Icon(
                                  Icons.notifications_sharp,
                                  color: FlutterFlowTheme.of(context).info,
                                  size: 35.0,
                                ),
                                onPressed: () {
                                  print('NotificationsSwitch pressed ...');
                                },
                              ),
                              FlutterFlowIconButton(
                                borderRadius: 8.0,
                                buttonSize: 50.0,
                                icon: Icon(
                                  Icons.settings_outlined,
                                  color: FlutterFlowTheme.of(context).info,
                                  size: 35.0,
                                ),
                                onPressed: () async {
                                  context.pushNamed(
                                      ProfileEditingWidget.routeName);
                                },
                              ),
                              Material(
                                color: Colors.transparent,
                                elevation: 25.0,
                                shape: const CircleBorder(),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFFFBF12D),
                                        FlutterFlowTheme.of(context).secondary
                                      ],
                                      stops: [0.0, 1.0],
                                      begin: AlignmentDirectional(0.0, 1.0),
                                      end: AlignmentDirectional(0, -1.0),
                                    ),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                  ),
                                  child: Icon(
                                    FFIcons.kpicsvgDownload,
                                    color: Colors.black,
                                    size: 60.0,
                                  ),
                                ),
                              ),
                            ]
                                .divide(SizedBox(
                                    width: MediaQuery.sizeOf(context).width <
                                            kBreakpointSmall
                                        ? 15.0
                                        : 25.0))
                                .addToStart(SizedBox(width: 25.0)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
