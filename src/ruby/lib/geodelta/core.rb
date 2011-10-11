# encoding: utf-8

require File.expand_path(File.join(File.dirname(__FILE__), "projector"))
require File.expand_path(File.join(File.dirname(__FILE__), "geometry"))

module GeoDelta
  def self.get_delta_ids(lat, lng, level)
    mx  = GeoDelta::Projector.lng_to_mx(lng)
    my  = GeoDelta::Projector.lat_to_my(lat)
    nx  = GeoDelta::Projector.mx_to_nx(mx)
    ny  = GeoDelta::Projector.my_to_ny(my)
    ids = GeoDelta::Geometry.get_delta_ids(nx, ny, level)
    return ids
  end
end
