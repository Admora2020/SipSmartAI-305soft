import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add_drink_model.dart';
export 'add_drink_model.dart';

class AddDrinkWidget extends StatefulWidget {
  const AddDrinkWidget({super.key});

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
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Container(
        width: 672.3,
        height: 422.64,
        constraints: BoxConstraints(
          maxWidth: 400.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          shape: BoxShape.rectangle,
          border: Border.all(
            color: Color(0xFFFFB100),
            width: 3.0,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                  alignment: AlignmentDirectional(-1.0, -1.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(50.0, 0.0, 0.0, 0.0),
                    child: Text(
                      'Choose your drink!',
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.of(context).titleMedium.override(
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
                ),
                Align(
                  alignment: AlignmentDirectional(1.0, 0.0),
                  child: FlutterFlowIconButton(
                    borderRadius: 8.0,
                    buttonSize: 40.0,
                    icon: Icon(
                      Icons.close_sharp,
                      color: FlutterFlowTheme.of(context).info,
                      size: 24.0,
                    ),
                    showLoadingIndicator: true,
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                  alignment: AlignmentDirectional(-1.0, 0.0),
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
                      );
                      _model.totalMlShot = await actions.getTotalMl(
                        context,
                      );
                      FFAppState().totalMl = _model.totalMlShot!;
                      _model.updatePage(() {});
                      Navigator.pop(context);

                      safeSetState(() {});
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24.0),
                      child: Image.asset(
                        'assets/images/image_2025-11-01_224247976.png',
                        width: 80.0,
                        height: 150.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    _model.shotTotalCopy = await actions.addDrink(
                      context,
                      'beer',
                      'Beer',
                      150,
                    );
                    _model.totalMlBeer = await actions.getTotalMl(
                      context,
                    );
                    FFAppState().totalMl = _model.totalMlBeer!;
                    safeSetState(() {});
                    Navigator.pop(context);

                    safeSetState(() {});
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24.0),
                    child: Image.asset(
                      'assets/images/image_2025-11-01_223601196.png',
                      width: 80.0,
                      height: 150.0,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    _model.shotTotalCopy2 = await actions.addDrink(
                      context,
                      'wine',
                      'Wine',
                      100,
                    );
                    _model.totalMlWine = await actions.getTotalMl(
                      context,
                    );
                    FFAppState().totalMl = _model.totalMlWine!;
                    safeSetState(() {});
                    Navigator.pop(context);

                    safeSetState(() {});
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24.0),
                    child: Image.asset(
                      'assets/images/image_2025-11-01_224505506.png',
                      width: 80.0,
                      height: 150.0,
                      fit: BoxFit.cover,
                      alignment: Alignment(0.0, 0.0),
                    ),
                  ),
                ),
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(24.0),
              child: Image.asset(
                'assets/images/image_2025-11-01_225758446.png',
                width: 126.6,
                height: 150.0,
                fit: BoxFit.fitHeight,
              ),
            ),
          ].divide(SizedBox(height: 25.0)),
        ),
      ),
    );
  }
}
