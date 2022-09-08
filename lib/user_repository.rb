require_relative 'user'

class UserRepository
    def create(user)
        sql = 'INSERT INTO users (email, password) VALUES ($1, $2);'
        if user.password.length > 6 && user.email.include?('@') && self.find_email(user.email)
            new_users = DatabaseConnection.exec_params(sql, [user.email, user.password])
            return 'created'
        elsif user.password.length < 7
            return 'Password not valid'
        elsif !user.email.include?('@')
            return 'email address not valid'
        elsif !self.find_email(user.email)
            return 'email already used'
        end
    end
 
    def login(input_user)
        email = input_user.email
        db_user = get_user(email)

        if !db_user || db_user.password != input_user.password
            return 'Email or password incorrect'
        else
            return 'Logged in successfully'
        end
        
    end

    def find_email(user_email)
            sql = 'SELECT id, email, password FROM users WHERE email = $1;'
            new_users = DatabaseConnection.exec_params(sql, [user_email])
            if new_users.num_tuples.zero?
                return true
            else
                return false
            end
    end

    def get_user(email)
        sql = 'SELECT * FROM users WHERE email = $1;'
        db_user = DatabaseConnection.exec_params(sql, [email])

        if db_user.num_tuples.zero?
            return false
        else
            user = User.new
            user.id = db_user[0]['id'].to_i
            user.email = db_user[0]['email']
            user.password = db_user[0]['password']
            return user
        end
    end

    def test
        p 'test this class works'
    end
end