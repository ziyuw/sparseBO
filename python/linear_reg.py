from numpy import *

import utility

class linear_model:
	def __init__(self, length_scale, noise = 1.0, vu = 1e-1):
		"""
			noise: sigma**2 (Currently does not handel 0 noise)
		"""
		
		self.n = 0
		self.k = 0
		
		self.noise = noise
		self.length_scale = length_scale
		
		self.vu = vu


	def add_data(self, x, y):
		"""
			x is R ^ {1 * k}
			y is in R
		"""

		if self.n == 0:
			self.basis = array([x])
			self.points = array([x])
			self.phi_mat = mat( utility.compute_RBF(self.basis, x, self.length_scale)) # NOTE: 
			
			self.A = mat(self.noise + self.phi_mat**2)
			self.A_inv = 1/self.A
			self.Y = mat([y])
			self.k += 1
		else:
			phi_new = utility.compute_RBF(self.basis, x, self.length_scale)

			vec = self.A_inv*phi_new
			var = phi_new.T*vec
			self.A_inv = self.A_inv - vec*vec.T/(1+var)
			
			
			
			if self.noise*var <= self.vu:
				"""
					Not adding basis.
				"""
				
				print var
				self.A = self.A + phi_new*phi_new.T
				self.phi_mat = hstack([self.phi_mat, phi_new])
			else:
				"""
					Add basis.
				"""
				phi_new_2 = utility.compute_RBF(self.points, x, self.length_scale)
				
				self.k += 1
				d = utility.compute_RBF([x], x, self.length_scale)
				left_vec = self.phi_mat*phi_new_2 + float(d)*phi_new
				last = phi_new_2.T*phi_new_2 + d**2 + self.noise
				vec = self.A_inv*left_vec
				var = left_vec.T*vec
				common_factor = 1.0/(last - var)
				
				# Update A
				self.A = vstack([hstack([self.A + phi_new*phi_new.T, left_vec ]), hstack([left_vec.T, last])])
				
				# Update A_inv
				self.A_inv = vstack([hstack([self.A_inv + (vec*vec.T)*float(common_factor), -float(common_factor)*vec]), hstack([-float(common_factor)*vec.T, common_factor])])
				
				# Update self.phi_mat
				self.phi_mat = vstack([hstack([self.phi_mat, phi_new]), hstack([phi_new_2.T, d])])
				
				# Add to basis
				self.basis = r_[self.basis, [x]]
				
				#print linalg.norm(linalg.inv(self.phi_mat*self.phi_mat.T+self.noise*eye(self.n+1)) - linalg.inv(self.A))
				#print linalg.norm(linalg.inv(self.A) - self.A_inv)
				
			# Add to points
			self.points = r_[self.points, [x]]
		
			# Add to self.Y
			self.Y = vstack([self.Y, mat([y])])
			
		self.n += 1
	
	def mean_var(self, x):
		phi_new = utility.compute_RBF(self.basis, x, self.length_scale)
		print phi_new
		intermediate = phi_new.T*self.A_inv
		
		mean = intermediate*self.phi_mat*self.Y
		var = self.noise*intermediate*phi_new
		
		return mean, var
	
	
if __name__ == "__main__":
	length_scale = array([5.0, 5.0])
	lm = linear_model(length_scale)
	
	for i in range(100):
		lm.add_data(array([1.0,2.0]), 2)
		#lm.add_data(array([1.5,1.5]), 8)
		#lm.add_data(array([0.5,2.5]), 8)
		#lm.add_data(array([1,2]), 8)
		#lm.add_data(array([1.5,1.5]), 8)
		#lm.add_data(array([0.5,2.5]), 8)
		
		#lm.add_data(array([1,2]), 8)
		#lm.add_data(array([1.5,1.5]), 8)
		#lm.add_data(array([0.5,2.5]), 8)
		#lm.add_data(array([1,2]), 8)
		#lm.add_data(array([1.5,1.5]), 8)
		#lm.add_data(array([0.5,2.5]), 8)
		
		#lm.add_data(array([1,2]), 8)
		#lm.add_data(array([1.5,1.5]), 8)
		#lm.add_data(array([0.5,2.5]), 8)
		#lm.add_data(array([1,2]), 8)
		#lm.add_data(array([1.5,1.5]), 8)
		#lm.add_data(array([0.5,2.5]), 8)
		
		#lm.add_data(array([1,2]), 8)
		#lm.add_data(array([1.5,1.5]), 8)
		#lm.add_data(array([0.5,2.5]), 8)
		#lm.add_data(array([1,2]), 8)
		#lm.add_data(array([1.5,1.5]), 8)
		#lm.add_data(array([0.5,2.5]), 8)
		
		#lm.add_data(array([1,2]), 8)
		#lm.add_data(array([1.5,1.5]), 8)
		#lm.add_data(array([0.5,2.5]), 8)
		#lm.add_data(array([1,2]), 8)
		#lm.add_data(array([1.5,1.5]), 8)
		#lm.add_data(array([0.5,2.5]), 8)
		
		#lm.add_data(array([1,2]), 8)
		#lm.add_data(array([1.5,1.5]), 8)
		#lm.add_data(array([0.5,2.5]), 8)
		#lm.add_data(array([1,2]), 8)
		#lm.add_data(array([1.5,1.5]), 8)
		#lm.add_data(array([0.5,2.5]), 8)
		
		#lm.add_data(array([1,2]), 8)
		#lm.add_data(array([1.5,1.5]), 8)
		#lm.add_data(array([0.5,2.5]), 8)
		#lm.add_data(array([1,2]), 8)
		#lm.add_data(array([1.5,1.5]), 8)
		#lm.add_data(array([0.5,2.5]), 8)
		
		#lm.add_data(array([1,2]), 8)
		#lm.add_data(array([1.5,1.5]), 8)
		#lm.add_data(array([0.5,2.5]), 8)
		#lm.add_data(array([1,2]), 8)
		#lm.add_data(array([1.5,1.5]), 8)
		#lm.add_data(array([0.5,2.5]), 8)
	print lm.mean_var(array([1.0,2.0]))