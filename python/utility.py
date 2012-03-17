from numpy import *
from numpy.linalg import *

def compute_RBF(basis, x, length_scale):
	return mat([exp(-norm(item)/2) for item in (basis - x)*length_scale ]).T

