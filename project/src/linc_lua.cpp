#include "./hxcpp.h"
#include <hx/CFFI.h>

#include "linc_lua.h"
#include "lua.hpp"

namespace linc {
	namespace lua {
		::String version() {
			return ::String(LUA_VERSION);
		}

		::String versionJIT() {
			return ::String(LUAJIT_VERSION);
		}

		::String tostring(lua_State *l, int v) {
			return ::String(lua_tostring(l, v));
		}

		::String tolstring(lua_State *l, int v, size_t *len) {
			return ::String(lua_tolstring(l, v, len));
		}

		::cpp::Function<int(lua_State *)> tocfunction(lua_State *l, int i) {
			return (::cpp::Function<int(lua_State *)>) lua_tocfunction(l, i);
		}

		void pushcclosure(lua_State *l, ::cpp::Function<int(lua_State *)> fn, int n) {
			lua_pushcclosure(l, (lua_CFunction)fn, n);
		}

		void pushcfunction(lua_State *l, ::cpp::Function<int(lua_State *)> fn) {
			lua_pushcfunction(l, (lua_CFunction)fn);
		}

		::String _typename(lua_State *l, int v) {
			return ::String(lua_typename(l, v));
		}

		int getstack(lua_State *l, int level, Dynamic ar) {
			lua_Debug dbg;
			int ret = lua_getstack(l, level, &dbg);
			ar->__FieldRef(HX_CSTRING("i_ci")) = (int)dbg.i_ci;
			return ret;
		}

		int getinfo(lua_State *l, const char *what, Dynamic ar) {
			lua_Debug dbg;
			dbg.i_ci = ar->__FieldRef(HX_CSTRING("i_ci"));
			int ret = lua_getinfo(l, what, &dbg);

			if (strchr(what, 'S')) {
				if (dbg.source != nullptr) {
					ar->__FieldRef(HX_CSTRING("source")) = ::String(dbg.source);
				}
				if (dbg.short_src[0] != '\0') {
					ar->__FieldRef(HX_CSTRING("short_src")) = ::String(dbg.short_src);
				}
				if (dbg.linedefined != 0) {
					ar->__FieldRef(HX_CSTRING("linedefined")) = (int)dbg.linedefined;
				}
				if (dbg.lastlinedefined != 0) {
					ar->__FieldRef(HX_CSTRING("lastlinedefined")) = (int)dbg.lastlinedefined;
				}
				if (dbg.what != nullptr) {
					ar->__FieldRef(HX_CSTRING("what")) = ::String(dbg.what);
				}
			}

			if (strchr(what, 'n')) {
				if (dbg.name != nullptr) {
					ar->__FieldRef(HX_CSTRING("name")) = ::String(dbg.name);
				}
				if (dbg.namewhat != nullptr) {
					ar->__FieldRef(HX_CSTRING("namewhat")) = ::String(dbg.namewhat);
				}
			}

			if (strchr(what, 'l')) {
				if (dbg.currentline != 0) {
					ar->__FieldRef(HX_CSTRING("currentline")) = (int)dbg.currentline;
				}
			}

			if (strchr(what, 'u')) {
				if (dbg.nups != 0) {
					ar->__FieldRef(HX_CSTRING("nups")) = (int)dbg.nups;
				}
			}

			return ret;
		}
	}

	namespace lual {
		::String checklstring(lua_State *l, int numArg, size_t *len) {
			return ::String(luaL_checklstring(l, numArg, len));
		}

		::String optlstring(lua_State *l, int numArg, const char *def, size_t *len) {
			return ::String(luaL_optlstring(l, numArg, def, len));
		}

		::String prepbuffer(luaL_Buffer *B) {
			return ::String(luaL_prepbuffer(B));
		}

		::String gsub(lua_State *l, const char *s, const char *p, const char *r) {
			return ::String(luaL_gsub(l, s, p, r));
		}

		::String findtable(lua_State *l, int idx, const char *fname, int szhint) {
			return ::String(luaL_findtable(l, idx, fname, szhint));
		}

		::String checkstring(lua_State *l, int n) {
			return ::String(luaL_checkstring(l, n));
		}

		::String optstring(lua_State *l, int n, const char *d) {
			return ::String(luaL_optstring(l, n, d));
		}

		void error(lua_State *l, const char *fmt) {
			luaL_error(l, fmt, "");
		}

		::String ltypename(lua_State *l, int idx) {
			return ::String(luaL_typename(l, idx));
		}
	}

	namespace callbacks {
		static luaCallbackFN event_fn = 0;

		static int luaCallback(lua_State *l) {
			return event_fn(l, ::String(lua_tostring(l, lua_upvalueindex(1))));
		}

		void set_callbacks_function(luaCallbackFN fn) {
			event_fn = fn;
		}

		void add_callback_function(lua_State *l, const char *name) {
			lua_pushstring(l, name);
			lua_pushcclosure(l, luaCallback, 1);
			lua_setglobal(l, name);
		}

		void remove_callback_function(lua_State *l, const char *name) {
			lua_pushnil(l);
			lua_setglobal(l, name);
		}
	}
}
