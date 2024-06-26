PROJECT=ls
TARGET=$(PROJECT).exe
OBJECTS=$(PROJECT).obj

all: $(TARGET)

.asm.obj:
	wasm -bt=dos -fo=$@ $*.asm


$(TARGET): $(OBJECTS)
	wlink format dos name $(TARGET) file { $(OBJECTS) }


!ifdef __UNIX__
clean: .SYMBOLIC
    @rm -f *.OBJ
    @rm -f *.EXE
    @rm -f *.MAP
    @rm -f *.LNK

    @rm -f *.map
    @rm -f *.lnk
    @rm -f *.obj
    @rm -f *.exe

!else
clean: .SYMBOLIC
    @DEL *.OBJ
    @DEL *.EXE
    @DEL *.MAP
    @DEL *.LNK
    @DEL *.MAP
!endif
