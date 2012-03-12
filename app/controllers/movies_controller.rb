class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
  	@all_ratings = Movie.ratings 
  	if (params.has_key?(:sort) == true)
  		if(params.has_key?(:ratings) == true)
  			if(params[:ratings].keys.nil? == false)
  				@movies = Movie.where(:rating => params[:ratings].keys).order(params[:sort]).all
  				session[:sort] = params[:sort]
  				session[:ratings] = params[:ratings]
  				@saved_ratings = params[:ratings]
  			end
  		else
  			@movies = Movie.order(params[:sort]).all
  			session[:sort] = params[:sort]
  		end
  	else
  		if(params.has_key?(:ratings) == true)
  			if(params[:ratings].keys.nil? == false)
  				@movies = Movie.where(:rating => params[:ratings].keys)
  				session[:ratings] = params[:ratings]
  				@saved_ratings = params[:ratings]
  			end
  		else
  			@movies = Movie.all
  			session[:sort] = nil
  			session[:ratings] = nil
  		end
  	end
  	
  	if(session[:sort] != nil && session[:ratings] != nil)
  		@movies = Movie.where(:rating => session[:ratings].keys).order(session[:sort]).all
  	elsif(session[:sort] != nil)
  		@movies = Movie.order(session[:sort]).all
  	elsif(session[:ratings] != nil)
  		@movies = Movie.where(:rating => session[:ratings].keys)
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
