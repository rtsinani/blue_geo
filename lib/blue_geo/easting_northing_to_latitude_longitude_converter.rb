module BlueGeo
  class EastingNorthingToLatitudeLongitudeConverter
  	DEG2RAD  = Math::PI / 180.0
  	RAD2DEG  = 180.0 / Math::PI
  	WGS_AXIS = 6378137
  	LAT_ORIG = 49 * DEG2RAD
  	LON_ORIG = -2 * DEG2RAD
  	SCALE    = 0.9996012717
    FALSE_EASTING 	= 400000
    FALSE_NORTHING 	= -100000
    AXIS 				= 6377563.396
    WGS_ECCENT 	= 0.00669438
    ECCENT 			= 0.00667054 


  	def convert(easting, northing)

      p       = ECCENT / 8
      a       = AXIS * (1 - (2 * p) - (3 * p ** 2) - (10 * p ** 3))
      b       = AXIS * ((6 * p) + (12 * p ** 2) + (45 * p ** 3 )) / 2
      c       = AXIS * ((15 * p ** 2) + (90 * p ** 3)) / 4
      mo      = a * LAT_ORIG - b * Math.sin(2 * LAT_ORIG) + c * Math.sin(4 * LAT_ORIG)
      mp      = mo + ((northing - FALSE_NORTHING) / SCALE)
      phidash = mp / a
      phif    = phidash + ((b * Math.sin(2 * phidash)) - (c * Math.sin(4 * phidash))) / (a - (2 * b * Math.cos(2 * phidash)))

      uf = AXIS / Math.sqrt(1 - (ECCENT * (Math.sin(phif) * Math.sin(phif))))
      h  = (easting - FALSE_EASTING) / (SCALE * uf)

      nsqd = ECCENT * (Math.cos(phif) * Math.cos(phif)) / (1 - ECCENT)
      tsqd = Math.sin(phif) / Math.cos(phif) ** 2

      lambdap = LON_ORIG + (1 / Math.cos(phif)) * ((h - ((h * h * h) / 6) * (1 + (2 * tsqd) + nsqd)))
      phip = phif - ((1 + nsqd) * (Math.sin(phif) / Math.cos(phif)) * (((h * h) / 2) - ((h * h * h * h) / 24) * (5 + 3 * tsqd)))

      x, y, z = lat_lon_to_cartesian(phip, lambdap, AXIS, ECCENT, 0)

      lat, lon = cartesian_to_lat_lon(x, y, z, ECCENT, WGS_AXIS)

	    [lat * RAD2DEG, lon * RAD2DEG]

  	end

  	def lat_lon_to_cartesian(lat, lon, a, eccentsq, h)
  		v = a / (Math.sqrt(1 - eccentsq * (Math.sin(lat) ** 2)))
      x = (v + h) * Math.cos(lat) * Math.cos(lon)
      y = (v + h) * Math.cos(lat) * Math.sin(lon)
      z = ((1 - eccentsq) * v + h) * Math.sin(lat)
      [x, y, z]
  	end

  	def cartesian_to_lat_lon(x, y, z, eccentsq, a)
	    lon      = Math.atan(y / x)
	    p        = Math.sqrt((x * x) + (y * y))
	    lat      = Math.atan(z / (p * (1 - eccentsq)))
	    v        = a / (Math.sqrt(1 - eccentsq * (Math.sin(lat) * Math.sin(lat))))
	    errvalue = 1.0
	    lat      = 0
	    lat0     = 0

	    while errvalue > 0.001
	    	lat0 = Math.atan((z + eccentsq * v * Math.sin(lat)) / p)
        errvalue = (lat0 - lat).abs;
        lat = lat0;
	    end

	    [lat, lon]
    end

  end
end
