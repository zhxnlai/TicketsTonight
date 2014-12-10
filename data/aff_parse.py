import xml.etree.ElementTree as ET
import unicodecsv
import sys
from json import JSONEncoder

def openFile(filename):
    return open(filename, 'r')

def parse(f):
    artists = []
    artist = {}
    for line in f:
        if line[0] == 'R':
            aname = line[24:-1]
            artist["ArtistName"] = aname
            artist["RecArtists"] = []
        elif line[0] != '-':
            rec_artist_attrib = line.split(",")
            rec_artist = {}
            rec_artist["RecId"] = int(rec_artist_attrib[0])
            # use list comprehension to concat element from [1 : -2]
            # since artist name can contain ","
            l = len(rec_artist_attrib)
            recNames = [rec_artist_attrib[i] for i in xrange(1, l - 2)]
            rec_artist["RecName"] = ','.join(recNames)
            rec_artist["RecVal"] = float(rec_artist_attrib[-1][:-1])
            artist["RecArtists"].append(rec_artist)
        else:
            artists.append(artist)
            artist = {}
    print JSONEncoder().encode(artists)

if __name__ == '__main__':
    f = openFile("rec.txt")
    parse(f)
