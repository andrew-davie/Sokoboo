all: sprites/spriteData.asm characters sokoboo.bin

characters: charset/*.png
	echo 'Building CHARACTER SET'
	python tools/icc.py

sokoboo.bin: *.asm Makefile FORCE
	-killall Stella
	tools/dasm ./sokoboo.asm -l./sokoboo.lst -f3 -s./sokoboo.sym -o./sokoboo.bin
	chmod 777 ./sokoboo.bin
	tools/stella -rd B ./sokoboo.bin
#	open -a tools/stella ./sokoboo.bin
	exit 0

sprites/spriteData.asm: sprites/*.png
	echo 'Building SPRITE data'
	python tools/sprite.py


#test.bin: test.asm FORCE Makefile
#	tools/dasm ./test.asm -l./test.txt -f3 -s./test.sym -o./test.bin
#	open -a Stella ./test.bin
#	exit 0


FORCE:
