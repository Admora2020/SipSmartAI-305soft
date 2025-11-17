import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'nps_model.dart';
export 'nps_model.dart';

/// rating screen for our app, 1-5, with a submit button
class NpsWidget extends StatefulWidget {
  const NpsWidget({super.key});

  static String routeName = 'NPS';
  static String routePath = '/nps';

  @override
  State<NpsWidget> createState() => _NpsWidgetState();
}

class _NpsWidgetState extends State<NpsWidget> {
  late NpsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NpsModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFF0F5F9),
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 400.0,
              ),
              decoration: BoxDecoration(
                color: Color(0xFFF0F5F9),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star_rounded,
                              color: Color(0xFF2797FF),
                              size: 80.0,
                            ),
                            Text(
                              'Rate Your Experience',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .headlineMedium
                                  .override(
                                    font: GoogleFonts.outfit(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .headlineMedium
                                          .fontStyle,
                                    ),
                                    color: Color(0xFF161C24),
                                    fontSize: 32.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .fontStyle,
                                  ),
                            ),
                            Text(
                              'How would you rate your overall experience with our app?',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.manrope(
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: Color(0xFF636F81),
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                    lineHeight: 1.5,
                                  ),
                            ),
                          ].divide(SizedBox(height: 16.0)),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AuthUserStreamWidget(
                                  builder: (context) => FlutterFlowIconButton(
                                    borderRadius: 30.0,
                                    buttonSize: 60.0,
                                    icon: Icon(
                                      Icons.star_border,
                                      color: valueOrDefault(
                                                  currentUserDocument?.rating,
                                                  0) >=
                                              1
                                          ? Color(0xFF2797FF)
                                          : FlutterFlowTheme.of(context)
                                              .primaryText,
                                      size: 40.0,
                                    ),
                                    onPressed: () async {
                                      _model.rating1 = 1;
                                      safeSetState(() {});
                                    },
                                  ),
                                ),
                                AuthUserStreamWidget(
                                  builder: (context) => FlutterFlowIconButton(
                                    borderRadius: 30.0,
                                    buttonSize: 60.0,
                                    fillColor: Colors.white,
                                    icon: Icon(
                                      Icons.star_rounded,
                                      color: valueOrDefault(
                                                  currentUserDocument?.rating,
                                                  0) >=
                                              3
                                          ? Color(0xFF2797FF)
                                          : Color(0x06000000),
                                      size: 40.0,
                                    ),
                                    onPressed: () async {
                                      _model.rating1 = 2;
                                      safeSetState(() {});
                                    },
                                  ),
                                ),
                                AuthUserStreamWidget(
                                  builder: (context) => FlutterFlowIconButton(
                                    borderRadius: 30.0,
                                    buttonSize: 60.0,
                                    fillColor: Colors.white,
                                    icon: Icon(
                                      Icons.star_rounded,
                                      color: valueOrDefault(
                                                  currentUserDocument?.rating,
                                                  0) >=
                                              3
                                          ? Color(0xFF2797FF)
                                          : Color(0x06000000),
                                      size: 40.0,
                                    ),
                                    onPressed: () async {
                                      _model.rating1 = 3;
                                      safeSetState(() {});
                                    },
                                  ),
                                ),
                                AuthUserStreamWidget(
                                  builder: (context) => FlutterFlowIconButton(
                                    borderRadius: 30.0,
                                    buttonSize: 60.0,
                                    fillColor: Colors.white,
                                    icon: Icon(
                                      Icons.star_rounded,
                                      color: valueOrDefault(
                                                  currentUserDocument?.rating,
                                                  0) >=
                                              4
                                          ? Color(0xFF2797FF)
                                          : Color(0x06000000),
                                      size: 40.0,
                                    ),
                                    onPressed: () async {
                                      _model.rating1 = 4;
                                      safeSetState(() {});
                                    },
                                  ),
                                ),
                                AuthUserStreamWidget(
                                  builder: (context) => FlutterFlowIconButton(
                                    borderRadius: 30.0,
                                    buttonSize: 60.0,
                                    fillColor: Colors.white,
                                    icon: Icon(
                                      Icons.star_rounded,
                                      color: valueOrDefault(
                                                  currentUserDocument?.rating,
                                                  0) >=
                                              5
                                          ? Color(0xFF2797FF)
                                          : Color(0x06000000),
                                      size: 40.0,
                                    ),
                                    onPressed: () async {
                                      _model.rating1 = 5;
                                      safeSetState(() {});
                                    },
                                  ),
                                ),
                              ].divide(SizedBox(width: 8.0)),
                            ),
                            Text(
                              'Tap a star to rate',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    font: GoogleFonts.manrope(
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                    color: Color(0xFF636F81),
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                            ),
                          ].divide(SizedBox(height: 24.0)),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            TextFormField(
                              controller: _model.textController,
                              focusNode: _model.textFieldFocusNode,
                              onChanged: (_) => EasyDebounce.debounce(
                                '_model.textController',
                                Duration(milliseconds: 2000),
                                () async {
                                  _model.ratingDescription =
                                      _model.textController.text;
                                  safeSetState(() {});
                                },
                              ),
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText:
                                    'Tell us more about your experience (optional)',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.manrope(
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: Color(0xFF161C24),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFE0E3E7),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF2797FF),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.manrope(
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: Color(0xFF161C24),
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                              maxLines: 4,
                              minLines: 3,
                              keyboardType: TextInputType.multiline,
                              validator: _model.textControllerValidator
                                  .asValidator(context),
                            ),
                            FFButtonWidget(
                              onPressed: () async {
                                safeSetState(() {});

                                await SurveyreponseRecord.collection
                                    .doc()
                                    .set(createSurveyreponseRecordData(
                                      rating: _model.rating1,
                                      ratinDes: _model.ratingDescription,
                                    ));

                                context.pushNamed(GoldenPathWidget.routeName);
                              },
                              text: 'Submit Rating',
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 50.0,
                                padding: EdgeInsets.all(8.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: Color(0xFF2797FF),
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      font: GoogleFonts.manrope(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontStyle,
                                      ),
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                elevation: 0.0,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ].divide(SizedBox(height: 16.0)),
                        ),
                      ].divide(SizedBox(height: 32.0)),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(-0.89, -1.01),
                    child: FlutterFlowIconButton(
                      borderRadius: 8.0,
                      buttonSize: 40.0,
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 40.0,
                      ),
                      onPressed: () async {
                        context.safePop();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
