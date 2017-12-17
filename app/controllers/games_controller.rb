class GamesController < ApplicationController
  def show
    @game = Game.find_by_id(params.require(:id))
  end

  def index
    @games = Game.all
  end
end
