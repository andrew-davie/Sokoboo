from PIL import Image


def build(pix, y):

    byte = 0
    byte2 = 0
    byte3 = 0

    for cx in range(0, 8):

        # 1st char is mirrored
        p = 0
        if pix[cx,y] != 0:
            p = 1

        byte = (byte >> 1) | (p << 7)              # PF 2 mirrored

        # 2nd char is trickier
        # left 4 pixels --> PF0 mirrored --> D7 D6 D5 D4
        # right 4 pixels --> PF1 not mirrored --> D3 D2 D1 D0

        if cx < 4:
            byte2 = (byte2 >> 1) | (p << 7)
        else:
            byte2 = (byte2 & 240) | (((byte2 & 15) << 1) | p)

        byte3 = (byte3 << 1) | p

    return byte, byte2, byte3


def process(out, n, inhibit=False):

    im = Image.open('bigDigits/' + n+'.gif')
    pix = im.load()

    left = []
    right =[]
    hundpf1 = []

    for chary in range(0, im.size[1]):
        shape1, shape2, shape3 = build(pix, chary)
        left.append(shape1)
        if inhibit == False:
            right.append(shape2)
            if int(n) < 2:
                hundpf1.append(shape3)


    out.write(' OPTIONAL_PAGEBREAK "LEFT_' + str(n) + '", ' + str(len(left)) + '\n')
    out.write('LEFT_'+str(n) + '\n')
    left.reverse()
    for line in left:
        out.write(' .byte ' + str(line) + '\n')

    if inhibit == False:

        out.write(' OPTIONAL_PAGEBREAK "RIGHT_' + str(n) + '", ' + str(len(right)) + '\n')
        out.write('RIGHT_' + str(n) + '\n')
        right.reverse()
        for line in right:
            out.write(' .byte ' + str(line) + '\n')

        out.write(' OPTIONAL_PAGEBREAK "HUNDPF1_' + str(n) + '", ' + str(len(hundpf1)) + '\n')
        out.write('HUNDPF1_' + str(n) + '\n')
        hundpf1.reverse()
        for line in hundpf1:
            out.write(' .byte ' + str(line) + '\n')


f = open('./bigDigits.asm', 'w')
for digit in range(0, 10):
    process(f, str(digit))
for star in range(0,4):
    process(f,'star'+str(star),True)
f.close()
