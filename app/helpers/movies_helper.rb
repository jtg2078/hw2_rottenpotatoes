module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  def should_hilite(name)
  	if (params.has_key?(:sort) == true)
  		name == params[:sort] ? :hilite : :nohilite
  	else
  		:nohilite
  	end
  end
end
