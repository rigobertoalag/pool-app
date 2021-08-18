module UserAuthentication
    extend ActiveSupport:Concern

    def user_signed_in?
        !current_user.nil?
    end

    def current_user 
        User.where(id: session[:user_id]).first
    end
end