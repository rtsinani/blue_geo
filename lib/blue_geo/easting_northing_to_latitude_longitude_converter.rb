module BlueGeo
  class EastingNorthingToLatitudeLongitudeConverter
  	def convert(easting, northing)
  		deg2rad = Math::PI / 180.0
  		rad2deg = 180.0 / Math::PI

  		wgs_axis 		= 6378137
  		latorig 		= 49 * deg2rad
  		lonorig 		= -2 * deg2rad
  		scale 			= 0.9996012717
      falseeast 	= 400000
      falsenorth 	= -100000
      axis 				= 6377563.396
      wgs_eccent 	= 0.00669438
      eccent 			= 0.00667054 

      scale = 0.9996012717
      falseeast = 400000
      falsenorth = -100000
      axis = 6377563.396
      wgs_eccent = 0.00669438
      eccent = 0.00667054

      ep = easting
      np = northing


      p = eccent / 8
      a = axis * (1 - (2 * p) - (3 * p * p) - (10 * p * p * p))
      b = axis * ((6 * p) + (12 * p * p) + (45 * p * p * p)) / 2
      c = axis * ((15 * p * p) + (90 * p * p * p)) / 4
      mo = a * latorig - b * Math.sin(2 * latorig) + c * Math.sin(4 * latorig)
      mp = mo + ((np - falsenorth) / scale)
      phidash = mp / a
      phif = phidash + ((b * Math.sin(2 * phidash)) - (c * Math.sin(4 * phidash))) / (a - (2 * b * Math.cos(2 * phidash)))

      uf = axis / Math.sqrt(1 - (eccent * (Math.sin(phif) * Math.sin(phif))))
      h = (ep - falseeast) / (scale * uf)

      nsqd = eccent * (Math.cos(phif) * Math.cos(phif)) / (1 - eccent)
      tsqd = Math.sin(phif) / Math.cos(phif) ** 2

      lambdap = lonorig + (1 / Math.cos(phif)) * ((h - ((h * h * h) / 6) * (1 + (2 * tsqd) + nsqd)))
      phip = phif - ((1 + nsqd) * (Math.sin(phif) / Math.cos(phif)) * (((h * h) / 2) - ((h * h * h * h) / 24) * (5 + 3 * tsqd)))

      x, y, z = lat_lon_to_cartesian(phip, lambdap, axis, eccent, 0)

      lat, lon = cartesian_to_lat_lon(x, y, z, eccent, wgs_axis)

	    [lat * rad2deg, lon * rad2deg]

  	end

  	def lat_lon_to_cartesian(lat, lon, a, eccentsq, h)
  		v = a / (Math.sqrt(1 - eccentsq * (Math.sin(lat) ** 2)))
      x = (v + h) * Math.cos(lat) * Math.cos(lon)
      y = (v + h) * Math.cos(lat) * Math.sin(lon)
      z = ((1 - eccentsq) * v + h) * Math.sin(lat)
      [x, y, z]
  	end

  	def cartesian_to_lat_lon(x, y, z, eccentsq, a)
	    lon = Math.atan(y / x)
	    p = Math.sqrt((x * x) + (y * y))
	    lat = Math.atan(z / (p * (1 - eccentsq)))
	    v = a / (Math.sqrt(1 - eccentsq * (Math.sin(lat) * Math.sin(lat))))
	    errvalue = 1.0
	    lat = 0
	    lat0 = 0

	    while errvalue > 0.001
	    	lat0 = Math.atan((z + eccentsq * v * Math.sin(lat)) / p)
        errvalue = (lat0 - lat).abs;
        lat = lat0;
	    end

	    # h = p / Math.Cos(lat) - v
	    [lat, lon]
    end

  end
end
