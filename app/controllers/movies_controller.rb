class MoviesController < ApplicationController
  def index
    if params[:query].present?

      # Somente a busca exata (case sensitive)
      # @movies = Movie.where(title: params[:query])

      # Busca qualquer title que contenha query (case insensitive)
      # @movies = Movie.where('title ILIKE ?', "%#{params[:query]}%")

      # Busca pelo title e synopsis
      # sql = 'title ILIKE :query OR synopsis ILIKE :query'
      # @movies = Movie.where(sql, query: "%#{params[:query]}%")


      # Busca por title, synopsis e director
      # sql = <<~SQL
      #   movies.title ILIKE :query
      #   OR movies.synopsis ILIKE :query
      #   OR directors.first_name ILIKE :query
      #   OR directors.last_name ILIKE :query
      # SQL
      # @movies = Movie.joins(:director).where(sql, query: "%#{params[:query]}%")

      # Busca por palavras separadas (fulltext search)
      # sql = <<~SQL
      #   movies.title @@ :query
      #   OR movies.synopsis @@ :query
      #   OR directors.first_name @@ :query
      #   OR directors.last_name @@ :query
      # SQL
      # @movies = Movie.joins(:director).where(sql, query: "%#{params[:query]}%")


      # Search com pg_search
      # @movies = Movie.search_by_title_and_synopsys(params[:query])

      # Multisearch por movie e tv_show
      @documents = PgSearch.multisearch(params[:query])

    else
      @documents = PgSearch::Document.all
    end
  end
end
