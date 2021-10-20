class TagsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @tags = Tag.all.map{|tag| tag.name}
    render json: { "tags": @tags }
  end
end