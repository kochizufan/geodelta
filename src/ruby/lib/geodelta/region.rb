# encoding: utf-8

require_relative "geometry"

module GeoDelta
  module Region
    def self.get_delta_ids_in_region(x1, y1, x2, y2, level)
      ids = []

      if x1 > x2
        ids += self.get_delta_ids_in_region(x1, y1, +12.0, y2, level)
        ids += self.get_delta_ids_in_region(x2, y1,  +0.0, y2, level)
      else
        unit = 12.0 / (2 ** (level - 1))
        u1   = unit
        u2   = unit / 2

        nw = GeoDelta::Geometry.get_delta_ids(x1, y1, level)
        ne = GeoDelta::Geometry.get_delta_ids(x2, y1, level)
        sw = GeoDelta::Geometry.get_delta_ids(x1, y2, level)
        se = GeoDelta::Geometry.get_delta_ids(x2, y2, level)

        proc {
          sx, y = GeoDelta::Geometry.get_center(nw)
          ex, _ = GeoDelta::Geometry.get_center(ne)

          sxi  = (sx / u2).floor
          exi  = (ex / u2).ceil
          sxi -= 1 if !GeoDelta::Geometry.upper_delta?(nw) && x1 < sx && nw != sw
          exi += 1 if !GeoDelta::Geometry.upper_delta?(ne) && x2 > ex && ne != se

          (sxi..exi).each { |xi|
            xx = xi * u2
            ids << GeoDelta::Geometry.get_delta_ids(xx, y, level)
          }
        }.call

        proc {
          sx, y = GeoDelta::Geometry.get_center(sw)
          ex, _ = GeoDelta::Geometry.get_center(se)

          sxi  = (sx / u2).floor
          exi  = (ex / u2).ceil
          sxi -= 1 if GeoDelta::Geometry.upper_delta?(sw) && x1 < sx && nw != sw
          exi += 1 if GeoDelta::Geometry.upper_delta?(se) && x2 > ex && ne != se

          (sxi..exi).each { |xi|
            xx = xi * u2
            ids << GeoDelta::Geometry.get_delta_ids(xx, y, level)
          }
        }.call

        proc {
          syi = (y1 / u1).floor
          eyi = (y2 / u1).ceil + 1
          sxi = (x1 / u2).floor
          exi = (x2 / u2).ceil
          (eyi..syi).each { |yi|
            yy = yi * unit - u2
            (sxi..exi).each { |xi|
              xx = xi * u2
              ids << GeoDelta::Geometry.get_delta_ids(xx, yy, level)
            }
          }
        }.call
      end

      ids.sort!
      ids.uniq!

      return ids
    end
  end
end
