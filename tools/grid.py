from PIL import Image


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


im = Image.open('sokoboo.gif')
pix = im.load()


f = open('/Users/boo/Documents/2600/Sokoboo3/Sokoboo/titleData.asm', 'w')

RedLines = []
GreenLines = []
BlueLines = []

for chary in range(0, im.size[1]):

    R = []
    G = []
    B = []

    (r, g, b) = build(pix, im, chary, 3, -1, -1)
    R.append(r)
    B.append(b)
    G.append(g)

    (r, g, b) = build(pix, im, chary, 4, 12, 1)
    R.append(r)
    B.append(b)
    G.append(g)

    (r, g, b) = build(pix, im, chary, 19, 11, -1)
    R.append(r)
    B.append(b)
    G.append(g)

    (r, g, b) = build(pix, im, chary, 23, 19, -1)
    R.append(r)
    B.append(b)
    G.append(g)

    (r, g, b) = build(pix, im, chary, 24, 32, 1)
    R.append(r)
    B.append(b)
    G.append(g)

    (r, g, b) = build(pix, im, chary, 39, 31, -1)
    R.append(r)
    B.append(b)
    G.append(g)

    RedLines.append(R)
    GreenLines.append(G)
    BlueLines.append(B)


for bytepos in range(0, 6):
    f.write('COL_' + str(bytepos) + '\n')
    for line in range(im.size[1]-1, -1, -1):
        f.write(' .byte ' + str(RedLines[line][bytepos]) + ' ;R (' + str(line) + ')\n')
        f.write(' .byte ' + str(GreenLines[line][bytepos]) + ' ;G\n')
        f.write(' .byte ' + str(BlueLines[line][bytepos]) + ' ;B\n')

f.close()
#print(im.size)
