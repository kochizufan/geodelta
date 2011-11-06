# encoding: utf-8

require "test/unit"
require_relative "../lib/geodelta/region"

class GeoDeltaRegionTest < Test::Unit::TestCase
  def setup
    @mod = GeoDelta::Region
  end

  def test_get_delta_ids_in_region__level1
    assert_equal([[0]], @mod.get_delta_ids_in_region(+0.0, +8.0, +0.0, +8.0, 1))
    assert_equal([[1]], @mod.get_delta_ids_in_region(+6.0, +4.0, +6.0, +4.0, 1))

    assert_equal([[0], [1]], @mod.get_delta_ids_in_region(+0.0, +6.0, +6.0, +6.0, 1))
    assert_equal([[4], [5]], @mod.get_delta_ids_in_region(+0.0, -6.0, +6.0, -6.0, 1))
    assert_equal([[0], [4]], @mod.get_delta_ids_in_region(+0.0, +6.0, +0.0, -6.0, 1))
    assert_equal([[1], [5]], @mod.get_delta_ids_in_region(+6.0, +6.0, +6.0, -6.0, 1))

    assert_equal([[0], [1], [2]], @mod.get_delta_ids_in_region(+0.0, +6.0, +12.0, +6.0, 1))
    assert_equal([[4], [5], [6]], @mod.get_delta_ids_in_region(+0.0, -6.0, +12.0, -6.0, 1))

    assert_equal(
      [[0], [1], [4], [5]],
      @mod.get_delta_ids_in_region(+0.0, +6.0, +6.0, -6.0, 1))
  end
end
