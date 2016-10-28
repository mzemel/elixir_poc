class StatusController < ApplicationController
  def show
    status = Status.status(params["id"])
    render json: {status: status}
  end
end