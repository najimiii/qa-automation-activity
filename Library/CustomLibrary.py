import requests
import random
import string

class CustomLibrary:
    def get_random_users(self):
        response = requests.get('https://jsonplaceholder.typicode.com/users', verify=False)
        users = response.json()[:5]

        for user in users:
            user['birthday'] = self.get_random_birthday()
            user['password'] = self.generate_password()
            user['state'] = str(user['address']['street'])+str(user['address']['suite'])+str(user['address']['city'])

        return users

    def get_last_5_users(self):
        response = requests.get('https://jsonplaceholder.typicode.com/users', verify=False)
        users = response.json()[5:]

        for user in users:
            user['birthday'] = self.get_random_birthday()
            user['password'] = self.generate_password()
            user['state'] = str(user['address']['street'])+str(user['address']['suite'])+str(user['address']['city'])

        return users

    def get_random_birthday(self):
        return str(random.randint(1, 12)).zfill(2) + str(random.randint(1, 28)).zfill(2) + str(random.randint(1980, 2006))

    def generate_password(self, length=8):
        chars = string.ascii_letters + string.digits + "!@#$%"
        return ''.join(random.choice(chars) for _ in range(length))

    def remove_birthday_dash(self, birthday):
        parts = birthday.split('-')  
        year = parts[0]
        month = parts[1]
        day = parts[2]
        return month + day + year
        
    def reverse_list(self, items):
        return list(reversed(items))
