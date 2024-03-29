{ This is an autogenerated unit using gobject introspection (gir2pascal). Do not Edit. }
unit PangoCairo1;

{$MODE OBJFPC}{$H+}

{$PACKRECORDS C}
{$MODESWITCH DUPLICATELOCALS+}

{$ifdef Unix}
{$LINKLIB libpangocairo-1.0.so.0}
{$endif}
interface
uses
  CTypes, GObject2, Pango1, cairo1, GLib2;

const
  {$ifdef MsWindows}
  PangoCairo1_library = 'libpangocairo-1.0.so.dll';
  {$else}
  PangoCairo1_library = 'libpangocairo-1.0.so.0';
  {$endif}

type

  PPPangoCairoFont = ^PPangoCairoFont;
  PPangoCairoFont = ^TPangoCairoFont;
  TPangoCairoFont = object
    function get_scaled_font: Pcairo_scaled_font_t; cdecl; inline;
  end;

  PPPangoCairoFontMap = ^PPangoCairoFontMap;
  PPangoCairoFontMap = ^TPangoCairoFontMap;
  TPangoCairoFontMap = object
    function get_default: PPangoFontMap; cdecl; inline; static;
    function new: PPangoFontMap; cdecl; inline; static;
    function new_for_font_type(fonttype: Tcairo_font_type_t): PPangoFontMap; cdecl; inline; static;
    function get_font_type: Tcairo_font_type_t; cdecl; inline;
    function get_resolution: gdouble; cdecl; inline;
    procedure set_default; cdecl; inline;
    procedure set_resolution(dpi: gdouble); cdecl; inline;
  end;
  TPangoCairoShapeRendererFunc = procedure(cr: Pcairo_t; attr: PPangoAttrShape; do_path: gboolean; data: gpointer); cdecl;

function pango_cairo_context_get_font_options(context: PPangoContext): Pcairo_font_options_t; cdecl; external {$ifdef Mswindows}PangoCairo1_library  name 'pango_cairo_context_get_font_options'{$endif};
function pango_cairo_context_get_resolution(context: PPangoContext): gdouble; cdecl; external {$ifdef Mswindows}PangoCairo1_library  name 'pango_cairo_context_get_resolution'{$endif};
function pango_cairo_context_get_shape_renderer(context: PPangoContext; data: Pgpointer): TPangoCairoShapeRendererFunc; cdecl; external {$ifdef Mswindows}PangoCairo1_library  name 'pango_cairo_context_get_shape_renderer'{$endif};
function pango_cairo_create_context(cr: Pcairo_t): PPangoContext; cdecl; external {$ifdef Mswindows}PangoCairo1_library  name 'pango_cairo_create_context'{$endif};
function pango_cairo_create_layout(cr: Pcairo_t): PPangoLayout; cdecl; external {$ifdef Mswindows}PangoCairo1_library  name 'pango_cairo_create_layout'{$endif};
function pango_cairo_font_get_scaled_font(font: PPangoCairoFont): Pcairo_scaled_font_t; cdecl; external {$ifdef Mswindows}PangoCairo1_library  name 'pango_cairo_font_get_scaled_font'{$endif};
function pango_cairo_font_get_type: TGType; cdecl; external {$ifdef MSWindows} PangoCairo1_library name 'pango_cairo_font_get_type' {$endif};
function pango_cairo_font_map_get_default: PPangoFontMap; cdecl; external {$ifdef Mswindows}PangoCairo1_library  name 'pango_cairo_font_map_get_default'{$endif};
function pango_cairo_font_map_get_font_type(fontmap: PPangoCairoFontMap): Tcairo_font_type_t; cdecl; external {$ifdef Mswindows}PangoCairo1_library  name 'pango_cairo_font_map_get_font_type'{$endif};
function pango_cairo_font_map_get_resolution(fontmap: PPangoCairoFontMap): gdouble; cdecl; external {$ifdef Mswindows}PangoCairo1_library  name 'pango_cairo_font_map_get_resolution'{$endif};
function pango_cairo_font_map_get_type: TGType; cdecl; external {$ifdef MSWindows} PangoCairo1_library name 'pango_cairo_font_map_get_type' {$endif};
function pango_cairo_font_map_new: PPangoFontMap; cdecl; external {$ifdef Mswindows}PangoCairo1_library  name 'pango_cairo_font_map_new'{$endif};
function pango_cairo_font_map_new_for_font_type(fonttype: Tcairo_font_type_t): PPangoFontMap; cdecl; external {$ifdef Mswindows}PangoCairo1_library  name 'pango_cairo_font_map_new_for_font_type'{$endif};
procedure pango_cairo_context_set_font_options(context: PPangoContext; options: Pcairo_font_options_t); cdecl; external {$ifdef Mswindows}PangoCairo1_library  name 'pango_cairo_context_set_font_options'{$endif};
procedure pango_cairo_context_set_resolution(context: PPangoContext; dpi: gdouble); cdecl; external {$ifdef Mswindows}PangoCairo1_library  name 'pango_cairo_context_set_resolution'{$endif};
procedure pango_cairo_context_set_shape_renderer(context: PPangoContext; func: TPangoCairoShapeRendererFunc; data: gpointer; dnotify: TGDestroyNotify); cdecl; external {$ifdef Mswindows}PangoCairo1_library  name 'pango_cairo_context_set_shape_renderer'{$endif};
procedure pango_cairo_error_underline_path(cr: Pcairo_t; x: gdouble; y: gdouble; width: gdouble; height: gdouble); cdecl; external {$ifdef Mswindows}PangoCairo1_library  name 'pango_cairo_error_underline_path'{$endif};
procedure pango_cairo_font_map_set_default(fontmap: PPangoCairoFontMap); cdecl; external {$ifdef Mswindows}PangoCairo1_library  name 'pango_cairo_font_map_set_default'{$endif};
procedure pango_cairo_font_map_set_resolution(fontmap: PPangoCairoFontMap; dpi: gdouble); cdecl; external {$ifdef Mswindows}PangoCairo1_library  name 'pango_cairo_font_map_set_resolution'{$endif};
procedure pango_cairo_glyph_string_path(cr: Pcairo_t; font: PPangoFont; glyphs: PPangoGlyphString); cdecl; external {$ifdef Mswindows}PangoCairo1_library  name 'pango_cairo_glyph_string_path'{$endif};
procedure pango_cairo_layout_line_path(cr: Pcairo_t; line: PPangoLayoutLine); cdecl; external {$ifdef Mswindows}PangoCairo1_library  name 'pango_cairo_layout_line_path'{$endif};
procedure pango_cairo_layout_path(cr: Pcairo_t; layout: PPangoLayout); cdecl; external {$ifdef Mswindows}PangoCairo1_library  name 'pango_cairo_layout_path'{$endif};
procedure pango_cairo_show_error_underline(cr: Pcairo_t; x: gdouble; y: gdouble; width: gdouble; height: gdouble); cdecl; external {$ifdef Mswindows}PangoCairo1_library  name 'pango_cairo_show_error_underline'{$endif};
procedure pango_cairo_show_glyph_item(cr: Pcairo_t; text: Pgchar; glyph_item: PPangoGlyphItem); cdecl; external {$ifdef Mswindows}PangoCairo1_library  name 'pango_cairo_show_glyph_item'{$endif};
procedure pango_cairo_show_glyph_string(cr: Pcairo_t; font: PPangoFont; glyphs: PPangoGlyphString); cdecl; external {$ifdef Mswindows}PangoCairo1_library  name 'pango_cairo_show_glyph_string'{$endif};
procedure pango_cairo_show_layout(cr: Pcairo_t; layout: PPangoLayout); cdecl; external {$ifdef Mswindows}PangoCairo1_library  name 'pango_cairo_show_layout'{$endif};
procedure pango_cairo_show_layout_line(cr: Pcairo_t; line: PPangoLayoutLine); cdecl; external {$ifdef Mswindows}PangoCairo1_library  name 'pango_cairo_show_layout_line'{$endif};
procedure pango_cairo_update_context(cr: Pcairo_t; context: PPangoContext); cdecl; external {$ifdef Mswindows}PangoCairo1_library  name 'pango_cairo_update_context'{$endif};
procedure pango_cairo_update_layout(cr: Pcairo_t; layout: PPangoLayout); cdecl; external {$ifdef Mswindows}PangoCairo1_library  name 'pango_cairo_update_layout'{$endif};
implementation
function TPangoCairoFont.get_scaled_font: Pcairo_scaled_font_t; cdecl;
begin
  Result := PangoCairo1.pango_cairo_font_get_scaled_font(@self);
end;

function TPangoCairoFontMap.get_default: PPangoFontMap; cdecl;
begin
  Result := PangoCairo1.pango_cairo_font_map_get_default();
end;

function TPangoCairoFontMap.new: PPangoFontMap; cdecl;
begin
  Result := PangoCairo1.pango_cairo_font_map_new();
end;

function TPangoCairoFontMap.new_for_font_type(fonttype: Tcairo_font_type_t): PPangoFontMap; cdecl;
begin
  Result := PangoCairo1.pango_cairo_font_map_new_for_font_type(fonttype);
end;

function TPangoCairoFontMap.get_font_type: Tcairo_font_type_t; cdecl;
begin
  Result := PangoCairo1.pango_cairo_font_map_get_font_type(@self);
end;

function TPangoCairoFontMap.get_resolution: gdouble; cdecl;
begin
  Result := PangoCairo1.pango_cairo_font_map_get_resolution(@self);
end;

procedure TPangoCairoFontMap.set_default; cdecl;
begin
  PangoCairo1.pango_cairo_font_map_set_default(@self);
end;

procedure TPangoCairoFontMap.set_resolution(dpi: gdouble); cdecl;
begin
  PangoCairo1.pango_cairo_font_map_set_resolution(@self, dpi);
end;

end.