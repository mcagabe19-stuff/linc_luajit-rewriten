package llua;

import llua.State;

@:buildXml('<include name="${haxelib:linc_luajit}/project/Build.xml" />')
@:unreflective
@:include('lua.hpp')
extern class LuaJIT {
	public static inline var LUAJIT_MODE_OFF:Int = 0x0000;
	public static inline var LUAJIT_MODE_ON:Int = 0x0100;
	public static inline var LUAJIT_MODE_FLUSH:Int = 0x0200;

	@:native('luaJIT_setmode')
	static function setmode(l:State, idx:Int, mode:Int):Int;
}
