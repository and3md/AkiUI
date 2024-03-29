{ This is an autogenerated unit using gobject introspection (gir2pascal). Do not Edit. }
unit cairo1;

{$MODE OBJFPC}{$H+}

{$PACKRECORDS C}
{$MODESWITCH DUPLICATELOCALS+}

{$ifdef Unix}
{$LINKLIB libcairo-gobject.so.2}
{$endif}
interface
uses
  CTypes;

const
  {$ifdef MsWindows}
  cairo1_library = 'libcairo-gobject.so.dll';
  {$else}
  cairo1_library = 'libcairo-gobject.so.2';
  {$endif}


type
  Tcairo_status_t = DWord;
const
  { cairo_status_t }
  CAIRO_STATUS_SUCCESS: Tcairo_status_t = 0;
  CAIRO_STATUS_NO_MEMORY: Tcairo_status_t = 1;
  CAIRO_STATUS_INVALID_RESTORE: Tcairo_status_t = 2;
  CAIRO_STATUS_INVALID_POP_GROUP: Tcairo_status_t = 3;
  CAIRO_STATUS_NO_CURRENT_POINT: Tcairo_status_t = 4;
  CAIRO_STATUS_INVALID_MATRIX: Tcairo_status_t = 5;
  CAIRO_STATUS_INVALID_STATUS: Tcairo_status_t = 6;
  CAIRO_STATUS_NULL_POINTER: Tcairo_status_t = 7;
  CAIRO_STATUS_INVALID_STRING: Tcairo_status_t = 8;
  CAIRO_STATUS_INVALID_PATH_DATA: Tcairo_status_t = 9;
  CAIRO_STATUS_READ_ERROR: Tcairo_status_t = 10;
  CAIRO_STATUS_WRITE_ERROR: Tcairo_status_t = 11;
  CAIRO_STATUS_SURFACE_FINISHED: Tcairo_status_t = 12;
  CAIRO_STATUS_SURFACE_TYPE_MISMATCH: Tcairo_status_t = 13;
  CAIRO_STATUS_PATTERN_TYPE_MISMATCH: Tcairo_status_t = 14;
  CAIRO_STATUS_INVALID_CONTENT: Tcairo_status_t = 15;
  CAIRO_STATUS_INVALID_FORMAT: Tcairo_status_t = 16;
  CAIRO_STATUS_INVALID_VISUAL: Tcairo_status_t = 17;
  CAIRO_STATUS_FILE_NOT_FOUND: Tcairo_status_t = 18;
  CAIRO_STATUS_INVALID_DASH: Tcairo_status_t = 19;
  CAIRO_STATUS_INVALID_DSC_COMMENT: Tcairo_status_t = 20;
  CAIRO_STATUS_INVALID_INDEX: Tcairo_status_t = 21;
  CAIRO_STATUS_CLIP_NOT_REPRESENTABLE: Tcairo_status_t = 22;
  CAIRO_STATUS_TEMP_FILE_ERROR: Tcairo_status_t = 23;
  CAIRO_STATUS_INVALID_STRIDE: Tcairo_status_t = 24;
  CAIRO_STATUS_FONT_TYPE_MISMATCH: Tcairo_status_t = 25;
  CAIRO_STATUS_USER_FONT_IMMUTABLE: Tcairo_status_t = 26;
  CAIRO_STATUS_USER_FONT_ERROR: Tcairo_status_t = 27;
  CAIRO_STATUS_NEGATIVE_COUNT: Tcairo_status_t = 28;
  CAIRO_STATUS_INVALID_CLUSTERS: Tcairo_status_t = 29;
  CAIRO_STATUS_INVALID_SLANT: Tcairo_status_t = 30;
  CAIRO_STATUS_INVALID_WEIGHT: Tcairo_status_t = 31;
  CAIRO_STATUS_INVALID_SIZE: Tcairo_status_t = 32;
  CAIRO_STATUS_USER_FONT_NOT_IMPLEMENTED: Tcairo_status_t = 33;
  CAIRO_STATUS_DEVICE_TYPE_MISMATCH: Tcairo_status_t = 34;
  CAIRO_STATUS_DEVICE_ERROR: Tcairo_status_t = 35;
  CAIRO_STATUS_INVALID_MESH_CONSTRUCTION: Tcairo_status_t = 36;
  CAIRO_STATUS_DEVICE_FINISHED: Tcairo_status_t = 37;
  CAIRO_STATUS_JBIG2_GLOBAL_MISSING: Tcairo_status_t = 38;

type
  Tcairo_content_t = DWord;
const
  { cairo_content_t }
  CAIRO_CONTENT_COLOR: Tcairo_content_t = 4096;
  CAIRO_CONTENT_ALPHA: Tcairo_content_t = 8192;
  CAIRO_CONTENT_COLOR_ALPHA: Tcairo_content_t = 12288;

type
  Tcairo_operator_t = DWord;
const
  { cairo_operator_t }
  CAIRO_OPERATOR_CLEAR: Tcairo_operator_t = 0;
  CAIRO_OPERATOR_SOURCE: Tcairo_operator_t = 1;
  CAIRO_OPERATOR_OVER: Tcairo_operator_t = 2;
  CAIRO_OPERATOR_IN: Tcairo_operator_t = 3;
  CAIRO_OPERATOR_OUT: Tcairo_operator_t = 4;
  CAIRO_OPERATOR_ATOP: Tcairo_operator_t = 5;
  CAIRO_OPERATOR_DEST: Tcairo_operator_t = 6;
  CAIRO_OPERATOR_DEST_OVER: Tcairo_operator_t = 7;
  CAIRO_OPERATOR_DEST_IN: Tcairo_operator_t = 8;
  CAIRO_OPERATOR_DEST_OUT: Tcairo_operator_t = 9;
  CAIRO_OPERATOR_DEST_ATOP: Tcairo_operator_t = 10;
  CAIRO_OPERATOR_XOR: Tcairo_operator_t = 11;
  CAIRO_OPERATOR_ADD: Tcairo_operator_t = 12;
  CAIRO_OPERATOR_SATURATE: Tcairo_operator_t = 13;
  CAIRO_OPERATOR_MULTIPLY: Tcairo_operator_t = 14;
  CAIRO_OPERATOR_SCREEN: Tcairo_operator_t = 15;
  CAIRO_OPERATOR_OVERLAY: Tcairo_operator_t = 16;
  CAIRO_OPERATOR_DARKEN: Tcairo_operator_t = 17;
  CAIRO_OPERATOR_LIGHTEN: Tcairo_operator_t = 18;
  CAIRO_OPERATOR_COLOR_DODGE: Tcairo_operator_t = 19;
  CAIRO_OPERATOR_COLOR_BURN: Tcairo_operator_t = 20;
  CAIRO_OPERATOR_HARD_LIGHT: Tcairo_operator_t = 21;
  CAIRO_OPERATOR_SOFT_LIGHT: Tcairo_operator_t = 22;
  CAIRO_OPERATOR_DIFFERENCE: Tcairo_operator_t = 23;
  CAIRO_OPERATOR_EXCLUSION: Tcairo_operator_t = 24;
  CAIRO_OPERATOR_HSL_HUE: Tcairo_operator_t = 25;
  CAIRO_OPERATOR_HSL_SATURATION: Tcairo_operator_t = 26;
  CAIRO_OPERATOR_HSL_COLOR: Tcairo_operator_t = 27;
  CAIRO_OPERATOR_HSL_LUMINOSITY: Tcairo_operator_t = 28;

type
  Tcairo_antialias_t = DWord;
const
  { cairo_antialias_t }
  CAIRO_ANTIALIAS_DEFAULT: Tcairo_antialias_t = 0;
  CAIRO_ANTIALIAS_NONE: Tcairo_antialias_t = 1;
  CAIRO_ANTIALIAS_GRAY: Tcairo_antialias_t = 2;
  CAIRO_ANTIALIAS_SUBPIXEL: Tcairo_antialias_t = 3;
  CAIRO_ANTIALIAS_FAST: Tcairo_antialias_t = 4;
  CAIRO_ANTIALIAS_GOOD: Tcairo_antialias_t = 5;
  CAIRO_ANTIALIAS_BEST: Tcairo_antialias_t = 6;

type
  Tcairo_fill_rule_t = DWord;
const
  { cairo_fill_rule_t }
  CAIRO_FILL_RULE_WINDING: Tcairo_fill_rule_t = 0;
  CAIRO_FILL_RULE_EVEN_ODD: Tcairo_fill_rule_t = 1;

type
  Tcairo_line_cap_t = DWord;
const
  { cairo_line_cap_t }
  CAIRO_LINE_CAP_BUTT: Tcairo_line_cap_t = 0;
  CAIRO_LINE_CAP_ROUND: Tcairo_line_cap_t = 1;
  CAIRO_LINE_CAP_SQUARE: Tcairo_line_cap_t = 2;

type
  Tcairo_line_join_t = DWord;
const
  { cairo_line_join_t }
  CAIRO_LINE_JOIN_MITER: Tcairo_line_join_t = 0;
  CAIRO_LINE_JOIN_ROUND: Tcairo_line_join_t = 1;
  CAIRO_LINE_JOIN_BEVEL: Tcairo_line_join_t = 2;

type
  Tcairo_text_cluster_flags_t = DWord;
const
  { cairo_text_cluster_flags_t }
  CAIRO_TEXT_CLUSTER_FLAG_BACKWARD: Tcairo_text_cluster_flags_t = 1;

type
  Tcairo_font_slant_t = DWord;
const
  { cairo_font_slant_t }
  CAIRO_FONT_SLANT_NORMAL: Tcairo_font_slant_t = 0;
  CAIRO_FONT_SLANT_ITALIC: Tcairo_font_slant_t = 1;
  CAIRO_FONT_SLANT_OBLIQUE: Tcairo_font_slant_t = 2;

type
  Tcairo_font_weight_t = DWord;
const
  { cairo_font_weight_t }
  CAIRO_FONT_WEIGHT_NORMAL: Tcairo_font_weight_t = 0;
  CAIRO_FONT_WEIGHT_BOLD: Tcairo_font_weight_t = 1;

type
  Tcairo_subpixel_order_t = DWord;
const
  { cairo_subpixel_order_t }
  CAIRO_SUBPIXEL_ORDER_DEFAULT: Tcairo_subpixel_order_t = 0;
  CAIRO_SUBPIXEL_ORDER_RGB: Tcairo_subpixel_order_t = 1;
  CAIRO_SUBPIXEL_ORDER_BGR: Tcairo_subpixel_order_t = 2;
  CAIRO_SUBPIXEL_ORDER_VRGB: Tcairo_subpixel_order_t = 3;
  CAIRO_SUBPIXEL_ORDER_VBGR: Tcairo_subpixel_order_t = 4;

type
  Tcairo_hint_style_t = DWord;
const
  { cairo_hint_style_t }
  CAIRO_HINT_STYLE_DEFAULT: Tcairo_hint_style_t = 0;
  CAIRO_HINT_STYLE_NONE: Tcairo_hint_style_t = 1;
  CAIRO_HINT_STYLE_SLIGHT: Tcairo_hint_style_t = 2;
  CAIRO_HINT_STYLE_MEDIUM: Tcairo_hint_style_t = 3;
  CAIRO_HINT_STYLE_FULL: Tcairo_hint_style_t = 4;

type
  Tcairo_hint_metrics_t = DWord;
const
  { cairo_hint_metrics_t }
  CAIRO_HINT_METRICS_DEFAULT: Tcairo_hint_metrics_t = 0;
  CAIRO_HINT_METRICS_OFF: Tcairo_hint_metrics_t = 1;
  CAIRO_HINT_METRICS_ON: Tcairo_hint_metrics_t = 2;

type
  Tcairo_font_type_t = DWord;
const
  { cairo_font_type_t }
  CAIRO_FONT_TYPE_TOY: Tcairo_font_type_t = 0;
  CAIRO_FONT_TYPE_FT: Tcairo_font_type_t = 1;
  CAIRO_FONT_TYPE_WIN32: Tcairo_font_type_t = 2;
  CAIRO_FONT_TYPE_QUARTZ: Tcairo_font_type_t = 3;
  CAIRO_FONT_TYPE_USER: Tcairo_font_type_t = 4;

type
  Tcairo_path_data_type_t = DWord;
const
  { cairo_path_data_type_t }
  CAIRO_PATH_MOVE_TO: Tcairo_path_data_type_t = 0;
  CAIRO_PATH_LINE_TO: Tcairo_path_data_type_t = 1;
  CAIRO_PATH_CURVE_TO: Tcairo_path_data_type_t = 2;
  CAIRO_PATH_CLOSE_PATH: Tcairo_path_data_type_t = 3;

type
  Tcairo_device_type_t = Integer;
const
  { cairo_device_type_t }
  CAIRO_DEVICE_TYPE_DRM: Tcairo_device_type_t = 0;
  CAIRO_DEVICE_TYPE_GL: Tcairo_device_type_t = 1;
  CAIRO_DEVICE_TYPE_SCRIPT: Tcairo_device_type_t = 2;
  CAIRO_DEVICE_TYPE_XCB: Tcairo_device_type_t = 3;
  CAIRO_DEVICE_TYPE_XLIB: Tcairo_device_type_t = 4;
  CAIRO_DEVICE_TYPE_XML: Tcairo_device_type_t = 5;
  CAIRO_DEVICE_TYPE_COGL: Tcairo_device_type_t = 6;
  CAIRO_DEVICE_TYPE_WIN32: Tcairo_device_type_t = 7;
  CAIRO_DEVICE_TYPE_INVALID: Tcairo_device_type_t = -1;

type
  Tcairo_surface_type_t = DWord;
const
  { cairo_surface_type_t }
  CAIRO_SURFACE_TYPE_IMAGE: Tcairo_surface_type_t = 0;
  CAIRO_SURFACE_TYPE_PDF: Tcairo_surface_type_t = 1;
  CAIRO_SURFACE_TYPE_PS: Tcairo_surface_type_t = 2;
  CAIRO_SURFACE_TYPE_XLIB: Tcairo_surface_type_t = 3;
  CAIRO_SURFACE_TYPE_XCB: Tcairo_surface_type_t = 4;
  CAIRO_SURFACE_TYPE_GLITZ: Tcairo_surface_type_t = 5;
  CAIRO_SURFACE_TYPE_QUARTZ: Tcairo_surface_type_t = 6;
  CAIRO_SURFACE_TYPE_WIN32: Tcairo_surface_type_t = 7;
  CAIRO_SURFACE_TYPE_BEOS: Tcairo_surface_type_t = 8;
  CAIRO_SURFACE_TYPE_DIRECTFB: Tcairo_surface_type_t = 9;
  CAIRO_SURFACE_TYPE_SVG: Tcairo_surface_type_t = 10;
  CAIRO_SURFACE_TYPE_OS2: Tcairo_surface_type_t = 11;
  CAIRO_SURFACE_TYPE_WIN32_PRINTING: Tcairo_surface_type_t = 12;
  CAIRO_SURFACE_TYPE_QUARTZ_IMAGE: Tcairo_surface_type_t = 13;
  CAIRO_SURFACE_TYPE_SCRIPT: Tcairo_surface_type_t = 14;
  CAIRO_SURFACE_TYPE_QT: Tcairo_surface_type_t = 15;
  CAIRO_SURFACE_TYPE_RECORDING: Tcairo_surface_type_t = 16;
  CAIRO_SURFACE_TYPE_VG: Tcairo_surface_type_t = 17;
  CAIRO_SURFACE_TYPE_GL: Tcairo_surface_type_t = 18;
  CAIRO_SURFACE_TYPE_DRM: Tcairo_surface_type_t = 19;
  CAIRO_SURFACE_TYPE_TEE: Tcairo_surface_type_t = 20;
  CAIRO_SURFACE_TYPE_XML: Tcairo_surface_type_t = 21;
  CAIRO_SURFACE_TYPE_SKIA: Tcairo_surface_type_t = 22;
  CAIRO_SURFACE_TYPE_SUBSURFACE: Tcairo_surface_type_t = 23;
  CAIRO_SURFACE_TYPE_COGL: Tcairo_surface_type_t = 24;

type
  Tcairo_format_t = Integer;
const
  { cairo_format_t }
  CAIRO_FORMAT_INVALID: Tcairo_format_t = -1;
  CAIRO_FORMAT_ARGB32: Tcairo_format_t = 0;
  CAIRO_FORMAT_RGB24: Tcairo_format_t = 1;
  CAIRO_FORMAT_A8: Tcairo_format_t = 2;
  CAIRO_FORMAT_A1: Tcairo_format_t = 3;
  CAIRO_FORMAT_RGB16_565: Tcairo_format_t = 4;
  CAIRO_FORMAT_RGB30: Tcairo_format_t = 5;

type
  Tcairo_pattern_type_t = DWord;
const
  { cairo_pattern_type_t }
  CAIRO_PATTERN_TYPE_SOLID: Tcairo_pattern_type_t = 0;
  CAIRO_PATTERN_TYPE_SURFACE: Tcairo_pattern_type_t = 1;
  CAIRO_PATTERN_TYPE_LINEAR: Tcairo_pattern_type_t = 2;
  CAIRO_PATTERN_TYPE_RADIAL: Tcairo_pattern_type_t = 3;
  CAIRO_PATTERN_TYPE_MESH: Tcairo_pattern_type_t = 4;
  CAIRO_PATTERN_TYPE_RASTER_SOURCE: Tcairo_pattern_type_t = 5;

type
  Tcairo_extend_t = DWord;
const
  { cairo_extend_t }
  CAIRO_EXTEND_NONE: Tcairo_extend_t = 0;
  CAIRO_EXTEND_REPEAT: Tcairo_extend_t = 1;
  CAIRO_EXTEND_REFLECT: Tcairo_extend_t = 2;
  CAIRO_EXTEND_PAD: Tcairo_extend_t = 3;

type
  Tcairo_filter_t = DWord;
const
  { cairo_filter_t }
  CAIRO_FILTER_FAST: Tcairo_filter_t = 0;
  CAIRO_FILTER_GOOD: Tcairo_filter_t = 1;
  CAIRO_FILTER_BEST: Tcairo_filter_t = 2;
  CAIRO_FILTER_NEAREST: Tcairo_filter_t = 3;
  CAIRO_FILTER_BILINEAR: Tcairo_filter_t = 4;
  CAIRO_FILTER_GAUSSIAN: Tcairo_filter_t = 5;

type
  Tcairo_region_overlap_t = DWord;
const
  { cairo_region_overlap_t }
  CAIRO_REGION_OVERLAP_IN: Tcairo_region_overlap_t = 0;
  CAIRO_REGION_OVERLAP_OUT: Tcairo_region_overlap_t = 1;
  CAIRO_REGION_OVERLAP_PART: Tcairo_region_overlap_t = 2;
type

  PPcairo_t = ^Pcairo_t;
  Pcairo_t = ^Tcairo_t;
  Tcairo_t = object
  end;

  PPcairo_device_t = ^Pcairo_device_t;
  Pcairo_device_t = ^Tcairo_device_t;
  Tcairo_device_t = object
  end;

  PPcairo_surface_t = ^Pcairo_surface_t;
  Pcairo_surface_t = ^Tcairo_surface_t;
  Tcairo_surface_t = object
  end;

  PPcairo_matrix_t = ^Pcairo_matrix_t;
  Pcairo_matrix_t = ^Tcairo_matrix_t;

  Tcairo_matrix_t = record
  end;



  PPcairo_pattern_t = ^Pcairo_pattern_t;
  Pcairo_pattern_t = ^Tcairo_pattern_t;
  Tcairo_pattern_t = object
  end;

  PPcairo_region_t = ^Pcairo_region_t;
  Pcairo_region_t = ^Tcairo_region_t;
  Tcairo_region_t = object
  end;

  PPcairo_status_t = ^Pcairo_status_t;
  Pcairo_status_t = ^Tcairo_status_t;

  PPcairo_content_t = ^Pcairo_content_t;
  Pcairo_content_t = ^Tcairo_content_t;

  PPcairo_operator_t = ^Pcairo_operator_t;
  Pcairo_operator_t = ^Tcairo_operator_t;

  PPcairo_antialias_t = ^Pcairo_antialias_t;
  Pcairo_antialias_t = ^Tcairo_antialias_t;

  PPcairo_fill_rule_t = ^Pcairo_fill_rule_t;
  Pcairo_fill_rule_t = ^Tcairo_fill_rule_t;

  PPcairo_line_cap_t = ^Pcairo_line_cap_t;
  Pcairo_line_cap_t = ^Tcairo_line_cap_t;

  PPcairo_line_join_t = ^Pcairo_line_join_t;
  Pcairo_line_join_t = ^Tcairo_line_join_t;

  PPcairo_text_cluster_flags_t = ^Pcairo_text_cluster_flags_t;
  Pcairo_text_cluster_flags_t = ^Tcairo_text_cluster_flags_t;

  PPcairo_font_slant_t = ^Pcairo_font_slant_t;
  Pcairo_font_slant_t = ^Tcairo_font_slant_t;

  PPcairo_font_weight_t = ^Pcairo_font_weight_t;
  Pcairo_font_weight_t = ^Tcairo_font_weight_t;

  PPcairo_subpixel_order_t = ^Pcairo_subpixel_order_t;
  Pcairo_subpixel_order_t = ^Tcairo_subpixel_order_t;

  PPcairo_hint_style_t = ^Pcairo_hint_style_t;
  Pcairo_hint_style_t = ^Tcairo_hint_style_t;

  PPcairo_hint_metrics_t = ^Pcairo_hint_metrics_t;
  Pcairo_hint_metrics_t = ^Tcairo_hint_metrics_t;

  PPcairo_font_options_t = ^Pcairo_font_options_t;
  Pcairo_font_options_t = ^Tcairo_font_options_t;
  Tcairo_font_options_t = object
  end;

  PPcairo_font_type_t = ^Pcairo_font_type_t;
  Pcairo_font_type_t = ^Tcairo_font_type_t;

  PPcairo_path_data_type_t = ^Pcairo_path_data_type_t;
  Pcairo_path_data_type_t = ^Tcairo_path_data_type_t;

  PPcairo_device_type_t = ^Pcairo_device_type_t;
  Pcairo_device_type_t = ^Tcairo_device_type_t;

  PPcairo_surface_type_t = ^Pcairo_surface_type_t;
  Pcairo_surface_type_t = ^Tcairo_surface_type_t;

  PPcairo_format_t = ^Pcairo_format_t;
  Pcairo_format_t = ^Tcairo_format_t;

  PPcairo_pattern_type_t = ^Pcairo_pattern_type_t;
  Pcairo_pattern_type_t = ^Tcairo_pattern_type_t;

  PPcairo_extend_t = ^Pcairo_extend_t;
  Pcairo_extend_t = ^Tcairo_extend_t;

  PPcairo_filter_t = ^Pcairo_filter_t;
  Pcairo_filter_t = ^Tcairo_filter_t;

  PPcairo_region_overlap_t = ^Pcairo_region_overlap_t;
  Pcairo_region_overlap_t = ^Tcairo_region_overlap_t;

  PPcairo_font_face_t = ^Pcairo_font_face_t;
  Pcairo_font_face_t = ^Tcairo_font_face_t;
  Tcairo_font_face_t = object
  end;

  PPcairo_scaled_font_t = ^Pcairo_scaled_font_t;
  Pcairo_scaled_font_t = ^Tcairo_scaled_font_t;
  Tcairo_scaled_font_t = object
  end;

  PPcairo_path_t = ^Pcairo_path_t;
  Pcairo_path_t = ^Tcairo_path_t;

  Tcairo_path_t = record
  end;



  PPcairo_rectangle_t = ^Pcairo_rectangle_t;
  Pcairo_rectangle_t = ^Tcairo_rectangle_t;

  Pcdouble = ^cdouble;
  Tcairo_rectangle_t = object
    x: cdouble;
    y: cdouble;
    width: cdouble;
    height: cdouble;
  end;

  PPcairo_rectangle_int_t = ^Pcairo_rectangle_int_t;
  Pcairo_rectangle_int_t = ^Tcairo_rectangle_int_t;

  Pcint = ^cint;
  Tcairo_rectangle_int_t = object
    x: cint;
    y: cint;
    width: cint;
    height: cint;
  end;

function cairo_gobject_context_get_type: csize_t { TGType }; cdecl; external {$ifdef MSWindows} cairo1_library name 'cairo_gobject_context_get_type' {$endif};
function cairo_gobject_device_get_type: csize_t { TGType }; cdecl; external {$ifdef MSWindows} cairo1_library name 'cairo_gobject_device_get_type' {$endif};
function cairo_gobject_font_face_get_type: csize_t { TGType }; cdecl; external {$ifdef MSWindows} cairo1_library name 'cairo_gobject_font_face_get_type' {$endif};
function cairo_gobject_font_options_get_type: csize_t { TGType }; cdecl; external {$ifdef MSWindows} cairo1_library name 'cairo_gobject_font_options_get_type' {$endif};
function cairo_gobject_pattern_get_type: csize_t { TGType }; cdecl; external {$ifdef MSWindows} cairo1_library name 'cairo_gobject_pattern_get_type' {$endif};
function cairo_gobject_rectangle_get_type: csize_t { TGType }; cdecl; external {$ifdef MSWindows} cairo1_library name 'cairo_gobject_rectangle_get_type' {$endif};
function cairo_gobject_rectangle_int_get_type: csize_t { TGType }; cdecl; external {$ifdef MSWindows} cairo1_library name 'cairo_gobject_rectangle_int_get_type' {$endif};
function cairo_gobject_region_get_type: csize_t { TGType }; cdecl; external {$ifdef MSWindows} cairo1_library name 'cairo_gobject_region_get_type' {$endif};
function cairo_gobject_scaled_font_get_type: csize_t { TGType }; cdecl; external {$ifdef MSWindows} cairo1_library name 'cairo_gobject_scaled_font_get_type' {$endif};
function cairo_gobject_surface_get_type: csize_t { TGType }; cdecl; external {$ifdef MSWindows} cairo1_library name 'cairo_gobject_surface_get_type' {$endif};
procedure cairo_image_surface_create; cdecl; external {$ifdef Mswindows}cairo1_library  name 'cairo_image_surface_create'{$endif};
implementation
end.