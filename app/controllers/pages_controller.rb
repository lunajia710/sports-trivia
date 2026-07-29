class PagesController < ApplicationController
  before_action :authenticate_user!, only: :my_decks
  def home
  end

  def my_decks
    @decks = current_user.decks.includes(:questions)
  end
end
