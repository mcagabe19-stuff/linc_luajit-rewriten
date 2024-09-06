#pragma once

#include "./hxcpp.h"
#include <hx/CFFI.h>

#include <sstream>
#include <iostream>

#include "lua.hpp"

namespace linc {
	typedef ::cpp::Function<int(::cpp::Reference<lua_State>, ::String)> luaCallbackFN;

	namespace lua {
		extern ::String version();
		extern ::String versionJIT();
		extern ::String tostring(lua_State *l, int v);
		extern ::String tolstring(lua_State *l, int v, size_t *len);
		extern ::String _typename(lua_State *l, int tp);
		extern int getstack(lua_State *l, int level, Dynamic ar);
		extern int getinfo(lua_State *l, const char *what, Dynamic ar);
		extern ::cpp::Function<int(lua_State*)> tocfunction(lua_State *l, int i);
		extern void pushcclosure(lua_State *l, ::cpp::Function<int(lua_State*)> fn, int n);
		extern void pushcfunction(lua_State *l, ::cpp::Function<int(lua_State*)> fn);
	}

	namespace lual {
		extern ::String checklstring(lua_State *l, int numArg, size_t *len);
		extern ::String optlstring(lua_State *l, int numArg, const char *def, size_t *len);
		extern ::String prepbuffer(luaL_Buffer *B);
		extern ::String gsub(lua_State *l, const char *s, const char *p, const char *r);
		extern ::String findtable(lua_State *l, int idx, const char *fname, int szhint);
		extern ::String checkstring(lua_State *l, int n);
		extern ::String optstring(lua_State *l, int n, const char *d);
		extern ::String ltypename(lua_State *l, int idx);
		extern void error(lua_State *l, const char *fmt);
	}

	namespace callbacks {
		extern void set_callbacks_function(luaCallbackFN fn);
		extern void add_callback_function(lua_State *l, const char *name);
		extern void remove_callback_function(lua_State *l, const char *name);
	}
}
