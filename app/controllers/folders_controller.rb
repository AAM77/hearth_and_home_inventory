require 'pry'

class FoldersController < ApplicationController

  ###################################################
  # FOR ALL ROUTES: If the user is not logged in,   #
  # it redirects to the home, signup, or login page #
  ###################################################



  ###################################
  # Displays the User's folders     #
  ###################################
  get "/:slug/folders" do
    if logged_in?
      @folders = current_user.folders
      erb :"folders/folder_index"
    else
      redirect "/"
    end
  end

  ###################################
  # Displays the create_folder form #
  ###################################
  get "/:slug/folders/new" do
    if logged_in?
      @items = current_user.items
      erb :"folders/create_folder"
    else
      redirect "/login"
    end
  end

  ############################################################
  # Using the input params during folder creation to check   #
  # if a folder with the same name exists before creating it #
  ############################################################
  post "/:slug/folders/new" do
    if logged_in?

      if params[:folder][:name] == ""
        redirect "/#{current_user.slug}/folders/new"
      else
        @folder = Folder.create(name: params[:folder][:name])

        add_existing_items_to_the_folder(params[:folder][:item_ids], @folder)
        add_the_newly_created_item_to_the_folder(params[:item][:name], @folder)
        current_user.folders << @folder

        redirect "/#{current_user.slug}/folders"
      end #params[:folder][:name] empty

    else
      redirect "/login"
    end #logged_in?
  end

  ###############################################################
  # Displays the edit_folder form                               #
  # Allows the user to add and remove items from the folder     #
  # Allows the user to create and add a new item to the folder  #
  ###############################################################

  get "/:user_slug/folders/:folder_slug/edit" do
    if logged_in?
      @folder = Folder.find_by_folder_slug(params[:folder_slug], current_user.id)
      @items = current_user.items

      if @folder
        erb :"folders/edit_folder"
      else
        redirect "/#{current_user.slug}/folders"
      end

    else
      redirect "/login"
    end
  end


  ######################################################################
  # Uses the input information to edit the folder's name and contents #
  ######################################################################

  patch "/:user_slug/folders/:folder_slug/edit" do
    if logged_in?
      @folder = Folder.find_by_folder_slug(params[:folder_slug], current_user.id)
      folder_name_exists = !Folder.find_by_folder_name(params[:folder][:name], current_user.id).empty?

      if @folder
        if folder_name_exists
          redirect "/#{current_user.slug}/folders/#{@folder.slug}/edit"

        else
          @folder.name = params[:folder][:name] if params[:folder][:name] != ""
          add_existing_items_to_the_folder(params[:folder][:item_ids], @folder) { @folder.items.clear }
          add_the_newly_created_item_to_the_folder(params[:item][:name], @folder)

          @folder.save
          redirect "/#{current_user.slug}/folders"
        end # folder_name_exists?
      end #if @folder

    else
      redirect "/login"
    end # if logged_in?
  end # patch

  ####################################
  # Show route for a specific folder #
  ####################################
  get "/:user_slug/folders/:folder_slug" do
    if logged_in?
      @folder = Folder.find_by_folder_slug(params[:folder_slug], current_user.id)
      erb :"folders/show_folder"
      # lists the items in alphabetical order
    else
      redirect "/login"
    end
  end


  ######################################
  # Delete route for a specific folder #
  ######################################

  delete "/:user_slug/folders/:folder_slug/delete" do
    if logged_in?

      @folder = Folder.find_by_folder_slug(params[:folder_slug], current_user.id)

      if @folder.user_id == current_user.id
        @folder.destroy
        flash[:success_message] = "Successfully deleted folder: [ #{@folder.name} ]"
        redirect "/#{current_user.slug}/folders"
      else
        flash[:fail_message] = "ERROR: Could not delete folder: [ #{@folder.name} ]."
        redirect "/#{current_user.slug}"
      end

    else
      redirect "/login"
    end
  end


end
