sokoboo.bin: FORCE
	-killall Stella
	tools/dasm ./sokoboo.asm -l./sokoboo.txt -f3 -s./sokoboo.sym -o./sokoboo.bin
	chmod 777 ./sokoboo.bin
	open -a Stella ./sokoboo.bin
	exit 0

FORCE:
	
