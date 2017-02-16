class UsersController < ApplicationController

  def send_error(message)
    @json = {:status => "error", :message => message}
    render json: @json, status: :uprocessable_entity
  end

  # POST /register
  # POST /register.json
  def create
    if params[:user] && params[:pass]
      if User.find_by_username(params[:user])
        send_error("user exists")
      else
        @user = User.new(username: params[:user], password: params[:pass])
        if @user.save
          @json = {:status => "success", :id => "#{@user.id}"}
          render json: @json
        else
          send_error("failed to create new user")
        end
      end
    else
      send_error("bad parameters")
    end
  end
  
  # POST /login
  # POST /login.json
  def login
    
  end

end
