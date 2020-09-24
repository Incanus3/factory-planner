module FactoryPlanner
  class Game
    class Player
      class Inventory
        Item = Struct.new(:quantity, :name)

        attr_reader :items

        def initialize(items = [])
          @items = items
        end

        def <<(item)
          # TODO: if it already includes items of this name, merge them
          # - ideally use a hash with item name as key and default proc returning zero quantity
          @items << item
        end

        def includes?(quantity, name)
          item = @items.find { |item| item.name == name }
          item && item.quantity >= quantity
        end
      end

      class Builder
        def self.build(name, &block)
          builder = new
          builder.instance_eval(&block)

          Player.new(name, builder.inventory)
        end

        attr_reader :inventory

        private def initialize
          @inventory = Inventory.new
        end

        def has(quantity, name)
          @inventory << Inventory::Item.new(quantity, name)
        end
      end

      attr_reader :name, :inventory

      def initialize(name, inventory)
        @name      = name
        @inventory = inventory
      end

      def has_item?(quantity, name)
        self.inventory.includes?(quantity, name)
      end
    end

    module Goals
      Have = Struct.new(:quantity, :item)

      class Builder
        def self.build(&block)
          builder = new
          builder.instance_eval(&block)

          builder.goals
        end

        attr_reader :goals

        private def initialize(goals = [])
          @goals = goals
        end

        def have(*args, **kwargs)
          @goals << Have.new(*args, **kwargs)
        end
      end
    end

    class << self
      attr_reader :players

      def inherited(subclass)
        super

        subclass.instance_eval do
          # NOTE: should subclasses inherit goals and/or players from superclass games?
          @goals   = []
          @players = []
        end
      end

      def takes_place_in(world)
      end

      def player(name, &block)
        @players << Player::Builder.build(name, &block)
      end

      def goals(&block)
        if block
          @goals = Goals::Builder.build(&block)
        else
          @goals
        end
      end
    end

    attr_reader :goals, :players

    def initialize
      @goals   = self.class.goals
      @players = self.class.players
    end

    def player_by_name(name)
      self.players.find { |player| player.name == name }
    end
  end
end
