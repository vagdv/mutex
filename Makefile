include MakeVars

DIRS=Proces Controlado

ifeq ($(OS),SunOS)
	LIB:=$(LIB) -lsocket -lnsl -lrt
endif

CONTROLADOR_OBJ=$(shell cat Controlado/.INDEX)
PROCESO_OBJ=$(shell cat Proces/.INDEX)

all : dirs bin

dirs :
	@(for i in $(DIRS) ; \
          do $(MAKE) -C $$i ; \
          done)

bin : proceso controlador

controlador : $(CONTROLADOR_OBJ)
	$(CC) $(CFLAGS) -o controlador $(CONTROLADOR_OBJ) $(LIB)

proceso : $(PROCESO_OBJ)
	$(CC) $(CFLAGS) -o proceso $(PROCESO_OBJ) $(LIB)

clean : clean-dirs
	rm -f *.o
	rm -f *~
	rm -f controlador proceso core

clean-dirs :
	@(for i in $(DIRS) ; \
          do $(MAKE) -C $$i clean ; \
          done)

entrega : clean
	@(tar cf ../dmutex.2019.entrega.tar Proceso ; \
	rm -f ../dmutex.2019.entrega.tar.gz ; \
	gzip -9 ../dmutex.2019.entrega.tar  ; \
	mv ../dmutex.2019.entrega.tar.gz .  ; \
	echo "Fichero de entrega generado dmutex.2019.entrega.tar.gz")
	  
