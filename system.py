from __future__ import division, print_function; __metaclass__ = type
import os, sys, math, itertools
import numpy
import west
from west import WESTSystem
from westpa.binning import RectilinearBinMapper, RecursiveBinMapper

import logging
log = logging.getLogger(__name__)
log.debug('loading module %r' % __name__)

class SDASystem(WESTSystem):

  def initialize(self):

    self.pcoord_ndim            = 1
    self.pcoord_len             = 11  ##Or whatever you want
    self.pcoord_dtype           = numpy.float32
        
    dist_mapper  = [0.0, 1, 2, 3, 4, 6, 9, 12, 15, 30, 40, 55, 85, 110, 145, 200.0, float('inf')]
    inner_mapper = RectilinearBinMapper([dist_mapper])

    self.bin_mapper = inner_mapper
    self.bin_target_counts = numpy.empty((self.bin_mapper.nbins,), dtype=numpy.int)
    self.bin_target_counts[...] = 6  ##24 walkers in each bin...


  def coord_loader(fieldname, coord_file, segment, single_point = False):
    open_file = open(coord_file)
    lines = open_file.readlines()
    lines = [i.split() for i in lines]
    float_lines = np.array(map(np.array, (map(np.float, i) for i in lines)))
  def proper_shaper(array):
    return array[1: ].reshape((len(array[1: ]) / 3, 3))
    float_lines = map(proper_shaper, float_lines)
    segment.data[fieldname] = float_lines[: ]
