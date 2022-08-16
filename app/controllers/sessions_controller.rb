class SessionsController < ApplicationController

    def create
        user = User.find_by(username: params[:username])
        # if !user
        #     render json: {error: "Not found"}, status: :unauthorized
        # else 
        if user&.authenticate(params[:password])
            session[:user_id] = user.id 
            render json: user, status: :created
        else  
        render json: {errors: ["Invalid Username"] }, status: :unauthorized
        # end
        end
    end
end
