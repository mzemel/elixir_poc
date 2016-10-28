class UploadsController < ApplicationController
  def create
    upload = Upload.create(name: params["name"])
    respond_to do |format|
      format.json { render json: {id: upload.id} }
    end
  end
end