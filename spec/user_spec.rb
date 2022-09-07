require 'user'
require 'user_repository'
require 'spec_helper'

def reset_users_table
    seed_sql = File.read('spec/seeds_user.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb' })
    connection.exec(seed_sql)
end

describe UserRepository do
    before(:each) do
        reset_users_table
    end

    it 'happy path' do
        repo = UserRepository.new
        new_user = User.new
        new_user.email = 'anything@here'
        new_user.password = 'abc123!'
        expect(repo.create(new_user)).to eq('created')
    end
    it 'password check fail' do
        repo = UserRepository.new
        new_user = User.new
        new_user.email = 'myemail@here'
        new_user.password = 'abc123'
        expect(repo.create(new_user)).to eq('Password not valid')
    end
    it 'email check fail validation' do
        repo = UserRepository.new
        new_user = User.new
        new_user.email = 'my.emailhere'
        new_user.password = 'abc123!'
        expect(repo.create(new_user)).to eq('email address not valid')
    end
    it 'email fail already used' do
        repo = UserRepository.new
        new_user = User.new
        new_user.email = 'michael@here'
        new_user.password = 'password1'
        expect(repo.create(new_user)).to eq('email already used')
    end
end