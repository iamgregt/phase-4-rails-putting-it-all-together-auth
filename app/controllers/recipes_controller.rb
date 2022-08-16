class RecipesController < ApplicationController
    before_action :authorize
    wrap_parameters format: []

    def index
        if session[:user_id]
            recipes = Recipe.all
            render json: recipes, include: :user
        else
        self.authorize
        end
    end

    def create
        recipe = Recipe.create!(recipe_params.merge(user_id: session[:user_id]))
        render json: recipe, status: :created, include: :user
    rescue ActiveRecord::RecordInvalid
        render_unprocessable_entity

    end

    private

    def render_unprocessable_entity
        render json: {errors: ["Test"]}, status: :unprocessable_entity
    end

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end

    def authorize
        return render json: { errors: ["Not Authorized"] }, status: :unauthorized unless session.include? :user_id
    end
end
