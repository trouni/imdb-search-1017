class MoviesController < ApplicationController
  def index
    @movies = 
      if params[:query].present?
        # PG Search Implementation
        Movie.search(params[:query])

        # # SQL Implementation
        # sql_query = <<~SQL
        #   title @@ :q
        #   OR synopsis @@ :q
        #   OR directors.first_name @@ :q
        #   OR directors.last_name @@ :q
        #   SQL
        #   Movie.joins(:director).where(sql_query, q: "%#{params[:query]}%")
      else
        Movie.all
      end

    @movies = @movies.where(year: params[:year].to_i) if params[:year].present?

    # @movies = @movies.where('year >= ?', params[:from].to_i) if params[:from].present?
    # @movies = @movies.where('year <= ?', params[:to].to_i) if params[:to].present?

    # For location based search, remember that Geocoder gives us the `near` scope
    # @movies = @movies.near('Tokyo', 10)
  end
end
