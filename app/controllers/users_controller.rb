class UsersController < ApplicationController

    before_action :authorize, only: :show

    def create
        user = User.create(user_params)
        if user.valid?
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
    end


    def show
        render json: User.find_by(id: session[:user_id])
    end

    private

    def user_params
        params.permit(:username, :password, :password_confirmation, :bio, :image_url)
    end
end
