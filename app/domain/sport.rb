class Sport
  attr_accessor :id, :title

  def initialize(args={})
    @id = args[:id]
    @title = args[:title]
  end
end
