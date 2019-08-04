all: sokoboo.bin

sokoboo.bin: *.asm Makefile FORCE
	-killall Stella
	tools/dasm ./sokoboo.asm -l./sokoboo.txt -f3 -s./sokoboo.sym -o./sokoboo.bin
	chmod 777 ./sokoboo.bin
	open -a Stella ./sokoboo.bin
	exit 0

test.bin: test.asm FORCE Makefile
	tools/dasm ./test.asm -l./test.txt -f3 -s./test.sym -o./test.bin
	open -a Stella ./test.bin
	exit 0


FORCE:
