require 'factory_planner'

class TestRecipes < FactoryPlanner::RecipeSet
  recipe :manual_stone_mining do
    produces(5, :stone)

    takes(5, :second)
  end

  recipe :manual_coal_mining do
    produces(5, :coal)

    takes(5, :second)
  end

  recipe :manual_iron_mining do
    produces(5, :stone)

    takes(5, :second)
  end

  recipe :manual_copper_mining do
    produces(5, :stone)

    takes(5, :second)
  end

  recipe :automated_stone_mining do
    consumes(1, :coal)
    produces(5, :stone)

    takes(5, :second)
  end

  recipe :automated_coal_mining do
    consumes(1, :coal)
    produces(5, :coal)

    takes(5, :second)
  end

  recipe :automated_iron_mining do
    consumes(1, :coal)
    produces(5, :stone)

    takes(5, :second)
  end

  recipe :automated_copper_mining do
    consumes(1, :coal)
    produces(5, :stone)

    takes(5, :second)
  end

  recipe :iron_smelting do
    consumes(10, :iron)
    consumes(1,  :coal)

    produces(10, :iron_plate)

    takes(5, :second)
  end

  recipe :copper_smelting do
    consumes(10, :copper)
    consumes(1,  :coal)

    produces(10, :copper_plate)

    takes(5, :second)
  end

  recipe :craft_stone_furnace do
    consumes(5, :stone)

    produces(1, :stone_furnace)

    takes(3, :second)
  end

  player do
    can_do :stone_furnace
    can_do :manual_stone_mining
    can_do :manual_coal_mining
    can_do :manual_iron_mining
    can_do :manual_copper_mining

    effectivity 0.5
  end

  abstract_building :furnace do
    can_do :automated_stone_mining
    can_do :automated_coal_mining
    can_do :automated_iron_mining
    can_do :automated_copper_mining
    can_do :iron_smelting
    can_do :copper_smelting
  end

  building :stone_furnace do
    implements :furnace

    effectivity 1
  end
end
