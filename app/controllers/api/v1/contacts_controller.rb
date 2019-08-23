class Api::V1::ContactsController < ApplicationController
    def index
        @contact = Contact.select(:id, :name)
        if @contact.present?
        render json: { status: 'OK', results: @contact, error: nil 
            }, status: :ok
        else
        render json: {
            status: 'FAIL', results: nil, error: 'Data is empty'
        }, status: :unprocessable_entity
        end
    end
    # method to show specific contact
    def show
        @contact = Contact.find(params[:id])
        if @contact.present?
        render json: {
            status: 'OK', results: @contact.as_json(include: %i[no_contacts]), error: nil
        }, status: :ok
        else
        not_process
        end
    end
    
    # method to save new contact
    def create
        contact = Contact.new(contact_params)
        if contact.save
        contact.reload
        render json: {
            status: 'OK', results: contact, error: nil
        }, status: :created
        else
        not_process
        end
    end
    
    # method to update contact that have exist
    def update
        @contact = Contact.find(params[:id])
        update_contact = @contact.update(contact_params)
        if update_contact
        render json: {
            status: 'OK', results: update_contact, error: nil
        }, status: :ok
        else
        not_process
        end
    end
    
    # method to delete contact base on id
    def destroy
        if @contact == Contact.find(params[:id])
        @contact.destroy!
        render json: {
            status: 'OK', results: 'Delete success', error: nil
        }, status: :ok
        else
        not_process
        end
    end
    private

    def not_process
      render json: {
        status: 'FAIL', results: nil, error: 'Data fail to process'
      }, status: :unprocessable_entity
    end
  
    def find_contact
      @contact = Contact.find(params[:id])
    end
  
    def contact_params
      params.permit(:name, :address, :company)
    end
  
end
