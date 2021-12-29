class TagSelector
  include Service

  def call
    tags = Tag.all.map{|tag| tag.name}
    count = tags.size
    # Green socks tag have a bug so filtered
    tags = tags.filter {|item| item != "green"}
    result = []
    for @i in 0..count-1
      result.append(tags.fetch(@i))
    end
    result = result.sort{|a, b| a <=> b }
    return result
  end

end