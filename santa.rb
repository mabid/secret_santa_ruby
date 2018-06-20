require 'equalizer'

class Person

  include Equalizer.new(:name)

  attr_accessor :name, :partner
  
  def initialize(name, partner=nil)
    @name    = name
    @partner = partner
  end

  def partner?(person)
    person.name == partner&.name
  end

  def to_s
    @name
  end
end

class SecretSantaRunner

  LAST_RUN_FILENAME = 'last_run.txt'

  def initialize(filename = 'input.txt')

    @filename     = filename
    @participants = []
    @partners     = {}
    @solution     = []
    @last_run     = {}
    load_data
    load_last_run
  end

  def assign_santas
    @solution = @participants.dup
    @solution.shuffle! while !valid_permutation?(@solution)
    save_current_run
  end

  def print_solution
    @solution.each_with_index do |s, i|
      puts "#{s}, #{@participants[i]}"
    end
  end

  private

  def save_current_run
    File.open(File.join(__dir__, LAST_RUN_FILENAME), 'w') do |f|
      @solution.each_with_index do |s, i|
        f.write("#{s}, #{@participants[i]}\n")
      end
    end
  end

  def load_last_run
    lines = IO.readlines(File.join(__dir__, LAST_RUN_FILENAME))
    lines.each do |l|
      inputs = l.split(',').map(&:strip)
      @last_run[inputs.first] = inputs.last
    end
  end

  def valid_permutation?(senders)
    senders.each_with_index.all?{|s, i| can_be_santa_of?(s, @participants[i])}
  end

  def can_be_santa_of?(a, b)
    !self?(a, b) && !a.partner?(b) && !matched_last_run?(a, b)
  end

  def self?(a, b)
    a == b
  end

  def matched_last_run?(a, b)
    @last_run[a.name] == b.name
  end

  def load_data
    lines = IO.readlines(File.join(__dir__, @filename))
    lines.each do |l|
      inputs = l.split(',').map(&:strip)
      person = Person.new(inputs.first)
      @participants << person
      if(inputs.size > 1)
        partner = Person.new(inputs.last)
        person.partner  = partner
        partner.partner = person
        @participants << partner
      end
    end
  end
end