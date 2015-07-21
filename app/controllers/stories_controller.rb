class StoriesController < ApplicationController
  
  def new
    @story = Story.new
    @user = User.find(params[:id])
  end
  
  def save
    @user = User.find(params[:user_id])
    @story = @user.stories.create({name: params[:name], content: params[:content]})
    if @story.valid?
      redirect_to "/users/#{@user.id}"
    else
      redirect_to "/users/#{@user.id}/stories/new"
    end
    
  end
  
  def edit
    @user = User.find(params[:user_id])
    if session[:user_id] && session[:user_id] == (@user.id).to_i
      @story = Story.find(params[:id])
      render :edit
    else
      render :"error_404"
    end
  end
  
  def edit_save
    @story = Story.find(params[:id])
    @story.name = params[:name]
    @story.content = params[:content]
    @story.save
    redirect_to "/users/#{@story.user_id}"
  end
  
  
end
