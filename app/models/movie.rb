class Movie < ActiveRecord::Base
	def self.ratings()
		self.select("DISTINCT(rating)").map { |movie| movie.rating }
		#['a','b','c']
    end 
end
