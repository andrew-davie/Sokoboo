#/anaconda3/bin/python

from PIL import Image
import os


def build(pix, im, y, start, stop, step):

    r = 0
    b = 0
    g = 0

    for cx in range(start, stop, step):

        p = pix[cx, y]
        r = (r << 1) | (p & 1)
        g = (g << 1) | ((p & 2) >> 1)
        b = (b << 1) | ((p & 4) >> 2)

    if start-stop == 4:
        r <<= 4
        g <<= 4
        b <<= 4

    return r, g, b


def develop(f, dir, filename):
    print(filename)
    size = 8,24

    im = Image.open(dir + '/' + filename)
    print(im.size[0], im.size[1])
    im = im.resize(size, Image.NEAREST)
    #filename2 = filename + '.thumb.png'
    #im.save(filename2, "PNG")
    #im.show()
    print(im.size)
    pix = im.load()

    name = filename.rsplit('.', 1)[0]

    col = []
    pmiss = []
    for y in range(im.size[1]):
        byte = 0
        c = 0
        for x in range(im.size[0]):
            p = 0
            if pix[x,y] != 0:
                p = 1
                c = pix[x,y]
            byte = (byte << 1) + p

        pmiss.append(byte)
        col.append(c)

    f.write('FRAMEDATA_' + name + '\n')
    for y in range(0, 3):
        for yx in range(0, 8):
            y2 = 23-(y + yx*3)
            f.write(' .byte ' + str(pmiss[y2]) + ' ; ' + str(y2) + '\n')
    f.write('\n')

    f.write('COLOURDATA_' + name + '\n')
    for y in range(0, 3):
        for yx in range(0, 8):
            y2 = 23-(y + yx*3)
            f.write(' .byte CL' + str(col[y2]) + ' ; ' + str(y2) + '\n')
    f.write('\n')


frame_names = []
f = open('sprites/spriteData.asm', 'w')
for entry in os.scandir('./sprites'):
    if '.png' in entry.name:
        develop(f, './sprites/', entry.name)
        frame_names.append(entry.name.rsplit('.', 1)[0])

f.write('\n__FNUM SET 0\n')
f.write(' MAC DEFRAME ;{name}\n')
f.write('FRAME_{1} = __FNUM\n')
f.write('__FNUM SET __FNUM + 1\n')
f.write(' ENDM\n\n')

for frame in frame_names:
    f.write(' DEFRAME ' + frame.upper() + '\n')

f.write('\nFRAME_PTR_LO\n')
for frame in frame_names:
    f.write(' .byte <FRAMEDATA_' + frame + '\n')

f.write('\nFRAME_PTR_HI\n')
for frame in frame_names:
    f.write(' .byte >FRAMEDATA_' + frame + '\n')

f.write('\nCOLOUR_PTR_LO\n')
for frame in frame_names:
    f.write(' .byte <COLOURDATA_' + frame + '\n')

f.write('\nCOLOUR_PTR_HI\n')
for frame in frame_names:
    f.write(' .byte >COLOURDATA_' + frame + '\n')

f.close()



