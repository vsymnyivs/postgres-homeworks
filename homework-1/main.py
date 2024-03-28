"""Скрипт для заполнения данными таблиц в БД Postgres."""
import psycopg2
import csv


def get_info_from_csv(path):
    """
    Получение данных из csv файла
    """
    with open(path, "r") as file:
        data = csv.reader(file)
        count = 0
        result = []
        for line in data:
            if count == 0:
                count += 1
            else:
                result.append(line)
                count += 1
    return result


customers_data = get_info_from_csv("north_data/customers_data.csv")
employees_data = get_info_from_csv("north_data/employees_data.csv")
orders_data = get_info_from_csv("north_data/orders_data.csv")


with (psycopg2.connect(host="localhost", database="north", user="postgres", password="Genana432!") as conn):
    with conn.cursor() as cur:
        for customer in customers_data:
            cur.execute("INSERT INTO customers VALUES(%s, %s, %s)",
                        (customer[0], customer[1], customer[2]))
        for employee in employees_data:
            cur.execute("INSERT INTO employees VALUES(%s, %s, %s, %s, %s, %s)",
                        (employee[0], employee[1], employee[2], employee[3], employee[4], employee[5]))
        for order in orders_data:
            cur.execute("INSERT INTO orders VALUES(%s, %s, %s, %s, %s)",
                        (order[0], order[1], order[2], order[3], order[4]))
conn.close()
