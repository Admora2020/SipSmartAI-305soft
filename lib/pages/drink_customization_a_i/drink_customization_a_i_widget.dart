import '/auth/firebase_auth/auth_util.dart';
import '/backend/ai_agents/ai_agent.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/pages/add_drink/drink_customization_a_i_confirmation/drink_customization_a_i_confirmation_widget.dart';
import '/pages/add_drink_customization/add_drink_customization_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'drink_customization_a_i_model.dart';
export 'drink_customization_a_i_model.dart';

class DrinkCustomizationAIWidget extends StatefulWidget {
  const DrinkCustomizationAIWidget({super.key});

  @override
  State<DrinkCustomizationAIWidget> createState() =>
      _DrinkCustomizationAIWidgetState();
}

class _DrinkCustomizationAIWidgetState
    extends State<DrinkCustomizationAIWidget> {
  late DrinkCustomizationAIModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DrinkCustomizationAIModel());

    _model.aiPromptTextController ??= TextEditingController();
    _model.aiPromptFocusNode ??= FocusNode();

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
        constraints: BoxConstraints(
          maxWidth: 400.0,
        ),
        decoration: BoxDecoration(
          color: Color(0xFFFFEBCA),
          borderRadius: BorderRadius.circular(24.0),
          shape: BoxShape.rectangle,
          border: Border.all(
            color: Color(0xFFFFB100),
            width: 3.0,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              40.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'Choose your drink!',
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
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
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
                    ],
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(1.0, 0.0),
                  child: FlutterFlowIconButton(
                    borderRadius: 8.0,
                    borderWidth: 0.0,
                    buttonSize: 40.0,
                    icon: Icon(
                      Icons.west_rounded,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24.0,
                    ),
                    showLoadingIndicator: true,
                    onPressed: () async {
                      Navigator.pop(context);
                      await showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        enableDrag: false,
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: MediaQuery.viewInsetsOf(context),
                            child: AddDrinkCustomizationWidget(),
                          );
                        },
                      ).then((value) => safeSetState(() {}));
                    },
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 1.0,
              color: FlutterFlowTheme.of(context).primary,
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(30.0, 0.0, 30.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      final selectedMedia =
                          await selectMediaWithSourceBottomSheet(
                        context: context,
                        allowPhoto: true,
                      );
                      if (selectedMedia != null &&
                          selectedMedia.every((m) =>
                              validateFileFormat(m.storagePath, context))) {
                        safeSetState(
                            () => _model.isDataUploading_aiDrinkUpload = true);
                        var selectedUploadedFiles = <FFUploadedFile>[];

                        try {
                          selectedUploadedFiles = selectedMedia
                              .map((m) => FFUploadedFile(
                                    name: m.storagePath.split('/').last,
                                    bytes: m.bytes,
                                    height: m.dimensions?.height,
                                    width: m.dimensions?.width,
                                    blurHash: m.blurHash,
                                    originalFilename: m.originalFilename,
                                  ))
                              .toList();
                        } finally {
                          _model.isDataUploading_aiDrinkUpload = false;
                        }
                        if (selectedUploadedFiles.length ==
                            selectedMedia.length) {
                          safeSetState(() {
                            _model.uploadedLocalFile_aiDrinkUpload =
                                selectedUploadedFiles.first;
                          });
                        } else {
                          safeSetState(() {});
                          return;
                        }
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 300.0,
                      decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: Stack(
                        children: [
                          if ((_model.uploadedLocalFile_aiDrinkUpload.bytes
                                      ?.isEmpty ??
                                  true))
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Icon(
                                Icons.camera_alt,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 60.0,
                              ),
                            ),
                          if ((_model.uploadedLocalFile_aiDrinkUpload.bytes
                                      ?.isNotEmpty ??
                                  false))
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.memory(
                                _model.uploadedLocalFile_aiDrinkUpload.bytes ??
                                    Uint8List.fromList([]),
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    '- AND/OR -',
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                          font: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 32.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          fontStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontStyle,
                        ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AI Prompt',
                        style: FlutterFlowTheme.of(context)
                            .labelMedium
                            .override(
                              font: GoogleFonts.inter(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .fontStyle,
                            ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 300.0,
                            child: TextFormField(
                              controller: _model.aiPromptTextController,
                              focusNode: _model.aiPromptFocusNode,
                              autofocus: false,
                              enabled: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                hintStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              cursorColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              enableInteractiveSelection: true,
                              validator: _model.aiPromptTextControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ].divide(SizedBox(height: 20.0)),
              ),
            ),
            Divider(
              thickness: 1.0,
              color: FlutterFlowTheme.of(context).primary,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FFButtonWidget(
                  onPressed: () async {
                    if (((_model.uploadedLocalFile_aiDrinkUpload.bytes
                                    ?.isNotEmpty ??
                                false)) ||
                        (_model.aiPromptTextController.text != '')) {
                      await callAiAgent(
                        context: context,
                        prompt: _model.aiPromptTextController.text,
                        imageAsset: _model.uploadedLocalFile_aiDrinkUpload,
                        threadId: currentUserUid,
                        agentCloudFunctionName: 'drinkParser',
                        provider: 'GOOGLE',
                        agentJson:
                            '{\"status\":\"LIVE\",\"identifier\":{\"name\":\"drinkParser\",\"key\":\"ecl1v\"},\"name\":\"DrinkParser\",\"description\":\"This agent takes an image and text description of a drink and extracts structured data about the drink the person is actively consuming. Text input always overrides image input for drink identity. The image is only used to estimate size when the text does not specify it. If the image shows a large container (such as a handle, bottle, or jug), the agent should infer a reasonable single serving instead of treating the whole container as the drink. The agent returns normalized JSON containing drink_name, drink_abv, drink_size, drink_size_type, and confidence, and drink_name must be formatted in clean title case.\\r\\n\",\"aiModel\":{\"provider\":\"GOOGLE\",\"model\":\"gemini-2.0-flash\",\"parameters\":{\"temperature\":{\"inputValue\":1},\"maxTokens\":{\"inputValue\":8192},\"topP\":{\"inputValue\":0.95}},\"messages\":[{\"role\":\"SYSTEM\",\"text\":\"You analyze text descriptions and images of drinks and return a JSON object that represents the drink the person is actively consuming. Text input always overrides image input for identifying the drink. Use the image only to estimate size when the text does not specify it.\\r\\n\\r\\nIf the image or text shows a large container (handle, bottle, jug, can, multipack, etc.) do NOT assume the user is drinking the entire container. Infer the most likely single serving based on the drink type. For example:\\r\\n- A handle of 40 percent vodka implies a typical bar shot (about 1.5 oz).\\r\\n- A large bottle of wine implies a single glass pour.\\r\\n- A liquor bottle shown without context should default to a standard serving size.\\r\\n\\r\\nOutput must follow this exact structure:\\r\\n\\r\\n{\\r\\n  \\\"drink_name\\\": string,\\r\\n  \\\"drink_abv\\\": number,\\r\\n  \\\"drink_size\\\": number,\\r\\n  \\\"drink_size_type\\\": \\\"oz\\\" or \\\"mL\\\" or \\\"cups\\\",\\r\\n  \\\"confidence\\\": number\\r\\n}\\r\\n\\r\\nRules:\\r\\n- Format drink_name in clean, presentable title case.\\r\\n- If information is missing, guess with lower confidence.\\r\\n- drink_abv is the percent ABV without the percent symbol.\\r\\n- drink_size is numeric only and should represent a realistic single serving.\\r\\n- drink_size_type must be \\\"oz\\\", \\\"mL\\\", or \\\"cups\\\".\\r\\n- confidence is a number from 0 to 100.\\r\\n- Do not include any text outside the JSON.\\r\\n\"}]},\"requestOptions\":{\"requestTypes\":[\"PLAINTEXT\",\"IMAGE\"]},\"responseOptions\":{\"responseType\":\"JSON\"}}',
                        responseType: 'JSON',
                      ).then((generatedText) {
                        safeSetState(
                            () => _model.agentResponse = generatedText);
                      });

                      Navigator.pop(context);
                      await showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        enableDrag: false,
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: MediaQuery.viewInsetsOf(context),
                            child: DrinkCustomizationAIConfirmationWidget(
                              drinkName: getJsonField(
                                _model.agentResponse,
                                r'''$["drink_name"]''',
                              ).toString(),
                              drinkSize: getJsonField(
                                _model.agentResponse,
                                r'''$["drink_size"]''',
                              ),
                              drinkSizeType: getJsonField(
                                _model.agentResponse,
                                r'''$["drink_size_type"]''',
                              ).toString(),
                              drinkAbv: getJsonField(
                                _model.agentResponse,
                                r'''$["drink_abv"]''',
                              ),
                              confidence: getJsonField(
                                _model.agentResponse,
                                r'''$["confidence"]''',
                              ),
                            ),
                          );
                        },
                      ).then((value) => safeSetState(() {}));
                    } else {
                      await showDialog(
                        context: context,
                        builder: (alertDialogContext) {
                          return AlertDialog(
                            title: Text('No Prompt Entered'),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(alertDialogContext),
                                child: Text('Ok'),
                              ),
                            ],
                          );
                        },
                      );
                    }

                    safeSetState(() {});
                  },
                  text: 'Ask AI',
                  options: FFButtonOptions(
                    height: 40.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          font: GoogleFonts.poppins(
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontStyle,
                          ),
                          color: Colors.white,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleSmall
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ].divide(SizedBox(width: 0.0)),
            ),
          ].divide(SizedBox(height: 10.0)).addToEnd(SizedBox(height: 20.0)),
        ),
      ),
    );
  }
}
