class UsersController < ApplicationController

    def index
    end

    def show
        @user = User.find(params[:id])
    end

    def new
        @user = User.new()
    end

    def create
        #want user creation to also enable new session
        new_user = params.require(:user).permit(:first_name, :last_name, :age, :email, :password, :password_confirmation)
        @user=User.new(new_user)
        if @user.save
            flash[:success] = "Welcome to the Cook Book app!"
            # sign_in @user
            redirect_to @user
        else
            render'new'
        end
    end

    def edit
    end

    def update
        @user = User.find(params[:id])
        @user.update_attributes(params[:user])
        render :show
    end

    def destroy
    end

end

 # def create
 #        #want user creation to also enable new session
 #        @user = User.new(params[:user].permit(:first_name, :last_name, :age, :email, :password, :password_confirmation))
 #        if @user.save
 #            flash[:success] = "Welcome to Brewbeck!"
 #            redirect_to "/users/params[:id]" #probably going to want this to redirect to new session
 #        else
 #            redirect_to "/users/new"
 #        end
 #    end
