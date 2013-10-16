class Event
  attr_accessor :id, :sport_id, :title, :pos

  def initialize(args)
    @id = args[:id]
    @sport_id = args[:sport_id]
    @title  = args[:title]
    @pos = args[:pos]
  end
end
