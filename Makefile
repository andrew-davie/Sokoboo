all: sprites/spriteData.asm bigDigits.asm characters sokoboo.bin

.PHONY: characters
characters:
	cd charset && python icc.py

bigDigits.asm: bigDigits/*.gif
	python tools/digits.py

sokoboo.bin: *.asm Makefile FORCE
	-killall Stella
	tools/dasm ./sokoboo.asm -l./sokoboo.lst -f3 -s./sokoboo.sym -o./sokoboo.bin
	chmod 777 ./sokoboo.bin
	tools/stella -rd A ./sokoboo.bin
#	open -a tools/stella ./sokoboo.bin
	exit 0

force:
	echo "force"

sprites/spriteData.asm: sprites/*.png
	echo 'Building SPRITE data'
	python tools/sprite.py


#test.bin: test.asm FORCE Makefile
#	tools/dasm ./test.asm -l./test.txt -f3 -s./test.sym -o./test.bin
#	open -a Stella ./test.bin
#	exit 0


FORCE:
