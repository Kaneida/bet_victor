class Event
  attr_accessor :id, :title, :pos, :outcomes

  def initialize(args)
    @id = args["id"]
    @title  = args["title"]
    @pos = args["pos"]

    @outcomes = args["outcomes"].to_a.inject([]) do |outcomes, o|
      outcomes << Outcome.new(o)
    end
  end
end
