class Outcome
  attr_accessor :id, :description

  def initialize(args)
    @id = args["id"]
    @description = args["description"]
  end
end
