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
      redirect_to "/users/#{@user.id}" #should redirect to login
    else
      @error = true
      redirect_to "/users/new"
    end
  end
  
  def profile
    if session[:user_id] && session[:user_id] == params[:id].to_i
      @user = User.find(params[:id])
      render :profile
    else
      redirect_to "/users/#{session[:user_id]}"
    end
  end
  
  def edit
    if session[:user_id] && session[:user_id] == params[:id].to_i
      @user = User.find(params[:id])
      render :edit
    else
      redirect_to "/users/#{session[:user_id]}"
    end
  end
  
  def edit_save
    @user = User.find(params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    @user.save
    redirect_to "/users/#{@user.id}"
    #back to profile
  end
  
  def delete
    @user = User.find(params[:id])
    @user.destroy
    redirect_to "/users"
  end
  
  def login
    @user = User.new
  end
  
  def logout
    session[:user_id] = nil
    redirect_to "/login"
  end
  
  def valid
    @user = User.where({email:params[:email]}).first
    if @user.nil?
      @error = true
      redirect_to "/login"
    else
      user_password = BCrypt::Password.new(@user.password)
  
      if user_password == params[:password]
        session[:user_id] = @user.id
        redirect_to "/users/#{@user.id}"
      else
        redirect_to "/login"
      end
    end
  end
    
end
