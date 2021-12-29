class TagsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @tags = TagSelector.call
    render json: { "tags": @tags }
  end
end