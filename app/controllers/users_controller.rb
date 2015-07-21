class UsersController < ApplicationController
  
  #your method and your erb should be named the same.
  
  def home
    redirect_to "/users"
  end
  
  def list
    @user = User.all
  end
  
  def new
    @user = User.new
  end
  
  def save
    the_password = BCrypt::Password.create(params[:password])
    @user = User.new({name: params[:name], email: params[:email], password: the_password})
    if @user.valid?
      @user.save
      redirect_to "/users/#{@user.id}"
    else
      @error = true
      redirect_to "/users/new"
    end
  end
  
  def profile
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def edit_save
    @user = User.find(params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    @user.save
    redirect_to "users/#{@user.id}"
    #back to profile
  end
    

end
