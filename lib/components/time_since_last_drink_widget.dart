import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'time_since_last_drink_model.dart';
export 'time_since_last_drink_model.dart';

/// I want a custom timer that counts up.
///
/// I should be able to feed it input that can control when and how it counts
/// up.
class TimeSinceLastDrinkWidget extends StatefulWidget {
  const TimeSinceLastDrinkWidget({super.key});

  @override
  State<TimeSinceLastDrinkWidget> createState() =>
      _TimeSinceLastDrinkWidgetState();
}

class _TimeSinceLastDrinkWidgetState extends State<TimeSinceLastDrinkWidget> {
  late TimeSinceLastDrinkModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TimeSinceLastDrinkModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.timerText = functions.timeSinceLastDrinkFormatted(
          valueOrDefault(currentUserDocument?.lastDrinkTimestampMs, 0))!;
      _model.loopCount = 86400;
      _model.timeSinceLastDrinkInMs = functions.timeSinceLastDrinkMs(
          valueOrDefault(currentUserDocument?.lastDrinkTimestampMs, 0));
      safeSetState(() {});
      if (_model.timeSinceLastDrinkInMs! >= 36000000) {
        _model.timerText = '00:00:00';
        safeSetState(() {});
      } else {
        while (FFAppState().currentBAC >= 0.0) {
          _model.timerText = functions.timeSinceLastDrinkFormatted(
              valueOrDefault(currentUserDocument?.lastDrinkTimestampMs, 0))!;
          safeSetState(() {});
          await Future.delayed(
            Duration(
              milliseconds: 1000,
            ),
          );
        }
      }
    });

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
                Color(0xFFFBF3DA),
                FlutterFlowTheme.of(context).secondary
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
              Text(
                'Your last drink was',
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
                    ),
              ),
              Text(
                valueOrDefault<String>(
                  _model.timerText,
                  '00:00:00',
                ),
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      font: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontStyle: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .fontStyle,
                      ),
                      color: Colors.black,
                      fontSize: 20.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                      fontStyle:
                          FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                    ),
              ),
              Text(
                'ago.',
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
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
