from datetime import datetime
import mysql.connector
from mysql.connector import Error
import matplotlib.pyplot as plt

def db_connect(host, database, user, password, auth_plugin='mysql_native_password'):
    '''Connect to database and return connection object'''
    connection = None
    try:
        connection = mysql.connector.connect(host=host,
                                             database=database,
                                             user=user,
                                             password=password,
                                             auth_plugin=auth_plugin)
        if connection.is_connected():
            db_Info = connection.get_server_info()
            print("Connected to MySQL Server version ", db_Info)
            cursor = connection.cursor()
            cursor.execute("select database();")
            record = cursor.fetchone()
            print("Your connected to database: ", record)
    except Error as e:
        print("Error while connecting to MySQL", e)
    
    return connection

def db_query(connection, query):
    '''Execute query and return data'''
    datasets = None
    try:
        if connection.is_connected():
            cursor = connection.cursor()
            cursor.execute(query)
            records = cursor.fetchall()
            datasets = records
            print (len(records), "records fetched")
    except Error as e:
        print("Error while executing query", e)
    
    return datasets

def db_close(connection):
    '''Close connection to database'''
    if connection and connection.is_connected():
        connection.close()


def show_bar_chart(label, datasets, field1=0, field2=1):
    '''Show bar chart for the given datasets'''
    labels = [row[field1] for row in datasets]
    values = [row[field2] for row in datasets]

    # Create bar chart
    plt.bar(labels, values)
    plt.title(label)
    plt.show()

def show_line_chart(label, datasets, field1=0, field2=1):
    '''Show line chart for the given datasets'''
    times = [row[field1] for row in datasets]
    values = [row[field2] for row in datasets]

    # Create line chart
    plt.plot(times, values)
    plt.title(label)
    plt.xlabel('Time')
    plt.ylabel('Value')
    plt.show()

def show_scatter_plot(label, datasets, field1=0, field2=1):
    '''Show scatter plot chart for the given datasets'''
    x_values = [row[field1] for row in datasets]
    y_values = [row[field2] for row in datasets]

    # Create scatter plot
    plt.scatter(x_values, y_values)
    plt.title(label)
    plt.xlabel('X')
    plt.ylabel('Y')
    plt.show()

def main():
    host = 'localhost'
    database = 'auto_app'
    user = 'root'
    password = 'password'

    #Query to get sum of duration by date for challenge
    query_duration_trend = "select year(date) as year, sum(duration) from challenge group by date"

    #Query to get the total number of challenges along with the average number of likes for each challenge
    query_number_of_challenge = """
    SELECT c.challenge_id, COUNT(j.Challenge_id) AS total_challenges, AVG(cm.likes) AS avg_likes 
FROM challenge c 
LEFT JOIN joins j ON c.challenge_id = j.Challenge_id 
LEFT JOIN community cm ON j.PU_Community_id = cm.community_id 
GROUP BY c.challenge_id;
"""

    # Query 3
    query_tbd = "tbd"

    # connect to the database
    connection = db_connect(host, database, user, password)

    # execute query 1
    data_total = db_query(connection, query_duration_trend)
    show_scatter_plot('total number of of challenges', data_total)

    # execute query 2
    data_with_likes = db_query(connection, query_number_of_challenge)
    show_bar_chart('number of challenge with likes', data_with_likes, 1, 2)

    # execute query 3
    #data_3 = db_query(connection, query_tbd)
    #show_line_chart('tbd', data_3)

    # close connection
    db_close(connection)
    

if __name__ == "__main__":
    main()