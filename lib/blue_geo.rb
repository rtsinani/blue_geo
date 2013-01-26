require_relative "blue_geo/version"
require_relative "blue_geo/easting_northing_to_latitude_longitude_converter"

module BlueGeo
  def self.easting_northing_to_lat_lon(easting, northing)
  	EastingNorthingToLatitudeLongitudeConverter.new.convert(easting, northing)
  end
end
