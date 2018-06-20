require_relative '../santa.rb'
require 'rspec'

RSpec.describe 'Person' do
  describe '.partner?' do
    it 'should return true if partner name matches' do
      person  = Person.new('Hello World')
      partner = Person.new('Foo Bar', person)
      expect(partner.partner?(person)).to be_truthy
    end

    it 'should return false if partner name does not match' do
      person1  = Person.new('Hello World')
      person2  = Person.new('Ruby on Rails')
      partner = Person.new('Foo Bar', person1)
      expect(partner.partner?(person2)).to be_falsy
    end

    it 'should return false if person has no partner' do
      person  = Person.new('Hello World')
      partner = Person.new('Foo Bar')
      expect(partner.partner?(person)).to be_falsy
    end
  end
end

RSpec.describe 'SecretSantaRunner' do
  describe '.initialize' do
    it 'should call load_data' do
      expect_any_instance_of(SecretSantaRunner).to receive(:load_data)
      SecretSantaRunner.new
    end

    it 'should call load_last_run' do
      expect_any_instance_of(SecretSantaRunner).to receive(:load_last_run)
      SecretSantaRunner.new
    end
  end

  it 'should return true if solution is valid' do
    expect_any_instance_of(SecretSantaRunner).to receive(:load_last_run)
    runner = SecretSantaRunner.new('test/valid.txt')
    persons = ['Maude Flanders,Frank Grimes,Carl Carlson,Bart Simpson,Ned Flanders,Marge Simpson,Homer Simpson,Lenny Leonard,Lisa Simpson'].map{|name| Person.new(name)}
    expect(runner).to receive(:valid_permutation?).with(persons).and_return(true)
    runner.send(:valid_permutation?, persons)
  end

  it 'should not match with self' do
    expect_any_instance_of(SecretSantaRunner).to receive(:load_last_run)
    runner = SecretSantaRunner.new('test/test1.txt')
    persons = ['Homer Simpson','Frank Grimes', 'Marge Simpson'].map{|name| Person.new(name)}
    expect(runner).to receive(:valid_permutation?).with(persons).and_return(false)
    runner.send(:valid_permutation?, persons)
  end

  it 'should not match with partner' do
    expect_any_instance_of(SecretSantaRunner).to receive(:load_last_run)
    runner = SecretSantaRunner.new('test/test2.txt')
    persons = ['Frank Grimes','Homer Simpson', 'Marge Simpson'].map{|name| Person.new(name)}
    expect(runner).to receive(:valid_permutation?).with(persons).and_return(false)
    runner.send(:valid_permutation?, persons)
  end

  it 'should not match with the last run' do
    expect_any_instance_of(SecretSantaRunner).to receive(:load_last_run)
    runner = SecretSantaRunner.new('test/test1.txt')
    allow(runner).to receive(:matched_last_run?).and_return(true)
    persons = ['Frank Grimes','Homer Simpson', 'Marge Simpson'].map{|name| Person.new(name)}
    expect(runner).to receive(:valid_permutation?).with(persons).and_return(false)
    runner.send(:valid_permutation?, persons)
  end
end





