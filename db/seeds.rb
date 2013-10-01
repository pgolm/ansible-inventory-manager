Identity.create(email: 'admin@example.com', 
                password: 'admin', 
                password_confirmation: 'admin')

User.create(provider:"identity", 
            uid: 1, 
            email: 'admin@example.com', 
            is_admin: true)