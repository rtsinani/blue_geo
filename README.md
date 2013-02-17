blue_geo converts easting and northing into latitude and longitude

### Installation

```shell
gem install blue_geo
```

or add to your Gemfile

```ruby
gem 'blue_geo'
```

### Usage

Get an array of ```latitude``` and ```longitude``` by calling:

```ruby
latitude, longitude = BlueGeo.easting_northing_to_lat_lon(easting, northing)
```