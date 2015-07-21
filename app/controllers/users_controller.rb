class UsersController < ApplicationController
  
  #your method and your erb should be named the same.
  
  
  def home
    redirect_to "/users"
  end
  
  def list
    @user = User.all
  end
  
end
