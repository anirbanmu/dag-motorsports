class GamesController < ApplicationController
  def show
    @game = Game.find(params.permit(:id)[:id])
  end

  def index
    @games = Game.all
  end
end
