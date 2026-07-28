class ChatsController < ApplicationController
  def create
    @chat = chat_scope.new
    if @chat.save
      redirect_to @chat
    else
      puts "error msg", status: :unprocessable_entity
    end
  end

  def show
    @chat = chat_scope.find(params[:id])
    @message = Message.new
  end

  private

  def chat_scope
    current_user.chats
  end
end
