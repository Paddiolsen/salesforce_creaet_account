import csv
import json


def create_json(csv_path, json_path):

    data = {}

    with open(csv_path, encoding='utf8' ) as csvf:
        csvReader = csv.DictReader(csvf)

        for row in csvReader:
            for item in row:
                data[key]=

            print(row)

    #print(data)

    #with open(json_path, 'w', encoding='utf-8') as jsonf:
    #        jsonf.write(json.dumps(data, indent=4))


create_json('/home/patrick/Robots/Examples/Salesforce_create_account/Salesforce_create_account/ressources/data.csv', '/home/patrick/Robots/Examples/Salesforce_create_account/Salesforce_create_account/ressources/data.json')