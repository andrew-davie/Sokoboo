all: sprites/spriteData.asm bigDigits.asm characters sokoboo.bin

.PHONY: characters
characters:
#	cd charset && python icc.py

bigDigits.asm: bigDigits/*.gif
	python tools/digits.py

sokoboo.bin: *.asm Makefile FORCE
#	number=1 ; while [[ $$number -le 1000 ]] ; do \
#        echo $$number ; \
#        ((number = number + 1)) ;
		tools/dasm ./sokoboo.asm -l./sokoboo.lst -f3 -s./sokoboo.sym -o./sokoboo.bin || (echo "mycommand failed $$?"; exit 1)
#    done
	-killall Stella
	chmod 777 ./sokoboo.bin
	tools/stella -rd B ./sokoboo.bin
	open -a tools/stella ./sokoboo.bin
	exit 0

force:
#	echo "force"

sprites/spriteData.asm: sprites/*.png
	echo 'Building SPRITE data'
	python tools/sprite.py


#test.bin: test.asm FORCE Makefile
#	tools/dasm ./test.asm -l./test.txt -f3 -s./test.sym -o./test.bin
#	open -a Stella ./test.bin
#	exit 0


FORCE:
