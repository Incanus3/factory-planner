require 'spec_helper'
require 'recipes'
require 'factory_planner'

FP = FactoryPlanner

class IronMiningGame < FactoryPlanner::Game
  goals do
    have(100, :iron_ore)
  end
end

class CopperSmeltingGame < FactoryPlanner::Game
  goals do
    have(100, :copper_plate)
  end

  player :joe do
    has(5, :stone)
  end

  player :jack do
    has(1000, :copper_plate)
  end
end

RSpec.describe FactoryPlanner::Game do
  let(:iron_mining_game)     { IronMiningGame.new     }
  let(:copper_smelting_game) { CopperSmeltingGame.new }

  it 'has goals' do
    expect(iron_mining_game.goals    ).to eq [FP::Game::Goals::Have.new(100, :iron_ore    )]
    expect(copper_smelting_game.goals).to eq [FP::Game::Goals::Have.new(100, :copper_plate)]
  end

  it 'has players' do
    expect(copper_smelting_game.players.map(&:name)).to eq [:joe, :jack]

    joe  = copper_smelting_game.player_by_name(:joe)
    jack = copper_smelting_game.player_by_name(:jack)

    expect(joe.name).to eq :joe
    expect(joe ).to     have_item(5, :stone)
    expect(jack).not_to have_item(5, :stone)
  end

  # TODO: test edge cases, e.g.:
  # - no goals specified
  # - no player specified
end
