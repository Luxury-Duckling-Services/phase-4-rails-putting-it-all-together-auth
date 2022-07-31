class RecipesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

    before_action :authorize

    def index
        render json: Recipe.all
    end

    def create
        recipe = @current_user.recipes.create!(recipe_params)
        render json: recipe, status: :created
    end

    private

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end

    def render_not_found(exception)
        render json: { error: "#{exception.model} not found"}, status: :not_found
    end


    def record_invalid(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def authorize
        @current_user = User.find_by(id: session[:user_id])
    
        render json: { errors: ["Not authorized"] }, status: :unauthorized unless @current_user
    end
    

end
