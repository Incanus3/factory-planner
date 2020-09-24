module FactoryPlanner
  class Action
    attr_reader :name

    def initialize(name)
      @name = name
    end
  end

  class Plan
    attr_reader :steps

    def initialize(actions = [])
      @steps = actions
    end

    def <<(action)
      @steps << action
    end
  end

  class Planner
    def self.for(game, player_name)
      player = game.player_by_name(player_name)

      goals     = game.goals.clone
      inventory = player.inventory.clone

      new(goals: goals, inventory: inventory)
    end

    private def initialize(goals:, inventory:)
      @goals     = goals
      @inventory = inventory
    end

    def execute
      # TODO: implement this
      # - start with game goals
      # - loop while goals not empty:
      #   - take a goal
      #   - if satisfied, remove it from goals
      #   - if not, find a recipe, that leads to goal satisfaction
      #   - if there are more, select by some strategy
      #   - remove goal from goals
      #   - add recipe inputs as goals

      plan      = Plan.new
      goals     = @goals.clone
      inventory = @inventory.clone

      plan
    end
  end
end
