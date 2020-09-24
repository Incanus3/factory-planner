module FactoryPlanner
  class Action
    attr_reader :name

    def initialize(name)
      @name = name
    end
  end

  class Plan
    def steps
      [Action.new(:craft_stone_furnace)]
    end
  end

  class Planner
    def self.for(_game, _player)
      new
    end

    def execute
      Plan.new
    end
  end
end
