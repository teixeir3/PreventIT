Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"],
    {approval_prompt: '',
     access_type: 'offline',
     scope: 'https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/calendar'}
end