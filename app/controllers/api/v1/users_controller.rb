class Api::V1::UsersController < ApplicationController
    #POST /users
    def create
        #if !params[:auth]
        if !params
            render json: { error: "Auth params is missing" }
        else
            #@user = User.from_omniauth(params[:auth])
            @user = User.from_omniauth(params)

            @token = @user.tokens.create()
    
            render "api/v1/users/show"
        end
    end
end