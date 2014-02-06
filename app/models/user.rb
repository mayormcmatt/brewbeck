class User < ActiveRecord::Base
#do this validation stuff much later in the app
    has_secure_password
    before_save :create_remember_token

    private

        def create_remember_token
            self.remember_token = SecureRandom.urlsafe_base64
        end
    # validates :first_name, presence: true
    # validates :last_name, presence: true
    # validates :age, presence: true
    # validates :city, presence: true
    # validates :password, presence: true
    # validates :password, confirmation: true

end
