import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/add_drink_customization/add_drink_customization_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'add_drink_model.dart';
export 'add_drink_model.dart';

class AddDrinkWidget extends StatefulWidget {
  const AddDrinkWidget({
    super.key,
    bool? backgroundBlur,
  }) : this.backgroundBlur = backgroundBlur ?? true;

  final bool backgroundBlur;

  @override
  State<AddDrinkWidget> createState() => _AddDrinkWidgetState();
}

class _AddDrinkWidgetState extends State<AddDrinkWidget> {
  late AddDrinkModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddDrinkModel());

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

    return Stack(
      children: [
        Align(
          alignment: AlignmentDirectional(0.0, 0.0),
          child: Container(
            width: 672.3,
            height: 506.0,
            constraints: BoxConstraints(
              maxWidth: 400.0,
            ),
            decoration: BoxDecoration(
              color: Color(0xFFFFEBCA),
              borderRadius: BorderRadius.circular(24.0),
              shape: BoxShape.rectangle,
              border: Border.all(
                color: Color(0xFFFFB100),
                width: 5.0,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Stack(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(1.0, 0.0),
                          child: FlutterFlowIconButton(
                            borderRadius: 8.0,
                            buttonSize: 40.0,
                            icon: Icon(
                              Icons.close_sharp,
                              color: Colors.black,
                              size: 24.0,
                            ),
                            showLoadingIndicator: true,
                            onPressed: () async {
                              FFAppState().backgroundBlur = false;
                              FFAppState().update(() {});
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-1.0, -1.0),
                          child: Text(
                            'Add a Drink',
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  font: GoogleFonts.poppins(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                                  color: Color(0xFFFFB300),
                                  fontSize: 20.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  'Defaults',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                        color: Color(0xFF0D0C0C),
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        decoration: TextDecoration.underline,
                      ),
                ),
                Text(
                  'Shot: 40% ABV, 1.5 Oz (44 mL)\nBeer: 5% ABV, 12 Oz (355 mL)\nWine: 12% ABV, 5 Oz (150 mL)',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: Color(0xFF020000),
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        decoration: TextDecoration.underline,
                      ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(-1.0, 0.0),
                      child: Material(
                        color: Colors.transparent,
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Color(0xFFFFB300),
                            ),
                          ),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              await actions.addDrink(
                                context,
                                'shot',
                                'Shot',
                                44,
                                40.0,
                                1,
                              );
                              _model.totalMlShot = await actions.getTotalMl(
                                context,
                              );
                              FFAppState().totalMl = _model.totalMlShot!;
                              _model.updatePage(() {});

                              await DailyLogsRecord.collection
                                  .doc()
                                  .set(createDailyLogsRecordData(
                                    userRef: currentUserReference,
                                    date: getCurrentTimestamp,
                                    createdTime: getCurrentTimestamp,
                                    totalMlConsumed: FFAppState().totalMl,
                                    totalDrinks: 1,
                                  ));
                              Navigator.pop(context);

                              safeSetState(() {});
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(24.0),
                              child: Image.asset(
                                'assets/images/ChatGPT_Image_Dec_3,_2025,_01_17_45_AM.png',
                                width: 87.9,
                                height: 150.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.0),
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: Color(0xFFCCAAEE),
                          ),
                        ),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            _model.shotTotalCopy = await actions.addDrink(
                              context,
                              'beer',
                              'Beer',
                              355,
                              5.0,
                              1,
                            );
                            _model.totalMlBeer = await actions.getTotalMl(
                              context,
                            );
                            FFAppState().totalMl = _model.totalMlBeer!;
                            safeSetState(() {});

                            await DailyLogsRecord.collection
                                .doc()
                                .set(createDailyLogsRecordData(
                                  userRef: currentUserReference,
                                  date: getCurrentTimestamp,
                                  createdTime: getCurrentTimestamp,
                                  totalMlConsumed: FFAppState().totalMl,
                                  totalDrinks: 1,
                                ));
                            Navigator.pop(context);

                            safeSetState(() {});
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24.0),
                            child: Image.asset(
                              'assets/images/ChatGPT_Image_Dec_3,_2025,_01_18_54_AM.png',
                              width: 74.0,
                              height: 150.0,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.0),
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: Color(0xFFFF0000),
                          ),
                        ),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            _model.shotTotalCopy2 = await actions.addDrink(
                              context,
                              'wine',
                              'Wine',
                              150,
                              12.0,
                              1,
                            );
                            _model.totalMlWine = await actions.getTotalMl(
                              context,
                            );
                            FFAppState().totalMl = _model.totalMlWine!;
                            safeSetState(() {});

                            await DailyLogsRecord.collection
                                .doc()
                                .set(createDailyLogsRecordData(
                                  userRef: currentUserReference,
                                  date: getCurrentTimestamp,
                                  createdTime: getCurrentTimestamp,
                                  totalMlConsumed: FFAppState().totalMl,
                                  totalDrinks: 1,
                                ));
                            Navigator.pop(context);

                            safeSetState(() {});
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24.0),
                            child: Image.asset(
                              'assets/images/ChatGPT_Image_Dec_3,_2025,_01_18_09_AM.png',
                              width: 80.0,
                              height: 150.0,
                              fit: BoxFit.cover,
                              alignment: Alignment(0.0, 0.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ].divide(SizedBox(width: 10.0)),
                ),
                Text(
                  'Custom Options and More',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
                    color: Colors.black,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.bold,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    decoration: TextDecoration.underline,
                    shadows: [
                      Shadow(
                        color: Color(0xFFFFE3E3),
                        offset: Offset(2.0, 2.0),
                        blurRadius: 10.0,
                      )
                    ],
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      border: Border.all(
                        color: Color(0xFF81FFFE),
                      ),
                    ),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        await showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: MediaQuery.viewInsetsOf(context),
                              child: AddDrinkCustomizationWidget(),
                            );
                          },
                        ).then((value) => safeSetState(() {}));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24.0),
                        child: Image.asset(
                          'assets/images/ChatGPT_Image_Nov_30,_2025,_10_40_02_PM.png',
                          width: 147.5,
                          height: 151.8,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              ].divide(SizedBox(height: 10.0)),
            ),
          ),
        ),
      ],
    );
  }
}
