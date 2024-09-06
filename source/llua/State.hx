package llua;

@:buildXml('<include name="${haxelib:linc_luajit}/project/Build.xml" />')
@:include('lua.hpp')
@:native('lua_State')
extern class Lua_State {}

@:buildXml('<include name="${haxelib:linc_luajit}/project/Build.xml" />')
@:include('lua.hpp')
@:native('::cpp::Reference<lua_State>')
extern class State {}

typedef StatePointer = cpp.RawPointer<Lua_State>;
