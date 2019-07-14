BIN= BoulderDashFU.bin
SOURCE= notBoulderDash.asm

all: $(BIN)

$(BIN):
	-killall "Stella"
	tools/dasm ./notBoulderDash.asm -l./BoulderDash.txt -f3 -s./BoulderDashFI.sym -o./BoulderDashFI.bin
	chmod 777 ./BoulderDashFI.bin
	open -a Stella ./BoulderDashFI.bin
	exit 0

$(SOURCE): macro.h VCS.H
