class Accounts::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
        handle_auth "Google"
      end
    
    def handle_auth(kind)
        # You need to implement the method below in your model (e.g. app/models/user.rb)
        @account = Account.from_omniauth(request.env['omniauth.auth'])
  
        if @account.persisted?
          flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: kind
          sign_in_and_redirect @account, event: :authentication
        else
          session['devise.auth_data'] = request.env['omniauth.auth'].except('extra') # Removing extra as it can overflow some session stores
          redirect_to new_account_registration_url, alert: @account.errors.full_messages.join("\n")
        end
    end
  end