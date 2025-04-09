import psycopg2

conn = psycopg2.connect("dbname=bank")
cur = conn.cursor()


def login(username, password):
    cur.execute(
        f"SELECT * FROM users WHERE username = '{username}' AND password = '{password}'"
    )
    result = cur.fetchone()
    if result:
        user_id, username, password, balance = result
        print(f"You are logged in as {username}, hopefully you're not a hacker!")
        print(f"Your bank balance is: ${balance}")
    else:
        print("hahaha incorrect credentials moron")


def main():
    username = input("Username: ")
    password = input("Password: ")
    login(username, password)


if __name__ == "__main__":
    main()
