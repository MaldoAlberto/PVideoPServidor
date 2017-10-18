#include <stdio.h>
#include <string.h>
#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"
#include "luaT.h"
#include "TH/TH.h"

void multiply (float* array, int m, int n, float *result, int m1, int n1)
{
    lua_State *L = luaL_newstate();
    luaL_openlibs( L );

    // loading the lua file
    if (luaL_loadfile(L, "tensor.lua") || lua_pcall(L, 0, 0, 0))
    {
        printf("error: %s \n", lua_tostring(L, -1));
    }

    // convert the c array to Torch7 specific structure representing a tensor
    THFloatStorage* storage =  THFloatStorage_newWithData(array, m*n);
    THFloatTensor* tensor = THFloatTensor_newWithStorage2d(storage, 0, m, n, n, 1);
    luaT_newmetatable(L, "torch.FloatTensor", NULL, NULL, NULL, NULL);

    // load the lua function hi_tensor
    lua_getglobal(L, "hi_tensor");
    if(!lua_isfunction(L,-1))
    {
        lua_pop(L,1);
    }

    //this pushes data to the stack to be used as a parameter
    //to the hi_tensor function call
    luaT_pushudata(L, (void *)tensor, "torch.FloatTensor");

    // call the lua function hi_tensor
    if (lua_pcall(L, 1, 1, 0) != 0)
    {
        printf("error running function `hi_tensor': %s \n", lua_tostring(L, -1));
    }

    // get results returned from the lua function hi_tensor
    THFloatTensor* z = luaT_toudata(L, -1, "torch.FloatTensor");
    lua_pop(L, 1);
    THFloatStorage *storage_res =  z->storage;
    result = storage_res->data;
    printf("\n %f %f %f %f",result[0],result[1],result[2],result[3]);
    return ;
}



long iniciar(int iniciar)
{

char *archivo1 = "pruebaImagen.lua";
char *archivo2 = "pruebaImagen2.lua";
char *archivo3 = "pruebaImagen3.lua";
char *archivo4 = "pruebaImagen4.lua";
char *archivo5 = "pruebaImagen5.lua";
char *archivoPrincipal = malloc(200);
if(iniciar==1)
	strcpy ( archivoPrincipal, archivo1);
else if(iniciar ==2)
	strcpy ( archivoPrincipal, archivo2);
else if(iniciar ==3)
	strcpy ( archivoPrincipal, archivo3);
else if(iniciar ==4)
	strcpy ( archivoPrincipal, archivo4);
else if(iniciar ==5)
	strcpy ( archivoPrincipal, archivo5);
else
	strcpy ( archivoPrincipal, archivo1);

printf("toto %d	\t %s",iniciar,archivoPrincipal);

 lua_State *L = luaL_newstate();
    luaL_openlibs( L );

    // loading the lua file
    if (luaL_loadfile(L, archivoPrincipal) || lua_pcall(L, 0, 0, 0))
    {
    printf("error: %s \n", lua_tostring(L, -1));
    }
    else
	{
  //  printf("inicio correctamentesssss\n ");
	//printf("holatototototo");
     //lua_getglobal(L, "model");
     //int salida = lua_isnumber(L, -1);
	//printf("hola %d",salida);

 /* call a function `f' defined in Lua */


	}

	
  
    return (long)L ;
}



void reporte()
{

 lua_State *L = luaL_newstate();
    luaL_openlibs( L );

    // loading the lua file
    if (luaL_loadfile(L, "Reporte.lua") || lua_pcall(L, 0, 0, 0))
    {
    printf("error: %s \n", lua_tostring(L, -1));
    }
    else
	{
printf("hexito exitoso");

	}

	
  


}


    void f (long L) {
    
      /* push functions and arguments */
      lua_getglobal(L, "f");  /* function to be called */
	if (!lua_isstring(L, -1))
        error(L, "function `f' must return a number");
      char* z = lua_totirng(L, -1);
      lua_pop(L, 1);  /* pop returned value */
	printf("hola %s",z);

    }


int hola(long L)
{
 	lua_getglobal(L, "name");
     	int salida = lua_tonumber(L, -1);
	//printf("hola %d\n",salida);
	return salida;
}

int detec(unsigned char* eneter,int width,int height,int channels,long L)
{
printf("llegue aqui");
int result=0;
//printf("\n valores %d %d %d\n",width,height,channels); 


int size = width * height;


THDoubleTensor *testTensor = THDoubleTensor_newWithSize1d(channels * size);
//unsigned char *testTensorData = THDoubleTensor_data(testTensor);
double *testTensorData = THDoubleTensor_data(testTensor);

testTensorData=eneter;


lua_getglobal(L, "getTopOnly");
luaT_pushudata(L, testTensor, "torch.FloatTensor");

if (lua_pcall(L, 1, 1, 0) != 0) {
	printf("Error running function: %s", lua_tostring(L, -1));
} 
else 
{
result = (float) lua_tonumber(L,-1);
lua_pop(L,1);
printf("\nTorchandroid", "result : %d",result);
}

printf("salio %d",result);
return result;
}
