from PIL import Image
import os



# grab a plane and produce paired character bytes
# plane_offset = 0, 1, 2 representing both scanline offset AND the bit # to use
def fetch(bitmap, plane_offset):

    plane = []
    for scan_line in range(0, 8):
        byte = 0
        for pixel in range(0, 4):
            byte = (byte << 1) + (17 if bitmap[pixel, scan_line] & (1 << plane_offset) > 0 else 0)
        plane.append(byte)
    plane.reverse()
    return plane


# mirror (left/right) a plane
def mirror(plane):
    mir = []
    for byte in plane:
        mir.append(int('{:08b}'.format(byte)[::-1], 2))  # !!!
    return mir


def develop(filename):

    try:
        im = Image.open(filename)
    except IOError:
        return

    if im.size[0] == 4 and im.size[1] == 8:
        pix = im.load()

        file_prefix = filename.rsplit('.', 1)[0]
        f = open('CHARACTERSHAPE_' + file_prefix + '.asm', 'w')

        f.write('    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_' + file_prefix + '", LINES_PER_CHAR\n')
        f.write('CHARACTERSHAPE_' + file_prefix + '\n')
        for plane in range(0, 3):
            f.write(' .byte ' + ','.join(map(str, mirror(fetch(pix, plane)))) + '\n')

        f.write('    OPTIONAL_PAGEBREAK "CHARACTERSHAPE_' + file_prefix + '_MIRRORED", LINES_PER_CHAR\n')
        f.write('CHARACTERSHAPE_' + file_prefix + '_MIRRORED\n')
        for plane in range(0, 3):
            f.write(' .byte ' + ','.join(map(str, fetch(pix, plane))) + '\n')

        f.close()


for entry in os.scandir('.'):
    develop(entry.name)

