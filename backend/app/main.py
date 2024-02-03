from ast import List
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import requests

app = FastAPI()


@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.get("/users/")
async def get_all_users():
    # Replace the URL with your actual Kintone API URL
    kintone_url = "https://lifelens.kintone.com/k/v1/records.json?app=3"
    # kintone_url = "https://lifelens.kintone.com/k/v1/record.json?app=3&id=2"

    headers = {"X-Cybozu-API-Token": "UAAcDTKtR1wmtqtNZELqbKZpsFDwcRynN5CkvPmc"}

    try:
        # Make the API call to Kintone
        response = requests.get(kintone_url, headers=headers)

        # Check if the request was successful
        if response.status_code == 200:
            # return response.json()
            original_data = response.json()
            transformed_data = {}

            # Traverse each record and extract user information
            for record in original_data["records"]:
                username = record["username"]["value"]
                user_info = {
                    "id": record["$id"]["value"],
                    "first_name": record["first_name"]["value"],
                    "last_name": record["last_name"]["value"],
                    "address": record["address"]["value"],
                    "birthday": record["birthday"]["value"],
                    "food_restrictions": [
                        restriction.capitalize()
                        for restriction in record["food_restrictions"]["value"]
                    ],
                    "interests": record["interests"]["value"],
                }

                # Add user information to the dictionary with username as key
                transformed_data[username] = user_info
            return transformed_data

        else:
            # Raise an HTTPException if the request was unsuccessful
            raise HTTPException(
                status_code=response.status_code,
                detail="Failed to fetch data from Kintone API",
            )
    except Exception as e:
        # Handle any exceptions that occur during the API call
        raise HTTPException(status_code=500, detail=str(e))


@app.get("/user/{username}")
async def get_user_by_id(username: str):
    # Replace the URL with your actual Kintone API URL
    kintone_url = "https://lifelens.kintone.com/k/v1/records.json?app=3"
    # kintone_url = "https://lifelens.kintone.com/k/v1/record.json?app=3&id=2"

    headers = {"X-Cybozu-API-Token": "UAAcDTKtR1wmtqtNZELqbKZpsFDwcRynN5CkvPmc"}

    try:
        # Make the API call to Kintone
        response = requests.get(kintone_url, headers=headers)

        # Check if the request was successful
        if response.status_code == 200:
            # return response.json()
            original_data = response.json()
            transformed_data = {}

            # Traverse each record and extract user information
            for record in original_data["records"]:
                _username = record["username"]["value"]
                if _username == username:
                    user_info = {
                        "id": record["$id"]["value"],
                        "first_name": record["first_name"]["value"],
                        "last_name": record["last_name"]["value"],
                        "address": record["address"]["value"],
                        "birthday": record["birthday"]["value"],
                        "food_restrictions": [
                            restriction.capitalize()
                            for restriction in record["food_restrictions"]["value"]
                        ],
                        "interests": record["interests"]["value"],
                    }

                    # Add user information to the dictionary with username as key
                    return user_info
            return {}

        else:
            # Raise an HTTPException if the request was unsuccessful
            raise HTTPException(
                status_code=response.status_code,
                detail="Failed to fetch data from Kintone API",
            )
    except Exception as e:
        # Handle any exceptions that occur during the API call
        raise HTTPException(status_code=500, detail=str(e))
