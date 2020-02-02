class MessagesController < ApplicationController
  def search
    result = Search.call(term: search_params[:term])
    render json: result.to_json
  end

  private

  def search_params
    params.permit(:term)
  end
end
