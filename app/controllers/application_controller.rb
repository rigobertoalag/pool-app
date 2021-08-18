class ApplicationController < ActionController::Base
    include UserAuthentication
    skip_forgery_protection 

    #before_action :authenticate
    before_action :set_jbuilder_defaults


    protected

    def authenticate
        token_str = params[:token]
        token = Token.find_by(token: token_str)

        if token.nil?
            #render json: { error: "El token es nulo" }, status: :unauthorized
            error!("El token es invdalido por que es nulo", :unauthorized)
        elsif !token.is_valid?
            #render json: { error: "El token es invalido" }, status: :unauthorized
            error!("El token es invdalido", :unauthorized)
        else
            @current_user = token.user
        end
    end

    def set_jbuilder_defaults
        @errors = []
    end

    def error!(message, status)
        @errors << message
        response.status = status
        render template: "api/v1/errors"
    end

    def error_array!(array, status)
        @errors = @errors + array
        response.status = status
        render "api/v1/errors"
    end

    def authenticate_owner(owner)
      if owner != @current_user
        render json: { errors: 'No tienes permiso para editar este recurso' }, status: 401
      end
    end    

end
