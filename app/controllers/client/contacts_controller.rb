class Client::ContactsController < ApplicationController
  def index
    response = Unirest.get("http://localhost:3000/api/contacts")
    @contacts = response.body
    render 'index.html.erb'
  end

  def new
   render 'new.html.erb' 
  end

  def create
    contact_params ={
                    first_name: params[:first_name],
                    middle_name: params[:middle_name],
                    last_name: params[:last_name],
                    bio: params[:bio],
                    email: params[:email],
                    phone_number: params[:phone_number]
                    }
    response = Unirest.post(
                            "http://localhost:3000/api/contacts",
                            parameters: contact_params
                            )
    contact = response.body

    redirect_to "/client/contacts/#{contact["id"]}"
  end

  def show
    contact_id = params[:id]
    response = Unirest.get("http://localhost:3000/api/contacts/#{contact_id}")
    @contact = response.body
    render 'show.html.erb'
  end

  def edit
    contact_id = params[:id]
    response = Unirest.get("http://localhost:3000/api/contacts/#{contact_id}")
    @contact = response.body
    render 'edit.html.erb'
  end

  def update
    client_params = {
                    first_name: params[:first_name],
                    middle_name: params[:middle_name],
                    last_name: params[:last_name],
                    bio: params[:bio],
                    email: params[:email],
                    phone_number: params[:phone_number]
                    }
    response = Unirest.patch(
                            "http://localhost:3000/api/contacts/#{params[:id]}",
                            parameters: client_params
                            )
    contact = response.body
    flash[:success] = "Successfully Updated Contact"
    redirect_to "/client/contacts/#{contact["id"]}"
  end

  def destroy
    contact_id = params[:id]
    response = Unirest.delete(
                              "http://localhost:3000/api/contacts/#{ contact_id }"
                              )
    redirect_to "/"
  end
end
