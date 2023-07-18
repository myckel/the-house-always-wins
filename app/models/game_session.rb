class GameSession < ApplicationRecord
  # Relationships
  belongs_to :user

  # Constants
  SYMBOLS = %w[C L O W]
  PRIZES = { 'C' => 10, 'L' => 20, 'O' => 30, 'W' => 40 }
  PER_PULL = -1

  # Instance Methods

  # Roll the slot machine
  def roll
    return unless enough_credits_to_roll

    result = perform_roll
    if winner?(result)
      update_credits_and_rolls(result, PRIZES[result[0]])
    end

    update_credits_and_rolls(nil, PER_PULL)
    result
  end

  # Check if the roll is a winner
  def winner?(result)
    result.uniq.count == 1
  end

  # Determine if a reroll should occur
  def should_reroll?
    reroll_chance = credits < 40 ? 0 : credits < 60 ? 0.3 : 0.6
    rand < reroll_chance
  end

  # Get a sample of symbols
  def get_sample
    SYMBOLS.sample(3)
  end

  private

  # Generate a random result
  def generate_result
    3.times.map { SYMBOLS.sample }
  end

  # Check if there are enough credits to roll
  def enough_credits_to_roll
    return true if credits.positive?

    errors.add(:credits, "must have at least 1 credit to roll")
    false
  end

  # Perform a roll and handle rerolls if necessary
  def perform_roll
    result = generate_result
    return generate_result if winner?(result) && should_reroll?

    result
  end

  # Update credits and rolls based on the roll result
  def update_credits_and_rolls(result, credit_change)
    new_credits = credits + credit_change
    new_rolls = result.nil? ? rolls : rolls << result.join

    update(credits: new_credits, rolls: new_rolls)
  end
end
