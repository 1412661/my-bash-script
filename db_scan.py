#!/usr/bin/python3

import mysql.connector

mydb = mysql.connector.connect(
    host="10.40.xxxxxxxx",
    user="baoxxxxxxxxxxx",
    password="a90xxxxxxxxxxxx"
)

mycursor = mydb.cursor()

# Get list databases
mycursor.execute("SHOW DATABASES")

list_db = mycursor.fetchall()

# Count total databases, tables and rows
total_db = len(list_db)
total_table = 0
total_row = 0

for db in list_db:
    db_name = db[0]

    '''
    # Skip MySQL internal databases
    # https://github.com/ioggstream/python-course/blob/master/mysql-101/lesson-1-3-information_schema.md
    if db_name in [
        "information_schema",
        "mysql",
        "performance_schema",
        "sys"
    ]:
        continue

    # Skip known databases
    if db_name in [
        "123xxxxxxxxxxxxxxxx"
    ]:
        continue
    '''

    # print(db_name)

    # Get list of tables
    mycursor.execute("USE `%s`" % db_name)
    mycursor.execute("SHOW TABLES")
    list_table = mycursor.fetchall()

    # Show total tables in database
    # print(db_name + " -> " + str(len(list_table)) + " table(s)")
    total_table += len(list_table)

    for table in list_table:

        table_name = table[0]
        # print("%s -> %s" % (db_name, table_name))
        # continue

        # Get table schema
        mycursor.execute("SHOW COLUMNS FROM `%s`.`%s`" % (db_name, table_name))
        table_schema = mycursor.fetchall()
        list_column = list(map(lambda x: x[0], table_schema))
        list_column_str = " | ".join(list_column)

        try:
            # Count total rows in table
            mycursor.execute("SELECT COUNT(*) FROM `%s`" % table_name)
        except mysql.connector.errors.DatabaseError as e:
            print(db_name + "." + table_name + " -> error: " + e.msg)
            continue

        # Show table schema with total rows in table
        count_row = mycursor.fetchall()[0][0]
        # print("%s -> %s (%s) -> %s row(s)" % (db_name, table_name, list_column_str, str(count_row)))
        print("%s,%s,%s,%s" % (db_name, table_name, list_column_str, str(count_row)))
        total_row += count_row

print("\n")
print("Total database," + str(total_db))
print("Total table," + str(total_table))
print("Total row," + str(total_row))
