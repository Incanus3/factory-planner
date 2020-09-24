require 'spec_helper'
require 'recipes'
require 'factory_planner'

class MyWorld < FactoryPlanner::World
  use TestRecipes
end

class MyGame < FactoryPlanner::Game
  takes_place_in MyWorld

  player :joe do
    has(5, :stone)
  end

  player :jack do
    has(1000, :copper_plate)
  end

  goals do
    have(100, :copper_plate)
  end

  # TODO: strategies
end

RSpec.describe 'basic usage' do
  let(:game)    { MyGame.new                              }
  let(:planner) { FactoryPlanner::Planner.for(game, :joe) }

  xit 'works' do
    plan = planner.execute

    expect(plan.steps.map(&:name)).to include :craft_stone_furnace
  end

  it 'detects success' do
    planner = FactoryPlanner::Planner.for(game, :jack)
    plan    = planner.execute

    expect(plan.steps).to be_empty
  end
end
