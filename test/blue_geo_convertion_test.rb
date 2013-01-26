require 'minitest/autorun'
# require File.expand_path("../../lib/blue_geo/easting_northing_to_latitude_longitude_converter",  __FILE__)
require File.expand_path("../../lib/blue_geo",  __FILE__)

module BlueGeo
  class ConvertionTest < MiniTest::Unit::TestCase
  	# 536861, 176584 -> 51.471150	-0.029269 (easting_north -> lat, lon)
  	# 	51.47168	-0.03088506	536861	176584
		# 53.75771	-2.704654	353639	429270
		# 51.66625	-3.92504	266963	198141
		# 52.39906	0.2658032	554253	280309
		# 51.48031	0.1799298	551473	177959
		# 53.3513	-3.003981	333267	384294
		# 53.52229	-2.488291	367724	402958
		# 55.1022	-4.76847	223472	582144
		# 52.60267	1.733953	652939	307091
		# 51.88307	-0.5158798	502248	221541
		# 51.43271	-0.1848878	526273	171974
  	
  	def test_converts_correctly
  		latitude, longitude = BlueGeo.easting_northing_to_lat_lon(536861, 176584)
  		assert_equal 51.471176444600296, latitude, 'latitude'
  		assert_equal -0.02940177028571391, longitude, 'longitude'
  	end
	end
end