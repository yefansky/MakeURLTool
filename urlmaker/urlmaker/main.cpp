#include "assert.h"
#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"
#include <windows.h>

int WINAPI WinMain(HINSTANCE hinstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow)
{
    int nRetCode = 0;
    lua_State* L = luaL_newstate();

    assert(L);
    luaL_openlibs(L);

    nRetCode = luaL_dofile(L, "script.lua");
    //assert(nRetCode == 0);
    if (nRetCode != 0)
    {
        const char* pszError = Lua_ValueToString(L, -1);
        printf("error: %s", pszError);
    }

    return 0;
}