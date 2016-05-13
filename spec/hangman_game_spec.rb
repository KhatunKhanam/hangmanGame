require './src/hangman_game.rb'
require 'rubygems'
gem 'shoulda-matchers'

describe HangmanGame do
  def new_game
    hangman = HangmanGame.new
    allow(hangman).to receive(:to_s)
    allow(hangman).to receive(:play_loop)
    allow(hangman).to receive(:print_instructions)
    return hangman
  end

  describe '#end_game' do
  	it 'sets the game over flag' do
  		hangman = new_game
  		hangman.end_game
  		expect(hangman.game_over).to eq(true)
  	end
  end

  describe '#lost' do
  	it 'calls end_game()' do
  		hangman = new_game
        hangman.play
        expect(hangman).to receive(:end_game)
  		hangman.lost
  	end
  end

  describe '#play' do
    it 'sets game letters array' do
      hangman = new_game
      hangman.play
      expect(hangman.instance_variable_get(:@secret_word_letters)).to eq(hangman.instance_variable_get(:@secret_word).chars.to_a)
    end

    it 'calls the play loop' do
      hangman = new_game
      expect(hangman).to receive(:play_loop)
      hangman.play
    end
  end

  describe '#have_lives?' do
    it 'returns true if the player has lives remaining' do
      hangman = new_game
      hangman.instance_variable_set(:@turns, 7)
      expect(hangman.have_lives?).to eq(true)
    end

    it 'returns false if the player has no lives remaining' do
      hangman = new_game
      hangman.instance_variable_set(:@chances, 0)
      expect(hangman.have_lives?).to eq(false)
    end
  end

  describe '#won?' do
    it 'returns true if victory conditions are met' do
      hangman = new_game
      hangman.play
      hangman.instance_variable_set(:@guessed_letters, hangman.instance_variable_get(:@secret_word_letters))
      expect(hangman.won?).to eq(true)
    end

    it 'continues if victory conditions are not met' do
      hangman = new_game
      hangman.play
      hangman.instance_variable_set(:@guessed_letters, 'doesnotexist'.chars.to_a)
      expect(hangman).not_to receive(:end_game)
      expect(hangman.won?).to eq(false)
    end
  end
end
