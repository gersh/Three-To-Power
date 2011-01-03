Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '187789424565510', '99e720d560570135db462ed999fc4116',{:scope => "email,publish_stream"}
end
