class DeliveryTime
  require 'geo-distance'

  attr_reader :order, :raw_lat_lon

  def initialize(order)
    @address = order.user.address
    @raw_lat_lon = get_lat_lon
  end

  def time
    # 0.05hr is abritrary food "prep" time
    hr = ((distance)/70.0 + 0.15)
    min = (hr * 60).round(2)
  end

  def distance 
    turing_lat = 39.749498
    turing_lon = -105.000504
    d_lat = format(raw_lat_lon)[0].to_f
    d_lon = format(raw_lat_lon)[1].to_f

    dist = GeoDistance::Haversine.geo_distance( turing_lat, turing_lon, d_lat, d_lon)
    dist.miles.to_s.split[0].to_f.round(2)
  end

  def format(string)
    string.split(',')
  end

  def get_lat_lon
    st_address = @address.street_address.split(' ').join('+')
    city = @address.city
    state = @address.state
    zip = @address.zip_code

    `curl http://rpc.geocoder.us/service/csv?address=#{st_address},+#{city}+#{state}+#{zip}`.chomp
  end
end
