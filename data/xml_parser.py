from parse_rest.connection import register
from parse_rest.datatypes import Object
from parse_rest.connection import ParseBatcher
import xml.etree.ElementTree as ET
import unicodecsv
from cStringIO import StringIO
import sys



'''
Subtree: Artists
Subtree: Categories
Subtree: Venues
Subtree: EventsPricePoints
'''

def find_value(l, k):
	for d in l:
		if d.tag == k:
			if k == 'VenueID':
				venueid = d.attrib["ID"]
				if venueid == None:
					return "Undefined"
				else:
					return venueid
			v = d.text
			if v != None:
				return v
			else:
				return "NOW"
	return "Undefined"

def produce_csv(root):
	f_artist = open('Artists.csv', 'w')
	w_artist = unicodecsv.writer(f_artist, encoding='utf-8')
	
	f_category = open('Categories.csv', 'w')
	w_category = unicodecsv.writer(f_category, encoding='utf-8')
	
	f_venues = open('Venues.csv', 'w')
	w_venues = unicodecsv.writer(f_venues, encoding='utf-8')
	
	f_eventpp = open('EventsPricePoints.csv', 'w')
	w_eventpp = unicodecsv.writer(f_eventpp, encoding='utf-8')

	for child in root:
		if child.tag == 'Artists':
			for artist in list(child):
				newartist = []
				newartist.append(artist.tag)
				newartist.append(artist.attrib["ID"])
				details = list(artist)
				newartist.append(details[0].attrib["ID"])
				newartist.append(details[1].text)
				newartist.append(details[2].text)
				newartist.append(details[3].text)
				w_artist.writerow(newartist)
		elif child.tag == 'Categories':
			for category in list(child):
				newcategory = []
				newcategory.append(category.tag)
				newcategory.append(category.attrib["ID"])
				details = list(category)
				newcategory.append(details[0].text)
				newcategory.append(details[1].attrib["ID"])
				w_category.writerow(newcategory)
		elif child.tag == 'Venues':
			for venue in list(child):
				newvenue = []
				newvenue.append(venue.tag)
				newvenue.append(venue.attrib["ID"])
				details = list(venue)
				keys = ["City", "State", "Street", "VenueImageURL", "VenueName", "VenueURL", "ZipCode"]
				for k in keys:
					res = find_value(details, k)
					if res == None:
						newvenue.append("Undefined")
					else:
						newvenue.append(res)
				w_venues.writerow(newvenue)
		elif child.tag == 'EventsPricePoints':
			for event in list(child):
				newevent = []
				newevent.append(event.tag)
				newevent.append(event.attrib["ID"])
				details = list(event)
				artists = list(details[0])
				for i in xrange(3):
					if i < len(artists):
						newevent.append(artists[i].attrib["ID"])
					else:
						newevent.append("Undefined")
				keys = ["CategoryID", "EventDate", "EventStatus", "EventTime",
						"OnsaleDate", "OnsaleTime", "PerformanceName", "PresaleDate", 
						"PresaleTime", "PriceRange", "PurchaseRequestURL", "VenueID", 
						"PromoterID", "Stars", "StarReviewCount"]
				for k in keys:
					newevent.append(find_value(details, k))
				w_eventpp.writerow(newevent)
	f_artist.close()
	f_category.close()
	f_venues.close()
	f_eventpp.close()


if __name__ == '__main__':
	root = genRoot()
	produce_csv(root)
