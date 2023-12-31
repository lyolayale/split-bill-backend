class FriendsController < ApplicationController
  def index
    friends = Friend.all
    render json: friends
  end

  def create
    friend = Friend.create(friend_params)
    if friend.valid?
      render json: friend
    else
      render json: friend.errors, status: 422
    end
  end

  def update
    friend = Friend.find(params[:id])
    friend.update(friend_params)
    if friend.valid?
      render json: friend
    else
      render json: friend.errors, status: 422
    end
  end

  def destroy
    friend = Friend.find(params[:id])
    if friend.destroy
      render json: friend
    else
      render json: friend.errors
    end
  end

  private

  def friend_params
    params.require(:friend).permit(:name, :event, :balance)
  end
end
