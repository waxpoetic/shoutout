class UsersController < ApplicationController
  expose :users, only: [:index]
  expose :user, only: [:show]

  def index
    respond_with users
  end

  def show
    respond_with user
  end
end
