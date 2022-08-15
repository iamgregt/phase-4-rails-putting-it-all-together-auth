class UsersController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_processable_entity
    def create

        user = User.create!(user_params)
        if params[:password] == params[:password_confirmation]
        session[:user_id] = user.id
        render json: user, status: :created
        else 
        render json: {errors: user.errors.full_messages}, status: :unprocessable_entity
        end
    rescue ActiveRecord::RecordInvalid => e 
        render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
    
    end

    def show
        user = User.find_by(id: session[:user_id])
        if user
        render json: user
        else  
        render json: {error: "Not authorized"}, status: :unauthorized
        end
    end

    private

    def user_params
        params.permit(:username, :password, :image_url, :bio)
    end

    def render_processable_entity
        render json: {error: "h"}, status: :unprocessable_entity
    end
end
