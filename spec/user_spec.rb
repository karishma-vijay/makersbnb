require 'user'
require 'user_repository'
require 'spec_helper'

def reset_users_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
    connection.exec(seed_sql)
end

describe UserRepository do
    before(:each) do
        reset_users_table
    end

    it 'Create a new user' do
        repo = UserRepository.new
        new_user = User.new
        new_user.email = 'newbie@here'
        new_user.password = 'abc123!'
        expect(repo.create(new_user)).to eq('created')
    end
    it 'password fails validation' do
        repo = UserRepository.new
        new_user = User.new
        new_user.email = 'myemail@here'
        new_user.password = 'abc123'
        expect(repo.create(new_user)).to eq('Password not valid')
    end
    it 'email fails validation' do
        repo = UserRepository.new
        new_user = User.new
        new_user.email = 'my.emailhere'
        new_user.password = 'abc123!'
        expect(repo.create(new_user)).to eq('email address not valid')
    end
    it 'email already used' do
        repo = UserRepository.new
        new_user = User.new
        new_user.email = 'michael@here'
        new_user.password = 'password1'
        expect(repo.create(new_user)).to eq('email already used')
    end
    it 'checks login' do
        repo = UserRepository.new
        new_user = User.new
        new_user.email = 'michael@here'
        new_user.password = 'password1'
        expect(repo.login(new_user)).to eq('Logged in successfully')
    end

    it 'checks login no email' do
        repo = UserRepository.new
        new_user = User.new
        new_user.email = 'here@here'
        new_user.password = 'password1'
        expect(repo.login(new_user)).to eq('Email or password incorrect')
    end

    it 'checks login wrong password' do
        repo = UserRepository.new
        new_user = User.new
        new_user.email = 'james@here'
        new_user.password = 'pass'
        expect(repo.login(new_user)).to eq('Email or password incorrect')
    end
end