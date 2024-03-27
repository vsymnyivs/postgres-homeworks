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


with psycopg2.connect(host="localhost", database="north", user="postgres", password="Genana432!") as conn:
    with conn.cursor() as cur:
        for customer in customers_data:
            cur.execute("INSERT INTO customers VALUES(%s, %s, %s)", )

