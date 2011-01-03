class AuthenticationsController < ApplicationController
  def index()

  end
  def create()
    auth = request.env["rack.auth"]
    authentication = Authentication.find_by_uid(auth['uid'])
    if authentication
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user
      current_user.authentications.create(:uid => auth['uid'], :token => auth['credentials']['token'])
    else
      user = User.new
      user.apply_omniauth(auth)
      user.save()
      sign_in_and_redirect(:user, user)
    end
  end

end
