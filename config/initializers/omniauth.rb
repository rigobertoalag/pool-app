Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '464896255623-ob4ht072log3042voq6mknhsb09h4cb9.apps.googleusercontent.com',
           '5yxcuPS6yn1vOj10uoQK_IbA'
end
OmniAuth.config.allowed_request_methods = %i[get]
