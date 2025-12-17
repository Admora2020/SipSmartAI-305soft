import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:math';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'time_until_sober_model.dart';
export 'time_until_sober_model.dart';

class TimeUntilSoberWidget extends StatefulWidget {
  const TimeUntilSoberWidget({super.key});

  @override
  State<TimeUntilSoberWidget> createState() => _TimeUntilSoberWidgetState();
}

class _TimeUntilSoberWidgetState extends State<TimeUntilSoberWidget>
    with TickerProviderStateMixin {
  late TimeUntilSoberModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TimeUntilSoberModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.totalGrams1 = await actions.getTotalAlcoholGrams();
      _model.totalAlcGrams = _model.totalGrams1;
      _model.elapsedTime = functions.elapseSinceFirstDrinkMs(
          valueOrDefault(currentUserDocument?.firstDrinkTimestampMs, 0));
      _model.currentBAC = functions.calculateBac(
          _model.totalGrams1!,
          valueOrDefault(currentUserDocument?.weightLbs, 0) > 0
              ? functions
                  .lbsToKg(valueOrDefault(currentUserDocument?.weightLbs, 0))!
              : valueOrDefault(currentUserDocument?.weightKg, 0),
          valueOrDefault(currentUserDocument?.gender, ''),
          functions.elapseSinceFirstDrinkMs(
              valueOrDefault(currentUserDocument?.firstDrinkTimestampMs, 0))!);
      _model.loopCount = 86400;
      safeSetState(() {});
      _model.timerSoberText =
          functions.timeUntilSoberFormatted(_model.currentBAC)!;
      safeSetState(() {});
      await Future.wait([
        Future(() async {
          while (FFAppState().currentBAC >= 0.0) {
            _model.totalGrams2 = await actions.getTotalAlcoholGrams();
            _model.totalAlcGrams = _model.totalGrams2;
            _model.elapsedTime = functions.elapseSinceFirstDrinkMs(
                valueOrDefault(currentUserDocument?.firstDrinkTimestampMs, 0));
            _model.currentBAC = functions.calculateBac(
                _model.totalGrams2!,
                valueOrDefault(currentUserDocument?.weightLbs, 0) > 0
                    ? functions.lbsToKg(
                        valueOrDefault(currentUserDocument?.weightLbs, 0))!
                    : valueOrDefault(currentUserDocument?.weightKg, 0),
                valueOrDefault(currentUserDocument?.gender, ''),
                functions.elapseSinceFirstDrinkMs(valueOrDefault(
                    currentUserDocument?.firstDrinkTimestampMs, 0))!);
            safeSetState(() {});
            _model.timerSoberText =
                functions.timeUntilSoberFormatted(_model.currentBAC)!;
            safeSetState(() {});
            await Future.delayed(
              Duration(
                milliseconds: 1000,
              ),
            );
          }
        }),
        Future(() async {
          while (FFAppState().currentBAC >= 0.0) {
            if (FFAppState().currentBAC <= .059) {
              while (FFAppState().currentBAC <= .059) {
                if (animationsMap['textOnActionTriggerAnimation'] != null) {
                  await animationsMap['textOnActionTriggerAnimation']!
                      .controller
                      .forward(from: 0.0)
                      .whenComplete(
                          animationsMap['textOnActionTriggerAnimation']!
                              .controller
                              .reverse);
                }
              }
            } else {
              if (FFAppState().currentBAC <= .099) {
                while (FFAppState().currentBAC <= .099) {
                  if (animationsMap['textOnActionTriggerAnimation'] != null) {
                    await animationsMap['textOnActionTriggerAnimation']!
                        .controller
                        .forward(from: 0.0)
                        .whenComplete(
                            animationsMap['textOnActionTriggerAnimation']!
                                .controller
                                .reverse);
                  }
                }
              } else {
                if (FFAppState().currentBAC <= .199) {
                  while (FFAppState().currentBAC <= .199) {
                    if (animationsMap['textOnActionTriggerAnimation'] != null) {
                      await animationsMap['textOnActionTriggerAnimation']!
                          .controller
                          .forward(from: 0.0)
                          .whenComplete(
                              animationsMap['textOnActionTriggerAnimation']!
                                  .controller
                                  .reverse);
                    }
                  }
                } else {
                  while (FFAppState().currentBAC <= 1000.0) {
                    if (animationsMap['textOnActionTriggerAnimation'] != null) {
                      await animationsMap['textOnActionTriggerAnimation']!
                          .controller
                          .forward(from: 0.0)
                          .whenComplete(
                              animationsMap['textOnActionTriggerAnimation']!
                                  .controller
                                  .reverse);
                    }
                  }
                }
              }
            }
          }
        }),
      ]);
    });

    animationsMap.addAll({
      'textOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: null,
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
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Material(
        color: Colors.transparent,
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 160.0,
            maxHeight: 100.0,
          ),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 10.0,
                color: Color(0xFFFBC02D),
                offset: Offset(
                  0.0,
                  2.0,
                ),
                spreadRadius: 5.0,
              )
            ],
            gradient: LinearGradient(
              colors: [
                FlutterFlowTheme.of(context).secondary,
                FlutterFlowTheme.of(context).secondary,
                Color(0xFFF7F4EF)
              ],
              stops: [0.0, 0.5, 1.0],
              begin: AlignmentDirectional(0.0, -1.0),
              end: AlignmentDirectional(0, 1.0),
            ),
            borderRadius: BorderRadius.circular(24.0),
            shape: BoxShape.rectangle,
            border: Border.all(
              color: Color(0xFFFFB100),
              width: 5.0,
            ),
          ),
          alignment: AlignmentDirectional(0.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Text(
                  'Completely sober \nin about...',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
                    color: Colors.black,
                    fontSize: 15.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.bold,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    shadows: [
                      Shadow(
                        color: () {
                          if (FFAppState().currentBAC <= .029) {
                            return Color(0x00FAFF00);
                          } else if (FFAppState().currentBAC <= .059) {
                            return Color(0x48000000);
                          } else if (FFAppState().currentBAC <= .099) {
                            return Color(0x80000000);
                          } else if (FFAppState().currentBAC <= .199) {
                            return Color(0xC3000000);
                          } else {
                            return Colors.black;
                          }
                        }(),
                        offset: Offset(() {
                          if (FFAppState().currentBAC <= .029) {
                            return 0.0;
                          } else if (FFAppState().currentBAC <= .059) {
                            return 1.0;
                          } else if (FFAppState().currentBAC <= .099) {
                            return 2.0;
                          } else if (FFAppState().currentBAC <= .199) {
                            return 3.0;
                          } else {
                            return 5.0;
                          }
                        }(), () {
                          if (FFAppState().currentBAC <= .029) {
                            return 0.0;
                          } else if (FFAppState().currentBAC <= .059) {
                            return 1.0;
                          } else if (FFAppState().currentBAC <= .099) {
                            return 2.0;
                          } else if (FFAppState().currentBAC <= .199) {
                            return 3.0;
                          } else {
                            return 5.0;
                          }
                        }()),
                        blurRadius: 0.0,
                      )
                    ],
                  ),
                ).animateOnActionTrigger(
                  animationsMap['textOnActionTriggerAnimation']!,
                  effects: [
                    TiltEffect(
                      curve: Curves.easeInOut,
                      delay: 0.0.ms,
                      duration: 1000.0.ms,
                      begin: Offset(
                          () {
                                if (FFAppState().currentBAC <= .029) {
                                  return 0.0;
                                } else if (FFAppState().currentBAC <= .059) {
                                  return -5.0;
                                } else if (FFAppState().currentBAC <= .099) {
                                  return -10.0;
                                } else if (FFAppState().currentBAC <= .199) {
                                  return -20.0;
                                } else {
                                  return -25.0;
                                }
                              }() *
                              (pi / 180),
                          () {
                                if (FFAppState().currentBAC <= .029) {
                                  return 0.0;
                                } else if (FFAppState().currentBAC <= .059) {
                                  return -5.0;
                                } else if (FFAppState().currentBAC <= .099) {
                                  return -10.0;
                                } else if (FFAppState().currentBAC <= .199) {
                                  return -20.0;
                                } else {
                                  return -25.0;
                                }
                              }() *
                              (pi / 180)),
                      end: Offset(
                          () {
                                if (FFAppState().currentBAC <= .029) {
                                  return 0.0;
                                } else if (FFAppState().currentBAC <= .059) {
                                  return 5.0;
                                } else if (FFAppState().currentBAC <= .099) {
                                  return 10.0;
                                } else if (FFAppState().currentBAC <= .199) {
                                  return 20.0;
                                } else {
                                  return 25.0;
                                }
                              }() *
                              (pi / 180),
                          () {
                                if (FFAppState().currentBAC <= .029) {
                                  return 0.0;
                                } else if (FFAppState().currentBAC <= .059) {
                                  return 5.0;
                                } else if (FFAppState().currentBAC <= .099) {
                                  return 10.0;
                                } else if (FFAppState().currentBAC <= .199) {
                                  return 20.0;
                                } else {
                                  return 25.0;
                                }
                              }() *
                              (pi / 180)),
                    ),
                  ],
                ),
              ),
              Text(
                valueOrDefault<String>(
                  _model.timerSoberText,
                  '00:00:00',
                ),
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                  font: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontStyle:
                        FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                  ),
                  color: Colors.black,
                  fontSize: 20.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.bold,
                  fontStyle:
                      FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                  shadows: [
                    Shadow(
                      color: () {
                        if (FFAppState().currentBAC <= .029) {
                          return Color(0x00FAFF00);
                        } else if (FFAppState().currentBAC <= .059) {
                          return Color(0x48848484);
                        } else if (FFAppState().currentBAC <= .099) {
                          return Color(0x809F9F9F);
                        } else if (FFAppState().currentBAC <= .199) {
                          return Color(0xC3414141);
                        } else {
                          return Colors.black;
                        }
                      }(),
                      offset: Offset(-3.0, 4.0),
                      blurRadius: 1.0,
                    ),
                    Shadow(
                      color: () {
                        if (FFAppState().currentBAC <= .029) {
                          return Color(0x00FAFF00);
                        } else if (FFAppState().currentBAC <= .059) {
                          return Color(0x48848484);
                        } else if (FFAppState().currentBAC <= .099) {
                          return Color(0x809F9F9F);
                        } else if (FFAppState().currentBAC <= .199) {
                          return Color(0xC3414141);
                        } else {
                          return Colors.black;
                        }
                      }(),
                      offset: Offset(3.0, 1.0),
                      blurRadius: 10.0,
                    ),
                    Shadow(
                      color: () {
                        if (FFAppState().currentBAC <= .029) {
                          return Color(0x00FFFFFF);
                        } else if (FFAppState().currentBAC <= .059) {
                          return Color(0x48FFFFFF);
                        } else if (FFAppState().currentBAC <= .099) {
                          return Color(0x8CFFFFFF);
                        } else if (FFAppState().currentBAC <= .199) {
                          return Color(0xC2FFFFFF);
                        } else {
                          return Colors.white;
                        }
                      }(),
                      offset: Offset(5.0, 3.0),
                      blurRadius: 2.0,
                    )
                  ],
                ),
              ),
            ].divide(SizedBox(height: 10.0)),
          ),
        ),
      ),
    );
  }
}
