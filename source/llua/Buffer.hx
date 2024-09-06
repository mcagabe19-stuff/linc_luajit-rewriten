package llua;

@:buildXml('<include name="${haxelib:linc_luajit}/project/Build.xml" />')
@:include('lua.hpp')
@:unreflective
@:structAccess
@:native("luaL_Buffer")
extern class LuaL_Buffer
{
	var p:String;
	var lvl:Int;
	var l:llua.State;
	var buffer:String;
}

typedef Buffer = cpp.Struct<LuaL_Buffer>;

typedef BufferRef = cpp.Reference<LuaL_Buffer>;
