package llua;

import llua.State;
import llua.Lua;
import llua.LuaL;
import haxe.DynamicAccess;

class Convert {
	public static var enableUnsupportedTraces = true;

	public static function fromLua(l:State, v:Int):Any {
		var ret:Any = null;
		var luaType = Lua.type(l, v);
		switch (luaType) {
			case Lua.LUA_TNIL:
				ret = null;
			case Lua.LUA_TBOOLEAN:
				ret = Lua.toboolean(l, v);
			case Lua.LUA_TNUMBER:
				ret = Lua.tonumber(l, v);
			case Lua.LUA_TSTRING:
				ret = Lua.tostring(l, v);
			case Lua.LUA_TTABLE:
				ret = toHaxeObj(l, v);
			case Lua.LUA_TFUNCTION:
				ret = new LuaCallback(l, LuaL.ref(l, Lua.LUA_REGISTRYINDEX));
			/*case Lua.LUA_TUSERDATA:
				case Lua.LUA_TLIGHTUSERDATA:
				case Lua.LUA_TTHREAD: */
			default:
				if (enableUnsupportedTraces)
					trace('Lua value "$v" of type "$luaType" not supported!');
				ret = null;
		}
		return ret;
	}

	public static function toLua(l:State, val:Any):Bool {
		switch (Type.typeof(val)) {
			case Type.ValueType.TNull:
				Lua.pushnil(l);
			case Type.ValueType.TBool:
				Lua.pushboolean(l, val);
			case Type.ValueType.TInt:
				Lua.pushinteger(l, cast(val, Int));
			case Type.ValueType.TFloat:
				Lua.pushnumber(l, val);
			case Type.ValueType.TClass(String):
				Lua.pushstring(l, cast(val, String));
			case Type.ValueType.TClass(Array):
				arrayToLua(l, val);
			case Type.ValueType.TClass(haxe.ds.StringMap) | Type.ValueType.TClass(haxe.ds.ObjectMap):
				mapToLua(l, val);
			case Type.ValueType.TObject:
				objectToLua(l, val);
			default:
				if (enableUnsupportedTraces)
					trace('Haxe value "$val" of type "${Type.typeof(val)}" not supported!');
				return false;
		}
		return true;
	}

	public static inline function arrayToLua(l:State, arr:Array<Any>) {
		var size:Int = arr.length;
		Lua.createtable(l, size, 0);

		for (i in 0...size) {
			Lua.pushnumber(l, i + 1);
			toLua(l, arr[i]);
			Lua.settable(l, -3);
		}
	}

	static inline function mapToLua(l:State, res:Map<String, Dynamic>) {
		var tLen = 0;
		for (n in res)
			tLen++;
		Lua.createtable(l, tLen, 0);
		for (index => val in res) {
			Lua.pushstring(l, Std.string(index));
			toLua(l, val);
			Lua.settable(l, -3);
		}
	}

	static inline function objectToLua(l:State, res:Any) {
		Lua.createtable(l, Reflect.fields(res).length, 0);
		for (n in Reflect.fields(res)) {
			Lua.pushstring(l, n);
			toLua(l, Reflect.field(res, n));
			Lua.settable(l, -3);
		}
	}

	static function toHaxeObj(l, i:Int):Any {
		var count = 0;
		var array = true;

		loopTable(l, i, () -> {
			if (array) {
				if (Lua.type(l, -2) != Lua.LUA_TNUMBER)
					array = false;
				else {
					var index = Lua.tonumber(l, -2);
					if (index < 0 || Std.int(index) != index)
						array = false;
				}
			}
			count++;
		});

		return if (count == 0) {
			{};
		} else if (array) {
			var v = [];
			loopTable(l, i, () -> {
				var index = Std.int(Lua.tonumber(l, -2)) - 1;
				v[index] = fromLua(l, -1);
			});
			cast v;
		} else {
			var v:DynamicAccess<Any> = {};
			loopTable(l, i, () -> {
				switch Lua.type(l, -2) {
					case t if (t == Lua.LUA_TSTRING): v.set(Lua.tostring(l, -2), fromLua(l, -1));
					case t if (t == Lua.LUA_TNUMBER): v.set(Std.string(Lua.tonumber(l, -2)), fromLua(l, -1));
				}
			});
			cast v;
		}
	}

	public static function loopTable(l:State, v:Int, body:Void->Void):Void {
		Lua.pushnil(l);
		while (Lua.next(l, v < 0 ? v - 1 : v) != 0) {
			body();
			Lua.pop(l, 1);
		}
	}
}
