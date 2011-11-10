# encoding: utf-8

require_relative "geometry"

module GeoDelta
  module Region
    def self.get_delta_ids_in_region(x1, y1, x2, y2, level)
      s_ids  = GeoDelta::Geometry.get_delta_ids(x1, y1, level)
      e_ids  = GeoDelta::Geometry.get_delta_ids(x2, y2, level)
      sx, sy = GeoDelta::Geometry.get_center(s_ids)
      ex, ey = GeoDelta::Geometry.get_center(e_ids)

      unit = 12.0 / (2 ** (level - 1))
      sy  += (unit / 6) * (GeoDelta::Geometry.upper_delta?(s_ids) ? +1 : -1)
      ey  += (unit / 6) * (GeoDelta::Geometry.upper_delta?(e_ids) ? +1 : -1)

      sx = (x1 / (unit / 2)).floor * (unit / 2)
      ex = (x2 / (unit / 2)).ceil  * (unit / 2)

      dx   = ex - sx
      dy   = sy - ey

      ids = []
      (0..((dy / unit).floor)).each { |j|
        yy = sy - (unit * j)
        (0..((dx / (unit / 2)).floor)).each { |i|
          xx = sx + ((unit / 2) * i)
          ids << GeoDelta::Geometry.get_delta_ids(xx, yy, level)
        }
      }

      ids.sort!
      ids.uniq!

      return ids
    end
  end
end
