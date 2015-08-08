@ECHO OFF

REM swig command
@set SWIG=swig

REM default output language, see swig -h for more
@set LANG=lua

REM module name
@set MODULE_NAME=of

REM strip "of" from function, class, & define/enum names?
@set RENAME=true

REM default platform target, available targets are:
REM   * desktop: win, linux, & mac osx
REM  * ios: apple iOS using OpenGL ES
REM   * linuxarm: embedded linux using OpenGL ES
@set TARGET=desktop

REM generated bindings filename
@set NAME=openFrameworks_wrap

REM where to copy the generated bindings
@set DEST_DIR=..\src\bindings

REM where to copy the generated specific language files
@set DEST_LANG_DIR=.

REM path to OF headers
@set OF_HEADERS=..\..\..\libs\openFrameworks

cd ..\swig

@echo Generating for: %TARGET%
@echo LANG = %LANG%
@echo NAME = %NAME%
@echo DEST_DIR = %DEST_DIR%
	
swig -c++ -%LANG% -fcompact -fvirtual -I%OF_HEADERS% -DTARGET_OPENGLES -DEMSCRIPTEN -DTARGET_EMSCRIPTEN -D__EMSCRIPTEN__ -DMODULE_NAME=%MODULE_NAME% -outdir %DEST_LANG_DIR% openFrameworks.i
mv openFrameworks_wrap.cxx %NAME%.cpp

swig -c++ -%LANG% -external-runtime %NAME%.h

move %NAME%.h %DEST_DIR%\ofxLuaBindings.h
move %NAME%.cpp %DEST_DIR%\%TARGET%\ofxLuaBindings.cpp

pause