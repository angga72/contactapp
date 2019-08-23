class Api::V1::NoContactsController < ApplicationController
    def index
        @nocontact = NoContact.all
        if @nocontact.present?
        render json: { status: 'OK', results: @nocontact, error: nil 
            }, status: :ok
        else
        render json: {
            status: 'FAIL', results: nil, error: 'Data is empty'
        }, status: :unprocessable_entity
        end
    end
    # method to show specific @nocontact
    def show
        @nocontact = NoContact.find(params[:id])
        if @nocontact.present?
        render json: {
            status: 'OK', results: @nocontact, error: nil
        }, status: :ok
        else
        not_process
        end
    end
    
    # method to save new @nocontact
    def create
        @nocontact = NoContact.new(contact_params)
        if @nocontact.save
        @nocontact.reload
        render json: {
            status: 'OK', results: @nocontact, error: nil
        }, status: :created
        else
        not_process
        end
    end
    
    # method to update @nocontact that have exist
    def update
        @nocontact = NoContact.find(params[:id])
        update_nocontact = @nocontact.update(contact_params)
        if update_nocontact
        render json: {
            status: 'OK', results: update_contact, error: nil
        }, status: :ok
        else
        not_process
        end
    end
    
    # method to delete @nocontact base on id
    def destroy
        if @nocontact == NoContact.find(params[:id])
        @nocontact.destroy!
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
      @nocontact = NoContact.find(params[:id])
    end
  
    def nocontact_params
      params.permit(:contact_id, :type, :number)
    end
  
end
