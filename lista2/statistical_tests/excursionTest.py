import sys
import string
import math
import numpy
from scipy import special as spc


def get_frequency(list_data, trigger):
    """
    This method is used by the random_excursions_variant method to get frequencies
    """
    frequency = 0
    for (x, y) in list_data:
        if x == trigger:
            frequency = y
    return frequency


def random_excursions_variant( bin_data):
   
    int_data = numpy.zeros(len(bin_data))
    for i in range(len(bin_data)):
        int_data[i] = int(bin_data[i])
    sum_int = (2 * int_data) - numpy.ones(len(int_data))
    cumulative_sum = numpy.cumsum(sum_int)

    li_data = []
    for xs in sorted(set(cumulative_sum)):
        if numpy.abs(xs) <= 9:
            li_data.append([xs, len(numpy.where(cumulative_sum == xs)[0])])

    j = get_frequency(li_data, 0) + 1
    p_values = []
    for xs in range(-9, 9 + 1):
        if not xs == 0:
            den = numpy.sqrt(2 * j * (4 * numpy.abs(xs) - 2))
            p_values.append(spc.erfc(numpy.abs(get_frequency(li_data, xs) - j) / den))
    return p_values


fileinput = sys.argv[1]

with open(fileinput, 'r') as myfile:
    data=myfile.read().replace('\n', '')
    print random_excursions_variant(data)
