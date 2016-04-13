#######################################################################
# Makefile for MatlabCPP
#
#######################################################################

# MATLAB directory -- this may need to change depending on where you have MATLAB installed
MATDIR = C:\\Program Files\\MATLAB\\R2007b

INCDIR = /I"$(MATDIR)/extern/include" 
CC = cl
CFLAGS = /c /Zp8 /GR /W3 /EHs /D_CRT_SECURE_NO_DEPRECATE /D_SCL_SECURE_NO_DEPRECATE \
	/D_SECURE_SCL=0 /DMATLAB_MEX_FILE /nologo /MD /DMX_COMPAT_32 

!IF DEFINED(DEBUGBUILD)
CFLAGS = $(CFLAGS) /Zi /Fd"qrot3d.mexw32.pdb"
!ELSE
CFLAGS = $(CFLAGS) /O2 /Oy- /DNDEBUG
!ENDIF
 
LINK = link
LINKFLAGS = /dll /export:mexFunction /MAP /MACHINE:X86
LIBDIR = /LIBPATH:"$(MATDIR)\extern\lib\win32\microsoft" 
LIBS = libmex.lib libmx.lib libmat.lib kernel32.lib user32.lib gdi32.lib winspool.lib \
	comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib \
	odbccp32.lib

.SLIENT :

# Rules for making the targets
TARGETS = qrot3d.mexw32 


all: $(TARGETS)
	@echo Files Built Successfully

clean: 
	@echo Cleaning output filder
	@del $(OUTDIR:/=\)*.mexw32
	@del $(OUTDIR:/=\)*.idb
	@del $(OUTDIR:/=\)*.pdb
	@del $(OUTDIR:/=\)*.lib
	@del $(OUTDIR:/=\)*.exp
	@del $(OUTDIR:/=\)*.obj
	
rebuild: clean all

.SUFFIXES : mexw32
#.SILENT :

.c.obj:
    $(CC) $(CFLAGS) $(INCDIR) $<

qrot3d.mexw32 : qrot3d.obj
	$(LINK) qrot3d.obj $(LINKFLAGS) $(LIBDIR) $(LIBS) /OUT:$(OUTDIR)qrot3d.mexw32
	del qrot3d.obj
	del qrot3d.map
	del qrot3d.ilk
	mt -outputresource:"qrot3d.mexw32";2 -manifest "qrot3d.mexw32.manifest"	
	del qrot3d.mexw32.manifest
	
	