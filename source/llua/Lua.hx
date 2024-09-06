package llua;

import llua.State;
import llua.Convert;

@:buildXml('<include name="${haxelib:linc_luajit}/project/Build.xml" />')
@:unreflective
@:include('linc_lua.h')
extern class Lua {
	public static inline var LUA_MULTRET:Int = (-1);
	public static inline var LUA_REGISTRYINDEX:Int = (-10000);
	public static inline var LUA_ENVIRONINDEX:Int = (-10001);
	public static inline var LUA_GLOBALSINDEX:Int = (-10002);

	public static inline var LUA_OK:Int = 0;
	public static inline var LUA_YIELD:Int = 1;
	public static inline var LUA_ERRRUN:Int = 2;
	public static inline var LUA_ERRSYNTAX:Int = 3;
	public static inline var LUA_ERRMEM:Int = 4;
	public static inline var LUA_ERRERR:Int = 5;
	public static inline var LUA_TNONE:Int = (-1);
	public static inline var LUA_TNIL:Int = 0;
	public static inline var LUA_TBOOLEAN:Int = 1;
	public static inline var LUA_TLIGHTUSERDATA:Int = 2;
	public static inline var LUA_TNUMBER:Int = 3;
	public static inline var LUA_TSTRING:Int = 4;
	public static inline var LUA_TTABLE:Int = 5;
	public static inline var LUA_TFUNCTION:Int = 6;
	public static inline var LUA_TUSERDATA:Int = 7;
	public static inline var LUA_TTHREAD:Int = 8;
	public static inline var LUA_MINSTACK:Int = 20;

	public static inline var LUA_GCSTOP:Int = 0;
	public static inline var LUA_GCRESTART:Int = 1;
	public static inline var LUA_GCCOLLECT:Int = 2;
	public static inline var LUA_GCCOUNT:Int = 3;
	public static inline var LUA_GCCOUNTB:Int = 4;
	public static inline var LUA_GCSTEP:Int = 5;
	public static inline var LUA_GCSETPAUSE:Int = 6;
	public static inline var LUA_GCSETSTEPMUL:Int = 7;

	public static inline var LUA_HOOKCALL:Int = 0;
	public static inline var LUA_HOOKRET:Int = 1;
	public static inline var LUA_HOOKLINE:Int = 2;
	public static inline var LUA_HOOKCOUNT:Int = 3;
	public static inline var LUA_HOOKTAILRET:Int = 4;
	public static inline var LUA_MASKCALL:Int = (1 << LUA_HOOKCALL);
	public static inline var LUA_MASKRET:Int = (1 << LUA_HOOKRET);
	public static inline var LUA_MASKLINE:Int = (1 << LUA_HOOKLINE);
	public static inline var LUA_MASKCOUNT:Int = (1 << LUA_HOOKCOUNT);

	@:native('lua_upvalueindex')
	static function upvalueindex(i:Int):Int;

	@:native('lua_close')
	static function close(l:State):Void;

	@:native('lua_newthread')
	static function newthread(l:State):State;

	@:native('lua_gettop')
	static function gettop(l:State):Int;

	@:native('lua_settop')
	static function settop(l:State, idx:Int):Void;

	@:native('lua_pushvalue')
	static function pushvalue(l:State, idx:Int):Void;

	@:native('lua_remove')
	static function remove(l:State, idx:Int):Void;

	@:native('lua_insert')
	static function insert(l:State, idx:Int):Void;

	@:native('lua_replace')
	static function replace(l:State, idx:Int):Void;

	@:native('lua_checkstack')
	static function checkstack(l:State, sz:Int):Int;

	@:native('lua_xmove')
	static function xmove(from:State, to:State, n:Int):Void;

	@:noCompletion
	@:native('lua_isnumber')
	static function _isnumber(l:State, idx:Int):Int;

	static inline function isnumber(l:State, idx:Int):Bool
		return _isnumber(l, idx) != 0;

	@:noCompletion
	@:native('lua_isfunction')
	static function _isfunction(l:State, idx:Int):Int;

	static inline function isfunction(l:State, idx:Int):Bool
		return _isfunction(l, idx) != 0;

	@:noCompletion
	@:native('lua_isstring')
	static function _isstring(l:State, idx:Int):Int;

	static inline function isstring(l:State, idx:Int):Bool
		return _isstring(l, idx) != 0;

	@:noCompletion
	@:native('lua_iscfunction')
	static function _iscfunction(l:State, idx:Int):Int;

	static inline function iscfunction(l:State, idx:Int):Bool
		return _iscfunction(l, idx) != 0;

	@:noCompletion
	@:native('lua_isuserdata')
	static function _isuserdata(l:State, idx:Int):Int;

	static inline function isuserdata(l:State, idx:Int):Bool
		return _isuserdata(l, idx) != 0;

	@:noCompletion
	@:native('lua_isboolean')
	static function _isboolean(l:State, idx:Int):Int;

	static inline function isboolean(l:State, idx:Int):Bool
		return _isboolean(l, idx) != 0;

	@:native('lua_type')
	static function type(l:State, idx:Int):Int;

	@:native('linc::lua::_typename')
	static function typename(l:State, tp:Int):String;

	@:native('lua_equal')
	static function equal(l:State, idx1:Int, idx2:Int):Int;

	@:native('lua_rawequal')
	static function rawequal(l:State, idx1:Int, idx2:Int):Int;

	@:native('lua_lessthan')
	static function lessthan(l:State, idx1:Int, idx2:Int):Int;

	@:native('lua_tonumber')
	static function tonumber(l:State, idx:Int):Float;

	@:native('lua_tointeger')
	static function tointeger(l:State, idx:Int):Int;

	@:noCompletion
	@:native('lua_toboolean')
	static function _toboolean(l:State, idx:Int):Int;

	static inline function toboolean(l:State, idx:Int):Bool
		return _toboolean(l, idx) != 0;

	@:native('linc::lua::tolstring')
	static function tolstring(l:State, idx:Int, len:UInt):String;

	@:native('lua_objlen')
	static function objlen(l:State, idx:Int):Int;

	@:native('linc::lua::tocfunction')
	static function tocfunction(l:State, idx:Int):cpp.Callable<StatePointer->Int>;

	@:native('lua_touserdata')
	static function touserdata(l:State, idx:Int):Void;

	@:native('lua_tothread')
	static function tothread(l:State, idx:Int):State;

	@:native('lua_topointer')
	static function topointer(l:State, idx:Int):Void;

	@:native('lua_pushnil')
	static function pushnil(l:State):Void;

	@:native('lua_pushnumber')
	static function pushnumber(l:State, n:Float):Void;

	@:native('lua_pushinteger')
	static function pushinteger(l:State, n:Int):Void;

	@:native('lua_pushlstring')
	static function pushlstring(l:State, s:String, len:Int):Void;

	@:native('lua_pushstring')
	static function pushstring(l:State, s:String):Void;

	@:native('linc::lua::pushcclosure')
	static function pushcclosure(l:State, fn:cpp.Callable<StatePointer>, n:Int):Void;

	@:noCompletion
	@:native('lua_pushboolean')
	static function _pushboolean(l:State, b:Int):Void;

	static inline function pushboolean(l:State, b:Bool):Void
		_pushboolean(l, b == true ? 1 : 0);

	@:native('lua_pushthread')
	static function pushthread(l:State):Int;

	@:native('lua_gettable')
	static function gettable(l:State, idx:Int):Void;

	@:native('lua_getfield')
	static function getfield(l:State, idx:Int, k:String):Void;

	@:native('lua_rawget')
	static function rawget(l:State, idx:Int):Void;

	@:native('lua_rawgeti')
	static function rawgeti(l:State, idx:Int, n:Int):Void;

	@:native('lua_createtable')
	static function createtable(l:State, narr:Int, nrec:Int):Void;

	@:native('lua_newuserdata')
	static function newuserdata(l:State, size:Int):Void;

	@:native('lua_getmetatable')
	static function getmetatable(l:State, objindex:Int):Int;

	@:native('lua_getfenv')
	static function getfenv(l:State, int:Int):Void;

	@:native('lua_settable')
	static function settable(l:State, idx:Int):Void;

	@:native('lua_setfield')
	static function setfield(l:State, idx:Int, s:String):Void;

	@:native('lua_rawset')
	static function rawset(l:State, idx:Int):Void;

	@:native('lua_rawseti')
	static function rawseti(l:State, idx:Int, n:Int):Void;

	@:native('lua_setmetatable')
	static function setmetatable(l:State, objindex:Int):Int;

	@:native('lua_setfenv')
	static function lua_setfenv(l:State, idx:Int):Int;

	@:native('lua_call')
	static function call(l:State, nargs:Int, nresults:Int):Void;

	@:native('lua_pcall')
	static function pcall(l:State, nargs:Int, nresults:Int, errfunc:Int):Int;

	@:native('lua_yield')
	static function yield(l:State, n:Int):Int;

	@:native('lua_resume')
	static function resume(l:State, narg:Int):Int;

	@:native('lua_status')
	static function status(l:State):Int;

	@:native('lua_gc')
	static function gc(l:State, what:Int, data:Int):Int;

	@:native('lua_error')
	static function error(l:State):Int;

	@:native('lua_next')
	static function next(l:State, idx:Int):Int;

	@:native('lua_concat')
	static function concat(l:State, n:Int):Void;

	@:native('lua_pop')
	static function pop(l:State, n:Int):Void;

	@:native('lua_copy')
	static function copy(l:State, fromidx:Int, toidx:Int):Void;

	@:native('lua_newtable')
	static function newtable(l:State):Void;

	static inline function register(l:State, name:String, f:Dynamic):Void
		if (Type.typeof(f) == Type.ValueType.TFunction && !Lua_helper.callbacks.exists(name))
			Lua_helper.add_callback(l, name, f);

	@:native('linc::lua::pushcfunction')
	static function pushcfunction(l:State, f:cpp.Callable<StatePointer->Int>):Void;

	@:native('lua_strlen')
	static function strlen(l:State, idx:Int):Int;

	@:native('lua_istable')
	static function istable(l:State, idx:Int):Int;

	@:native('lua_islightuserdata')
	static function islightuserdata(l:State, idx:Int):Int;

	@:native('lua_isnil')
	static function isnil(l:State, idx:Int):Int;

	@:native('lua_isthread')
	static function isthread(l:State, idx:Int):Int;

	@:native('lua_isnone')
	static function isnone(l:State, idx:Int):Int;

	@:native('lua_isnoneornil')
	static function isnoneornil(l:State, idx:Int):Int;

	@:native('lua_pushliteral')
	static function pushliteral(l:State, s:String):Void;

	@:native('lua_setglobal')
	static function setglobal(l:State, name:String):Void;

	@:native('lua_getglobal')
	static function getglobal(l:State, name:String):Void;

	@:native('linc::lua::tostring')
	static function tostring(l:State, idx:Int):String;

	@:native('lua_setlevel')
	static function setlevel(from:State, to:State):Void;

	@:native('linc::lua::getstack')
	static function getstack(l:State, level:Int, ar:Lua_Debug):Int;

	@:native('linc::lua::getinfo')
	static function getinfo(l:State, what:String, ar:Lua_Debug):Int;

	@:native('lua_getupvalue')
	static function getupvalue(l:State, funcindex:Int, n:Int):String;

	@:native('lua_setupvalue')
	static function setupvalue(l:State, funcindex:Int, n:Int):String;

	@:native('lua_gethookmask')
	static function gethookmask(l:State):Int;

	@:native('lua_gethookcount')
	static function gethookcount(l:State):Int;

	@:native('lua_upvalueid')
	static function upvalueid(l:State, idx:Int, n:Int):Void;

	@:native('lua_upvaluejoin')
	static function upvaluejoin(l:State, idx1:Int, n1:Int, idx2:Int, n2:Int):Void;

	@:native('lua_ref')
	static function ref(l:State, lock:Bool):Int;

	@:native('lua_unref')
	static function unref(l:State, ref:Int):Void;

	@:native('lua_getref')
	static function getref(l:State, ref:Int):Void;

	@:native('linc::lua::version')
	static function version():String;

	@:native('linc::lua::versionJIT')
	static function versionJIT():String;

	static inline function init_callbacks(l:State):Void
		Lua.set_callbacks_function(cpp.Callable.fromStaticFunction(Lua_helper.callback_handler));

	@:native('linc::callbacks::set_callbacks_function')
	static function set_callbacks_function(f:cpp.Callable<State->String->Int>):Void;

	@:native('linc::callbacks::add_callback_function')
	static function add_callback_function(l:State, name:String):Void;

	@:native('linc::callbacks::remove_callback_function')
	static function remove_callback_function(l:State, name:String):Void;
}

class Lua_helper {
	public static var callbacks:Map<String, Dynamic> = new Map();
	public static var sendErrorsToLua:Bool = true;

	public static inline function add_callback(l:State, fname:String, f:Dynamic):Bool {
		callbacks.set(fname, f);
		Lua.add_callback_function(l, fname);
		return true;
	}

	public static inline function remove_callback(l:State, fname:String):Bool {
		callbacks.remove(fname);
		Lua.remove_callback_function(l, fname);
		return true;
	}

	public static inline function callback_handler(l:State, fname:String):Int {
		try {
			var cbf = callbacks.get(fname);

			if (cbf == null)
				return 0;

			var nparams:Int = Lua.gettop(l);
			var args:Array<Dynamic> = [];

			for (i in 0...nparams)
				args[i] = Convert.fromLua(l, i + 1);

			var ret:Dynamic = null;

			ret = Reflect.callMethod(null, cbf, args);

			if (ret != null) {
				Convert.toLua(l, ret);
				return 1;
			}
		} catch (e:Dynamic) {
			if (sendErrorsToLua) {
				LuaL.error(l, 'CALLBACK ERROR! ${if (e.message != null) e.message else e}');
				return 0;
			}
			trace(e);
			throw(e);
		}
		return 0;
	}
}

typedef Lua_Debug = {
	@:optional var event:Int;
	@:optional var name:String;
	@:optional var namewhat:String;
	@:optional var what:String;
	@:optional var source:String;
	@:optional var currentline:Int;
	@:optional var nups:Int;
	@:optional var linedefined:Int;
	@:optional var lastlinedefined:Int;
	@:optional var short_src:Array<String>;
	@:optional var i_ci:Int;
}
