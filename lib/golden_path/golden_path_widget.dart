import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/app_info_widget.dart';
import '/components/custom_settings_for_progress_bars_widget.dart';
import '/components/drink_widget.dart';
import '/components/time_since_last_drink_widget.dart';
import '/components/time_until_sober_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/add_drink/add_drink/add_drink_widget.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
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

class _GoldenPathWidgetState extends State<GoldenPathWidget>
    with TickerProviderStateMixin {
  late GoldenPathModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

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
      _model.totGrams = await actions.getTotalAlcoholGrams();
      FFAppState().totalMl = _model.totalMlResult!;
      FFAppState().currentBAC = functions.calculateBac(
          _model.totGrams!,
          valueOrDefault(currentUserDocument?.weightLbs, 0) > 0
              ? functions
                  .lbsToKg(valueOrDefault(currentUserDocument?.weightLbs, 0))!
              : valueOrDefault(currentUserDocument?.weightKg, 0),
          valueOrDefault(currentUserDocument?.gender, ''),
          functions.elapseSinceFirstDrinkMs(
              valueOrDefault(currentUserDocument?.firstDrinkTimestampMs, 0))!);
      FFAppState().bacRatio = FFAppState().currentBAC;
      safeSetState(() {});
      if (FFAppState().currentBAC >= 0.0) {
        while (FFAppState().currentBAC <= 0.3) {
          _model.totGrams2 = await actions.getTotalAlcoholGrams();
          _model.totalMil = await actions.getTotalMl(
            context,
          );
          FFAppState().currentBAC = functions.calculateBac(
              _model.totGrams2!,
              valueOrDefault(currentUserDocument?.weightLbs, 0) > 0
                  ? functions.lbsToKg(
                      valueOrDefault(currentUserDocument?.weightLbs, 0))!
                  : valueOrDefault(currentUserDocument?.weightKg, 0),
              valueOrDefault(currentUserDocument?.gender, ''),
              functions.elapseSinceFirstDrinkMs(valueOrDefault(
                  currentUserDocument?.firstDrinkTimestampMs, 0))!);
          FFAppState().bacRatio = functions.bacProgressRatio(
              FFAppState().currentBAC,
              valueOrDefault(currentUserDocument?.bacLimit, ''))!;
          FFAppState().ratioMl = functions.progressRatio(_model.totalMil!,
              valueOrDefault(currentUserDocument?.volumeLimit, ''));
          FFAppState().totalMl = _model.totalMil!;
          safeSetState(() {});
        }
      } else {
        return;
      }
    });

    animationsMap.addAll({
      'containerOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          BlurEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(0.0, 0.0),
            end: Offset(4.0, 4.0),
          ),
        ],
      ),
      'timeUntilSoberOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          FlipEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1000.0.ms,
            begin: 0.0,
            end: 2.0,
          ),
        ],
      ),
      'timeSinceLastDrinkOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          FlipEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1000.0.ms,
            begin: 0.0,
            end: 2.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            color: FlutterFlowTheme.of(context).primary,
            angle: 0.524,
          ),
        ],
      ),
      'iconButtonOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            color: FlutterFlowTheme.of(context).primary,
            angle: 0.524,
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

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

    return StreamBuilder<List<UsersRecord>>(
      stream: queryUsersRecord(
        queryBuilder: (usersRecord) => usersRecord.where(
          'uid',
          isEqualTo: currentUserReference?.id,
        ),
        singleRecord: true,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Color(0xFFFFEBCA),
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: SpinKitWave(
                  color: Color(0xFFFBC02D),
                  size: 50.0,
                ),
              ),
            ),
          );
        }
        List<UsersRecord> goldenPathUsersRecordList = snapshot.data!;
        final goldenPathUsersRecord = goldenPathUsersRecordList.isNotEmpty
            ? goldenPathUsersRecordList.first
            : null;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Color(0xFFFFEBCA),
            body: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: () {
                          if (MediaQuery.sizeOf(context).width <
                              kBreakpointSmall) {
                            return 360.0;
                          } else if (MediaQuery.sizeOf(context).width >=
                                  kBreakpointMedium
                              ? false
                              : false) {
                            return 400.0;
                          } else {
                            return 500.0;
                          }
                        }(),
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            FlutterFlowTheme.of(context).secondary,
                            Color(0x5FFDBF2B)
                          ],
                          stops: [0.0, 1.0],
                          begin: AlignmentDirectional(0.0, -1.0),
                          end: AlignmentDirectional(0, 1.0),
                        ),
                        borderRadius: BorderRadius.circular(0.0),
                        shape: BoxShape.rectangle,
                      ),
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Stack(
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Stack(
                              children: [
                                SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 10.0, 0.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -0.97, -0.98),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  await showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    context: context,
                                                    builder: (context) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          FocusScope.of(context)
                                                              .unfocus();
                                                          FocusManager.instance
                                                              .primaryFocus
                                                              ?.unfocus();
                                                        },
                                                        child: Padding(
                                                          padding: MediaQuery
                                                              .viewInsetsOf(
                                                                  context),
                                                          child:
                                                              AppInfoWidget(),
                                                        ),
                                                      );
                                                    },
                                                  ).then((value) =>
                                                      safeSetState(() {}));
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: Color(0xFF020202),
                                                    ),
                                                  ),
                                                  child: InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      await showModalBottomSheet(
                                                        isScrollControlled:
                                                            true,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        context: context,
                                                        builder: (context) {
                                                          return GestureDetector(
                                                            onTap: () {
                                                              FocusScope.of(
                                                                      context)
                                                                  .unfocus();
                                                              FocusManager
                                                                  .instance
                                                                  .primaryFocus
                                                                  ?.unfocus();
                                                            },
                                                            child: Padding(
                                                              padding: MediaQuery
                                                                  .viewInsetsOf(
                                                                      context),
                                                              child:
                                                                  AppInfoWidget(),
                                                            ),
                                                          );
                                                        },
                                                      ).then((value) =>
                                                          safeSetState(() {}));
                                                    },
                                                    child: Icon(
                                                      Icons.question_mark,
                                                      color: Color(0xFF070000),
                                                      size: 25.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                await showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  context: context,
                                                  builder: (context) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        FocusScope.of(context)
                                                            .unfocus();
                                                        FocusManager.instance
                                                            .primaryFocus
                                                            ?.unfocus();
                                                      },
                                                      child: Padding(
                                                        padding: MediaQuery
                                                            .viewInsetsOf(
                                                                context),
                                                        child:
                                                            CustomSettingsForProgressBarsWidget(),
                                                      ),
                                                    );
                                                  },
                                                ).then((value) =>
                                                    safeSetState(() {}));
                                              },
                                              child: Icon(
                                                Icons.settings_suggest_outlined,
                                                color: Colors.black,
                                                size: 40.0,
                                              ),
                                            ),
                                          ].divide(SizedBox(width: 250.0)),
                                        ),
                                      ),
                                      if (_model.timersON)
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Stack(
                                                children: [
                                                  Opacity(
                                                    opacity: _model.timerOn
                                                        ? 0.0
                                                        : 1.0,
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await Future.wait([
                                                          Future(() async {
                                                            if (animationsMap[
                                                                    'timeUntilSoberOnActionTriggerAnimation'] !=
                                                                null) {
                                                              animationsMap[
                                                                      'timeUntilSoberOnActionTriggerAnimation']!
                                                                  .controller
                                                                  .forward(
                                                                      from:
                                                                          0.0);
                                                            }
                                                          }),
                                                          Future(() async {
                                                            if (animationsMap[
                                                                    'timeSinceLastDrinkOnActionTriggerAnimation'] !=
                                                                null) {
                                                              animationsMap[
                                                                      'timeSinceLastDrinkOnActionTriggerAnimation']!
                                                                  .controller
                                                                  .forward(
                                                                      from:
                                                                          0.0);
                                                            }
                                                          }),
                                                        ]);
                                                        await Future.delayed(
                                                          Duration(
                                                            milliseconds: 350,
                                                          ),
                                                        );
                                                        if (animationsMap[
                                                                'timeUntilSoberOnActionTriggerAnimation'] !=
                                                            null) {
                                                          animationsMap[
                                                                  'timeUntilSoberOnActionTriggerAnimation']!
                                                              .controller
                                                              .stop();
                                                        }
                                                        _model.timerOn = true;
                                                        safeSetState(() {});
                                                      },
                                                      child: wrapWithModel(
                                                        model: _model
                                                            .timeUntilSoberModel,
                                                        updateCallback: () =>
                                                            safeSetState(() {}),
                                                        child:
                                                            TimeUntilSoberWidget(),
                                                      ),
                                                    ).animateOnActionTrigger(
                                                      animationsMap[
                                                          'timeUntilSoberOnActionTriggerAnimation']!,
                                                    ),
                                                  ),
                                                  Opacity(
                                                    opacity: _model.timerOn
                                                        ? 1.0
                                                        : 0.0,
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await Future.wait([
                                                          Future(() async {
                                                            if (animationsMap[
                                                                    'timeUntilSoberOnActionTriggerAnimation'] !=
                                                                null) {
                                                              animationsMap[
                                                                      'timeUntilSoberOnActionTriggerAnimation']!
                                                                  .controller
                                                                  .forward(
                                                                      from:
                                                                          0.0);
                                                            }
                                                          }),
                                                          Future(() async {
                                                            if (animationsMap[
                                                                    'timeSinceLastDrinkOnActionTriggerAnimation'] !=
                                                                null) {
                                                              animationsMap[
                                                                      'timeSinceLastDrinkOnActionTriggerAnimation']!
                                                                  .controller
                                                                  .forward(
                                                                      from:
                                                                          0.0);
                                                            }
                                                          }),
                                                        ]);
                                                        await Future.delayed(
                                                          Duration(
                                                            milliseconds: 350,
                                                          ),
                                                        );
                                                        if (animationsMap[
                                                                'timeSinceLastDrinkOnActionTriggerAnimation'] !=
                                                            null) {
                                                          animationsMap[
                                                                  'timeSinceLastDrinkOnActionTriggerAnimation']!
                                                              .controller
                                                              .stop();
                                                        }
                                                        _model.timerOn = false;
                                                        safeSetState(() {});
                                                      },
                                                      child: wrapWithModel(
                                                        model: _model
                                                            .timeSinceLastDrinkModel,
                                                        updateCallback: () =>
                                                            safeSetState(() {}),
                                                        child:
                                                            TimeSinceLastDrinkWidget(),
                                                      ),
                                                    ).animateOnActionTrigger(
                                                      animationsMap[
                                                          'timeSinceLastDrinkOnActionTriggerAnimation']!,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0,
                                            valueOrDefault<double>(
                                              !_model.timersON ? 50.0 : 0.0,
                                              0.0,
                                            ),
                                            0.0,
                                            0.0),
                                        child: Stack(
                                          children: [
                                            if (!_model.progressBarBAC)
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 25.0, 0.0, 0.0),
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    elevation: 4.0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24.0),
                                                    ),
                                                    child: Container(
                                                      width: 320.6,
                                                      decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            blurRadius: 4.0,
                                                            color: FFAppState()
                                                                        .currentBAC >
                                                                    0.0
                                                                ? Color(
                                                                    0x33000000)
                                                                : Color(
                                                                    0xFFFFEAB6),
                                                            offset: Offset(
                                                              0.0,
                                                              2.0,
                                                            ),
                                                            spreadRadius: 0.0,
                                                          )
                                                        ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(24.0),
                                                        border: Border.all(
                                                          color:
                                                              Color(0x00FFFFFF),
                                                          width: 5.0,
                                                        ),
                                                      ),
                                                      child: Visibility(
                                                        visible: !_model
                                                            .progressBarBAC,
                                                        child:
                                                            AuthUserStreamWidget(
                                                          builder: (context) =>
                                                              InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              _model.progressBarBAC =
                                                                  true;
                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            child:
                                                                LinearPercentIndicator(
                                                              percent: functions
                                                                  .progressRatio(
                                                                      valueOrDefault<
                                                                          double>(
                                                                        FFAppState()
                                                                            .totalMl,
                                                                        0.0,
                                                                      ),
                                                                      valueOrDefault<
                                                                          String>(
                                                                        valueOrDefault(
                                                                            currentUserDocument?.volumeLimit,
                                                                            ''),
                                                                        '100',
                                                                      )),
                                                              width: 310.0,
                                                              lineHeight: 50.0,
                                                              animation: true,
                                                              animateFromLastPercent:
                                                                  true,
                                                              progressColor:
                                                                  () {
                                                                if (FFAppState()
                                                                        .ratioMl <=
                                                                    0.33) {
                                                                  return Color(
                                                                      0xFF00FF00);
                                                                } else if (FFAppState()
                                                                        .ratioMl <=
                                                                    0.66) {
                                                                  return Color(
                                                                      0xFFFFF400);
                                                                } else {
                                                                  return Color(
                                                                      0xFFFF0000);
                                                                }
                                                              }(),
                                                              backgroundColor:
                                                                  Color(
                                                                      0xFFFFEAB6),
                                                              center: Text(
                                                                functions
                                                                    .formatProgressString(
                                                                        valueOrDefault<
                                                                            double>(
                                                                          FFAppState()
                                                                              .totalMl,
                                                                          0.0,
                                                                        ),
                                                                        valueOrDefault<
                                                                            String>(
                                                                          valueOrDefault(
                                                                              currentUserDocument?.volumeLimit,
                                                                              ''),
                                                                          '100',
                                                                        )),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineSmall
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .poppins(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .headlineSmall
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .headlineSmall
                                                                            .fontStyle,
                                                                      ),
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          20.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .headlineSmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .headlineSmall
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                              barRadius: Radius
                                                                  .circular(
                                                                      15.0),
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            if (_model.progressBarBAC)
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 25.0, 0.0, 0.0),
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    elevation: 4.0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24.0),
                                                    ),
                                                    child: Container(
                                                      width: 320.6,
                                                      decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            blurRadius: 4.0,
                                                            color: FFAppState()
                                                                        .currentBAC >
                                                                    0.0
                                                                ? Color(
                                                                    0x33000000)
                                                                : Color(
                                                                    0xFFFFEAB6),
                                                            offset: Offset(
                                                              0.0,
                                                              2.0,
                                                            ),
                                                            spreadRadius: 0.0,
                                                          )
                                                        ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(24.0),
                                                        border: Border.all(
                                                          color:
                                                              Color(0x00FFFFFF),
                                                          width: 5.0,
                                                        ),
                                                      ),
                                                      child: Visibility(
                                                        visible: _model
                                                            .progressBarBAC,
                                                        child:
                                                            AuthUserStreamWidget(
                                                          builder: (context) =>
                                                              InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              _model.progressBarBAC =
                                                                  false;
                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            child:
                                                                LinearPercentIndicator(
                                                              percent:
                                                                  FFAppState()
                                                                      .bacRatio,
                                                              width: 310.0,
                                                              lineHeight: 50.0,
                                                              animation: true,
                                                              animateFromLastPercent:
                                                                  true,
                                                              progressColor:
                                                                  () {
                                                                if (FFAppState()
                                                                        .bacRatio <=
                                                                    0.33) {
                                                                  return Color(
                                                                      0xFF00FF00);
                                                                } else if (FFAppState()
                                                                        .bacRatio <=
                                                                    0.66) {
                                                                  return Color(
                                                                      0xFFFFF400);
                                                                } else {
                                                                  return Color(
                                                                      0xFFFF0000);
                                                                }
                                                              }(),
                                                              backgroundColor:
                                                                  Color(
                                                                      0xFFFFEAB6),
                                                              center: Text(
                                                                functions
                                                                    .bacProgressLabel(
                                                                        FFAppState()
                                                                            .currentBAC,
                                                                        valueOrDefault<
                                                                            String>(
                                                                          valueOrDefault(
                                                                              currentUserDocument?.bacLimit,
                                                                              ''),
                                                                          '0.08',
                                                                        ))!,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineSmall
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .poppins(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .headlineSmall
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .headlineSmall
                                                                            .fontStyle,
                                                                      ),
                                                                      color: Color(
                                                                          0xFF020202),
                                                                      fontSize:
                                                                          20.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .headlineSmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .headlineSmall
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                              barRadius: Radius
                                                                  .circular(
                                                                      15.0),
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(0x36FBC02D),
                                                Color(0x46FBC02D)
                                              ],
                                              stops: [0.0, 1.0],
                                              begin: AlignmentDirectional(
                                                  0.0, -1.0),
                                              end: AlignmentDirectional(0, 1.0),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(24.0),
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: StreamBuilder<
                                              List<DrinkTotalsRecord>>(
                                            stream: queryDrinkTotalsRecord(
                                              queryBuilder:
                                                  (drinkTotalsRecord) =>
                                                      drinkTotalsRecord
                                                          .where(
                                                            'ownerUid',
                                                            isEqualTo:
                                                                currentUserReference
                                                                    ?.id,
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
                                                      color: Color(0xFFFBC02D),
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
                                                    listViewDrinkTotalsRecordList
                                                        .length,
                                                separatorBuilder: (_, __) =>
                                                    SizedBox(height: 20.0),
                                                itemBuilder:
                                                    (context, listViewIndex) {
                                                  final listViewDrinkTotalsRecord =
                                                      listViewDrinkTotalsRecordList[
                                                          listViewIndex];
                                                  return DrinkWidget(
                                                    key: Key(
                                                        'Keyin3_${listViewIndex}_of_${listViewDrinkTotalsRecordList.length}'),
                                                    drinksTotalsDoc:
                                                        listViewDrinkTotalsRecord,
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ].divide(SizedBox(height: 25.0)),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(1.0, 1.01),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 2.0),
                                    child: Material(
                                      color: Colors.transparent,
                                      elevation: 2.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                      ),
                                      child: Container(
                                        width: double.infinity,
                                        height: 89.0,
                                        constraints: BoxConstraints(
                                          minWidth: double.infinity,
                                          maxWidth: double.infinity,
                                        ),
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 4.0,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              offset: Offset(
                                                0.0,
                                                2.0,
                                              ),
                                              spreadRadius: 2.0,
                                            )
                                          ],
                                          gradient: LinearGradient(
                                            colors: [
                                              FlutterFlowTheme.of(context)
                                                  .secondary,
                                              FlutterFlowTheme.of(context)
                                                  .secondary
                                            ],
                                            stops: [0.0, 1.0],
                                            begin:
                                                AlignmentDirectional(0.0, -1.0),
                                            end: AlignmentDirectional(0, 1.0),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(24.0),
                                          shape: BoxShape.rectangle,
                                        ),
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(0.0),
                                              child: BackdropFilter(
                                                filter: ImageFilter.blur(
                                                  sigmaX: 2.0,
                                                  sigmaY: 2.0,
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24.0),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Stack(
                                                            children: [
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  gradient:
                                                                      LinearGradient(
                                                                    colors: [
                                                                      Colors
                                                                          .white,
                                                                      Color(
                                                                          0xFFFFA400)
                                                                    ],
                                                                    stops: [
                                                                      0.0,
                                                                      1.0
                                                                    ],
                                                                    begin:
                                                                        AlignmentDirectional(
                                                                            0.0,
                                                                            -1.0),
                                                                    end: AlignmentDirectional(
                                                                        0, 1.0),
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12.0),
                                                                  border: Border
                                                                      .all(
                                                                    color: Color(
                                                                        0xFFFBC02D),
                                                                  ),
                                                                ),
                                                                child:
                                                                    Visibility(
                                                                  visible: _model
                                                                      .timersON,
                                                                  child:
                                                                      FlutterFlowIconButton(
                                                                    borderRadius:
                                                                        8.0,
                                                                    buttonSize:
                                                                        50.0,
                                                                    icon: Icon(
                                                                      Icons
                                                                          .timer_sharp,
                                                                      color: Colors
                                                                          .black,
                                                                      size:
                                                                          35.0,
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      _model.timersON =
                                                                          false;
                                                                      safeSetState(
                                                                          () {});
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                              Material(
                                                                color: Colors
                                                                    .transparent,
                                                                elevation: 3.0,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12.0),
                                                                ),
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        blurRadius:
                                                                            4.0,
                                                                        color: Color(
                                                                            0x33000000),
                                                                        offset:
                                                                            Offset(
                                                                          0.0,
                                                                          2.0,
                                                                        ),
                                                                      )
                                                                    ],
                                                                    gradient:
                                                                        LinearGradient(
                                                                      colors: [
                                                                        Colors
                                                                            .white,
                                                                        Color(
                                                                            0xFFFFA400)
                                                                      ],
                                                                      stops: [
                                                                        0.0,
                                                                        0.75
                                                                      ],
                                                                      begin: AlignmentDirectional(
                                                                          0.94,
                                                                          -1.0),
                                                                      end: AlignmentDirectional(
                                                                          -0.94,
                                                                          1.0),
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12.0),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Color(
                                                                          0xFFFBC02D),
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      Visibility(
                                                                    visible: !_model
                                                                        .timersON,
                                                                    child:
                                                                        FlutterFlowIconButton(
                                                                      borderRadius:
                                                                          8.0,
                                                                      buttonSize:
                                                                          50.0,
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .timer_off_outlined,
                                                                        color: Colors
                                                                            .black,
                                                                        size:
                                                                            35.0,
                                                                      ),
                                                                      onPressed:
                                                                          () async {
                                                                        _model.timersON =
                                                                            true;
                                                                        safeSetState(
                                                                            () {});
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Material(
                                                            color: Colors
                                                                .transparent,
                                                            elevation: 3.0,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0),
                                                            ),
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    blurRadius:
                                                                        4.0,
                                                                    color: Color(
                                                                        0x33000000),
                                                                    offset:
                                                                        Offset(
                                                                      0.0,
                                                                      2.0,
                                                                    ),
                                                                  )
                                                                ],
                                                                gradient:
                                                                    LinearGradient(
                                                                  colors: [
                                                                    Colors
                                                                        .white,
                                                                    Color(
                                                                        0xFFFFA400)
                                                                  ],
                                                                  stops: [
                                                                    0.0,
                                                                    0.75
                                                                  ],
                                                                  begin:
                                                                      AlignmentDirectional(
                                                                          0.94,
                                                                          -1.0),
                                                                  end:
                                                                      AlignmentDirectional(
                                                                          -0.94,
                                                                          1.0),
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12.0),
                                                                border:
                                                                    Border.all(
                                                                  color: Color(
                                                                      0xFFFBC02D),
                                                                ),
                                                              ),
                                                              child:
                                                                  FlutterFlowIconButton(
                                                                borderRadius:
                                                                    8.0,
                                                                buttonSize:
                                                                    50.0,
                                                                icon: Icon(
                                                                  Icons
                                                                      .notifications_sharp,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 35.0,
                                                                ),
                                                                onPressed: () {
                                                                  print(
                                                                      'NotificationsSwitch pressed ...');
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            width: 20.0)),
                                                      ),
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Material(
                                                            color: Colors
                                                                .transparent,
                                                            elevation: 10.0,
                                                            shape:
                                                                const CircleBorder(),
                                                            child: Container(
                                                              width: 80.0,
                                                              height: 80.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                                  fit: BoxFit
                                                                      .contain,
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          0.0),
                                                                  image: Image
                                                                      .asset(
                                                                    'assets/images/ChatGPT_Image_Dec_1,_2025,_12_00_54_AM.png',
                                                                  ).image,
                                                                ),
                                                                shape: BoxShape
                                                                    .circle,
                                                                border:
                                                                    Border.all(
                                                                  color: Color(
                                                                      0xFFFAFF00),
                                                                ),
                                                              ),
                                                              child: Opacity(
                                                                opacity: 0.0,
                                                                child:
                                                                    FlutterFlowIconButton(
                                                                  key: ValueKey(
                                                                      'addDrinkButton_pvbj'),
                                                                  borderRadius:
                                                                      20.0,
                                                                  buttonSize:
                                                                      80.4,
                                                                  icon: Icon(
                                                                    Icons.add,
                                                                    size: 60.0,
                                                                  ),
                                                                  onPressed:
                                                                      () async {
                                                                    if (animationsMap[
                                                                            'containerOnActionTriggerAnimation'] !=
                                                                        null) {
                                                                      await animationsMap[
                                                                              'containerOnActionTriggerAnimation']!
                                                                          .controller
                                                                          .forward(
                                                                              from: 0.0);
                                                                    }
                                                                    await showModalBottomSheet(
                                                                      isScrollControlled:
                                                                          true,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            FocusScope.of(context).unfocus();
                                                                            FocusManager.instance.primaryFocus?.unfocus();
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                MediaQuery.viewInsetsOf(context),
                                                                            child:
                                                                                AddDrinkWidget(),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ).then((value) =>
                                                                        safeSetState(
                                                                            () {}));

                                                                    if (animationsMap[
                                                                            'containerOnActionTriggerAnimation'] !=
                                                                        null) {
                                                                      animationsMap[
                                                                              'containerOnActionTriggerAnimation']!
                                                                          .controller
                                                                          .reset();
                                                                    }
                                                                  },
                                                                ).animateOnPageLoad(
                                                                        animationsMap[
                                                                            'iconButtonOnPageLoadAnimation']!),
                                                              ),
                                                            ),
                                                          ).animateOnPageLoad(
                                                              animationsMap[
                                                                  'containerOnPageLoadAnimation']!),
                                                          InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              var _shouldSetState =
                                                                  false;
                                                              _model.barcode =
                                                                  await FlutterBarcodeScanner
                                                                      .scanBarcode(
                                                                '#C62828', // scanning line color
                                                                'Cancel', // cancel button text
                                                                true, // whether to show the flash icon
                                                                ScanMode.QR,
                                                              );

                                                              _shouldSetState =
                                                                  true;
                                                              _model.apiResultfi4 =
                                                                  await BarcodeInfoFetchCall
                                                                      .call();

                                                              _shouldSetState =
                                                                  true;
                                                              if ((_model
                                                                      .apiResultfi4
                                                                      ?.succeeded ??
                                                                  true)) {
                                                                FFAppState()
                                                                        .drinkName =
                                                                    getJsonField(
                                                                  (_model.apiResultfi4
                                                                          ?.jsonBody ??
                                                                      ''),
                                                                  r'''$.products[:].title''',
                                                                ).toString();
                                                                FFAppState()
                                                                        .drinkBrand =
                                                                    getJsonField(
                                                                  (_model.apiResultfi4
                                                                          ?.jsonBody ??
                                                                      ''),
                                                                  r'''$.products[:].brand''',
                                                                ).toString();
                                                                FFAppState()
                                                                        .drinkDescription =
                                                                    getJsonField(
                                                                  (_model.apiResultfi4
                                                                          ?.jsonBody ??
                                                                      ''),
                                                                  r'''$.products[:].description''',
                                                                ).toString();
                                                                FFAppState()
                                                                        .imageURL =
                                                                    getJsonField(
                                                                  (_model.apiResultfi4
                                                                          ?.jsonBody ??
                                                                      ''),
                                                                  r'''$.products[:].images''',
                                                                ).toString();
                                                                FFAppState()
                                                                        .drinkSize =
                                                                    getJsonField(
                                                                  (_model.apiResultfi4
                                                                          ?.jsonBody ??
                                                                      ''),
                                                                  r'''$.products[:].manufacturer''',
                                                                ).toString();
                                                                safeSetState(
                                                                    () {});
                                                              } else {
                                                                if (_shouldSetState)
                                                                  safeSetState(
                                                                      () {});
                                                                return;
                                                              }

                                                              context.pushNamed(
                                                                BarcodeResultsWidget
                                                                    .routeName,
                                                                queryParameters:
                                                                    {
                                                                  'apiResult':
                                                                      serializeParam(
                                                                    (_model.apiResultfi4
                                                                            ?.jsonBody ??
                                                                        ''),
                                                                    ParamType
                                                                        .JSON,
                                                                  ),
                                                                }.withoutNulls,
                                                                extra: <String,
                                                                    dynamic>{
                                                                  kTransitionInfoKey:
                                                                      TransitionInfo(
                                                                    hasTransition:
                                                                        true,
                                                                    transitionType:
                                                                        PageTransitionType
                                                                            .fade,
                                                                  ),
                                                                },
                                                              );

                                                              if (_shouldSetState)
                                                                safeSetState(
                                                                    () {});
                                                            },
                                                            child: Material(
                                                              color: Colors
                                                                  .transparent,
                                                              elevation: 5.0,
                                                              shape:
                                                                  const CircleBorder(),
                                                              child: Container(
                                                                width: 60.0,
                                                                height: 60.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  image:
                                                                      DecorationImage(
                                                                    fit: BoxFit
                                                                        .none,
                                                                    image: Image
                                                                        .asset(
                                                                      'assets/images/CameraIconImage.webp',
                                                                    ).image,
                                                                  ),
                                                                  gradient:
                                                                      LinearGradient(
                                                                    colors: [
                                                                      Color(
                                                                          0xFFFBF12D),
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondary
                                                                    ],
                                                                    stops: [
                                                                      0.0,
                                                                      1.0
                                                                    ],
                                                                    begin:
                                                                        AlignmentDirectional(
                                                                            0.0,
                                                                            1.0),
                                                                    end: AlignmentDirectional(
                                                                        0,
                                                                        -1.0),
                                                                  ),
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            width: 20.0)),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 50.0)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ).animateOnActionTrigger(
                      animationsMap['containerOnActionTriggerAnimation']!,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
