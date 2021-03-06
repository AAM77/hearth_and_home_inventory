class UsersController < ApplicationController

  ###################################################
  # FOR ALL ROUTES: If the user is not logged in,   #
  # it redirects to the home, signup, or login page #
  ###################################################


  ##########################################
  # Retrieves the Signup/Registration Page #
  ##########################################
  get "/signup" do
    if logged_in?
      flash[:login] = "You are already logged in."
      redirect "/#{current_user.slug}"
    else
      erb :"users/create_user"
    end
  end

  ###########################################
  # Registers a new account                 #
  # does not if the username or email exist #
  ###########################################
  post "/signup" do
    @user = User.find_by_username(params[:username])
    @email = User.find_by_email(params[:email])

    if @user || @email
      flash[:warning] = "That email or username is not valid. Please choose something else."
      redirect "/signup"

    elsif  params[:username].blank? || params[:email].blank? || params[:password].blank?
      flash[:warning] = "YOU MUST FILL OUT ALL FIELDS!!"
      redirect "/signup"

    elsif params[:username].match(/[\?\<\>\'\,\?\[\]\}\{\=\-\)\(\*\&\^\%\$\#\`\~\{\}@]/)
      flash[:warning] = "The username can contain only letters, digits, and underscores"
      redirect "/signup"

    elsif (5 > params[:username].length) || (params[:username].length > 20)
      flash[:warning] = "The length of the username must be between 5 and 20 characters long."
      redirect "/signup"

    elsif (5 > params[:password].length) || (params[:password].length > 30)
      flash[:warning] = "The length of the password must be between 5 and 30 characters long."
      redirect "/signup"

    else
      @user = User.create_user(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id

      flash[:success] = "You have successfully registered!"
      redirect "/folders"
    end
  end

  ############################
  # Retrieves the Login Page #
  ############################

  get "/login" do
    if logged_in?
      flash[:login] = "You are already logged in."
      redirect :"/#{current_user.slug}"
    else
      erb :"users/login_user"
    end
  end

  ##################################################
  # If the credentials exist and match,            #
  # it establishes a session and logs in the user  #
  ##################################################
  post "/login" do
    if !logged_in?
      @user = User.find_by_username(params[:username])

      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id

        flash[:success] = "You have successfully logged in!"
        redirect "/#{@user.slug}"

      else
        flash[:warning] = "Could not verify the password or username. Please check and try again."
        redirect "/login"
      end

    else
      flash[:login] = "Could not log you in. Please check your username and password and try again."
      redirect "/login"
    end
  end

  #############################################
  # Logs out the User by clearing the session #
  # & Returns to the Home Page                #
  #############################################
  get "/logout" do
    if logged_in?

      session.clear

      flash[:success] = "You have successfully logged out."
      redirect "/"
    else
      flash[:login] = "You are not logged in. Please Log in or Register."
      redirect "/login"
    end
  end


  ##########################
  # Displays the edit form #
  ##########################
  get "/:slug/edit" do
    if logged_in?
      erb :"users/edit_user"
    else
      flash[:login] = "You are not logged in. Please Log in or Register."
      redirect "/login"
    end
  end

  #################################################
  # Changes the User's Information if any Entered #
  #################################################
  patch "/:slug/edit" do

    if logged_in?
      @user = current_user

      @user.first_name = params[:first_name] if !params[:first_name].empty?
      @user.last_name = params[:last_name] if !params[:last_name].empty?
      @user.telephone = params[:telephone] if !params[:telephone].empty?
      @user.email = params[:email] if !params[:email].empty?
      @user.save!(validate: false)

      flash[:success] = "Your information has been successfully updated."
      redirect "/#{@user.slug}/user_info"

    else
      flash[:login] = "You are not logged in. Please Log in or Register."
      redirect "/login"
    end
  end

  ##################################
  # Retrieves the user's info page #
  ##################################

  get "/:slug/user_info" do
    if logged_in?
      @user = current_user
      erb :"users/user_info"
    else
      flash[:login] = "You are not logged in. Please Log in or Register."
      redirect "/login"
    end
  end


  ##################################
  # Retrieves the User's Home Page #
  ##################################
  get "/:slug" do
    if logged_in?
      @user = current_user
      erb :"users/show_user"
    else
      flash[:login] = "You are not logged in. Please Log in or Register."
      redirect "/signup"
    end
  end


  ##########################################
  # Permanently Deletes the User's Account #
  ##########################################
  delete "/:slug/delete" do
    if logged_in?
      @user = User.find_by_slug(params[:slug])
      if @user.id == current_user.id
        @user.destroy

        flash[:success] = "Your account was successfully deleted."
        redirect "/"
      else
        flash[:warning] = "Could not delete your account."
        redirect "/#{@user.slug}"
      end

    else
      flash[:login] = "You are not logged in. Please Log in or Register."
      redirect "/login"
    end
  end

end
