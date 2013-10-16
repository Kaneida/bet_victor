class Outcome
  attr_accessor :id, :sport_id, :event_id, :description

  def initialize(args)
    @id = args[:id]
    @sport_id = args[:sport_id],
    @event_id = args[:event_id]
    @description = args[:description]
  end
end
