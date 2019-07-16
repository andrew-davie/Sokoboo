BIN= BOXDashFU.bin
SOURCE= notBOXDash.asm

all: $(BIN)

$(BIN):
	tools/dasm ./sokoboo.asm -l./sokoboo.txt -f3 -s./sokoboo.sym -o./sokoboo.bin
	chmod 777 ./sokoboo.bin
	open -a Stella ./sokoboo.bin
	exit 0

$(SOURCE): macro.h VCS.H
