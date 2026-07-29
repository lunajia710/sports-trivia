class ChatsController < ApplicationController
  def show
    @chat = Chat.find(params[:id])
    @deck = @chat.deck
    @message = Message.new
  end

  def confirm
    @chat = Chat.find(params[:id])
    @deck = @chat.deck
    @chat.destroy
    redirect_to decks_path
  end
end
