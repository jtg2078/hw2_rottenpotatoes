class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
  	@all_ratings = Movie.ratings
  	@saved_ratings = nil
  	@saved_sort = nil
  	
  	#make it restful
  	if((params.has_key?(:sort) == false && session.has_key?(:sort) == true) && (params.has_key?(:ratings) == false && session.has_key?(:ratings) == true))
  		redirect_to :ratings=>session[:ratings], :sort=>session[:sort]
  	elsif (params.has_key?(:sort) == false && session.has_key?(:sort) == true)
  		redirect_to :sort=>session[:sort]
  	elsif (params.has_key?(:ratings) == false && session.has_key?(:ratings) == true)
  		redirect_to :ratings=>session[:ratings]
  	end
  	
  	
  	has_sort_filter = false
  	has_ratings_filter = false
  	
  	if(params.has_key?(:sort) == true)
  		has_sort_filter = true
  		session[:sort] = params[:sort]
  		@saved_sort = params[:sort]
  	end
  	
  	if(params.has_key?(:ratings) == true)
  		has_ratings_filter = true
  		session[:ratings] = params[:ratings]
  		@saved_ratings = params[:ratings]
  	end
  	
  	if(has_sort_filter == true && has_ratings_filter == true)
  		@movies = Movie.where(:rating => params[:ratings].keys).order(params[:sort])
  	elsif (has_sort_filter == true)
  		@movies = Movie.order(params[:sort])
  	elsif (has_ratings_filter == true)
  		@movies = Movie.where(:rating => params[:ratings].keys)
  	else
  		@movies = Movie.all
  	end
  
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
