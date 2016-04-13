# The following Makefile is known to work on
# redhat linux 7.3 with Matlab R14
#
# For other versions of MATLAB, the "MATDIR"
# variable may have to be changed
# Note: this should also work by simply 
# using "mex" from the MATLAB command window
# eg: ">> mex qrot3d.c" 

CC = gcc
CFLAGS = -O2 -Wall -DMATLAB_MEX_FILE

ARCH = $(shell uname -p)

ifeq ($(ARCH),x86_64)
	
	CFLAGS += -fPIC
	SUFFIX = mexa64
else
	SUFFIX = mexglx
endif

TARGET = qrot3d.$(SUFFIX)
SOURCES = qrot3d.c
MATDIR = /usr/local/matlab
INCDIR = -I. -I$(MATDIR)/extern/include

$(TARGET) : $(patsubst %.c,%.o,$(SOURCES))
	$(CC) $(CFLAGS) $(LIBDIR) $(LIBS) -shared $^ -o $@

%.o : %.c
	$(CC) $(CFLAGS) $(INCDIR) -c $< -o $@

clean : 
	rm -rf $(patsubst %.c,%.o,$(SOURCES)) $(TARGET)
