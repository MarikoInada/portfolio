Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'],
      {
        redirect_uri: ENV['APP_URL'] + "/oauth/callback",
        prompt: 'consent',
        scope: 'userinfo.email, userinfo.profile'
      }
end