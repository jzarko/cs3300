# Kevyn Kelso helped with this
module Auth
    def create_user!
      # @user = User.create(email: 'foo@bar.com', password: '11111111')
      @user = FactoryBot.create(:user)
    end
  
    def sign_in_user!
      setup_devise_mapping!
      sign_in @user
    end
  
    def sign_out_user!
      setup_devise_mapping!
      sign_out @user
    end
  
    def setup_devise_mapping!
      @request.env['devise.mapping'] = Devise.mappings[:user]
    end
  
    def login_and_logout_with_devise
      sign_in_user!
      yield
      sign_out_user!
    end
  end