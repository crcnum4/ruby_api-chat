class MessagesController < ApplicationController

  def send_error(message)
    @json = {:status => "error", :message => message}
    render json: @json, status: :uprocessable_entity
  end
  
  def send_error_obj(message)
    @json = {:status => {:status => "error"}, :message => message}
    render json: @json, status: :uprocessable_entity
  end
  
  # GET /chat
  # GET /chat.json
  def chat
    if params[:user] && params[:opp]
      @user = User.find_by_id(params[:user])
      if @user
        @opp = User.find_by_id(params[:opp])
        if @opp
          @messages = Message.all_messages(@user.id, @opp.id)
          @json = {:status => {:status => "success"}, :messages => @messages.as_json(:only => [:origin, :opponent, :created_at])}
          render json: @json
        else
          send_error_obj("opp not found")
        end
      else
        send_error_obj("user not found")
      end
    else
      send_error_obj("bad parameters")
    end
  end
  
  
  # GET /update
  # GET /update.json
  def update
    if params[:user] && params[:opp] && params[:time]
      @user = User.find_by_id(params[:user])
      if @user
        @opp = User.find_by_id(params[:opp])
        if @opp
          @messages = Message.update_messages(@user.id, @opp.id, params[:time])
          if @messages
            @json = {:status => {:status => "success"}, :messages => @messages.as_json(:only => [:origin, :opponent, :created_at])}
            render json: @json
          end
        else
          send_error_obj("opp not found")
        end
      else
        send_error_obj("user not found")
      end
    else
      send_error_obj("bad parameters")
    end
  end
  
  
  # POST /send
  # POST /messages.json
  def create
    if params[:user] && params[:opp] && params[:message]
      @user = User.find_by_id(params[:user])
      if @user
        @opp = User.find_by_id(params[:opp])
        if @opp
          @message = Message.new(origin: @user.id, opponent: @opp.id, message: params[:message])
          if @message.save
            @json = {:status => "success", :id => "#{@message.id}"}
            render json: @json
          else
            send_error("failed to send message")
          end
        else
          send_error("recipient not found")
        end
      else
        send_error("user not found")
      end
    else
      send_error("bad parameters")
    end
  end


end
