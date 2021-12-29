class TagSelector
  include Service

  def call
    result = Tag.all.map{|tag| tag.name}
    return result
  end

end