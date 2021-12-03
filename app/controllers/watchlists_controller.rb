class WatchlistsController < ApplicationController
  def index
    matching_watchlists = Watchlist.all

    @list_of_watchlists = matching_watchlists.order({ :created_at => :desc })

    render({ :template => "watchlists/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_watchlists = Watchlist.where({ :id => the_id })

    @the_watchlist = matching_watchlists.at(0)

    render({ :template => "watchlists/show.html.erb" })
  end

  def create
    the_watchlist = Watchlist.new
    the_watchlist.user_id = params.fetch("query_user_id")
    the_watchlist.pet_id = params.fetch("query_pet_id")

    if the_watchlist.valid?
      the_watchlist.save
      redirect_to("/watchlists", { :notice => "Watchlist created successfully." })
    else
      redirect_to("/watchlists", { :notice => "Watchlist failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_watchlist = Watchlist.where({ :id => the_id }).at(0)

    the_watchlist.user_id = params.fetch("query_user_id")
    the_watchlist.pet_id = params.fetch("query_pet_id")

    if the_watchlist.valid?
      the_watchlist.save
      redirect_to("/watchlists/#{the_watchlist.id}", { :notice => "Watchlist updated successfully."} )
    else
      redirect_to("/watchlists/#{the_watchlist.id}", { :alert => "Watchlist failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_watchlist = Watchlist.where({ :id => the_id }).at(0)

    the_watchlist.destroy

    redirect_to("/watchlists", { :notice => "Watchlist deleted successfully."} )
  end
end