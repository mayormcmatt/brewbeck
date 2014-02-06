class SessionsController < ApplicationController

    def new
    end

    def create
        signin_params = params[:session]
        user=User.find_by_email(signin_params[:email].downcase)
        if user && user.authenticate(signin_params[:password])
            # Sign the user in and redirect to the user's show page.
            # sign_in user
            redirect_to user
        else
            # Create an error message and re-render the signin form.
            flash.now[:error]='Invalid email/password combination'
            render :new
        end
    end

    def destroy
        redirect_to root_url
    end
    
end


# def create
#         # alternately could do user = user.find_by_email(params[:session][:email])
#         login_params = params[:session]
#         user = user.find_by_email(login_params[:email].downcase)
#         #next line determines if user is valid via boolean comparison
#         if user && user.authenticate(login_params[:password])
#             redirect_to "/beers/new" #should I take users to profile page instead?
#         else
#             flash.now[:error] = "Invalid email/password combination"
#             render "new"
#         end
#     end