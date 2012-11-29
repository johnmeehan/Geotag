# John Meehan john.meehan1@gmail.com
# takes a string in from command line that is the address to query and returns the GPS coordinates
#
# geotag an address using google maps api
# need to install these gems first . no need to install rubygems that is in 1.9 by default
# gem install ****
# require 'rubygems'
require 'rest-client' #A simple HTTP and REST client for Ruby
require 'crack' #for parsig XML response

def get_coordinates_for(address)
	base_google_url = "http://maps.googleapis.com/maps/api/geocode/xml?sensor=false&address="
	result = RestClient.get(URI.encode("#{base_google_url}#{address}"))
	parsed_result = Crack::XML.parse(result)
	lat = parsed_result["GeocodeResponse"]["result"]["geometry"]["location"]["lat"]
	lng = parsed_result["GeocodeResponse"]["result"]["geometry"]["location"]["lng"]
	return "#{lat},#{lng}"
end

address = ARGV[0] 
if address.nil?
	puts "No Address Given! Call with GeoAddr.rb \"4 MyStreet MyTown\" "
	#puts get_coordinates_for "4 Hazelhall, Monaleen, Limerick, Ireland" 
else
	puts get_coordinates_for address
end
