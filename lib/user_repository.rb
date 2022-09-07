require_relative 'user'

class UserRepository
    def create(user)
        sql = 'INSERT INTO users (email, password) VALUES ($1, $2);'
        if user.password.length > 6 && user.email.include?('@') && self.find(user.email)
            new_users = DatabaseConnection.exec_params(sql, [user.email, user.password])
            p "anything"
            return 'created'
        elsif user.password.length < 7
            return 'Password not valid'
        elsif !user.email.include?('@')
            return 'email address not valid'
        elsif !self.find(user.email)
            return 'email already used'
        end
    end

    def find(user_email)
            sql = 'SELECT id, email, password FROM users WHERE email = $1;'
            new_users = DatabaseConnection.exec_params(sql, [user_email])
            p new_users
            if new_users.num_tuples.zero?
                return true
            else
                return false
            end
    end
end