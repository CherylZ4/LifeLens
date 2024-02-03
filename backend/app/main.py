from ast import List
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import requests

app = FastAPI()


class NewUser(BaseModel):
    # Define the fields of the new record
    first_name: str
    last_name: str
    email: str
    birthday: str
    address: str
    food_restrictions: list[str]
    interests: str
    username: str


@app.get("/")
async def root():
    return {"message": "Hello World"}


# Users
@app.post("/user/add/")  # this is failed
async def add_user(record: NewUser):
    # Define the URL to add a new record in the Kintone database
    url = "https://lifelens.kintone.com/k/v1/record.json"

    # Prepare the data for the new record
    data = {
        "app": 3,
        "record": [
            {
                "first_name": {"value": record.first_name},
                "last_name": {"value": record.last_name},
                "email": {"value": record.email},
                "birthday": {"value": record.birthday},
                "address": {"value": record.address},
                "food_restrictions": {"value": record.food_restrictions},
                "interests": {"value": record.interests},
                "username": {"value": record.username},
            }
        ],
    }

    headers = {
        "Content-Type": "application/json",
        "X-Cybozu-API-Token": "your_api_token_here",
    }

    try:
        # Make the API call to Kintone to add the new record
        response = requests.post(url, json=data, headers=headers)

        # Check if the request was successful
        if response.status_code == 200:
            return {"message": "Record added successfully"}
        else:
            return {"error": "Failed to add record"}
    except Exception as e:
        return {"error": str(e)}


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
async def get_user_by_username(username: str):
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


# Groups
@app.get("/group/{groupname}")
async def get_group_by_name(groupname: str):
    # Replace the URL with your actual Kintone API URL
    kintone_url = "https://lifelens.kintone.com/k/v1/records.json?app=4"

    headers = {"X-Cybozu-API-Token": "zkZ46bntwVUu4IBfmbxwx8AXNinPoEXyQdaYHwI3"}

    try:
        # Make the API call to Kintone
        response = requests.get(kintone_url, headers=headers)

        # Check if the request was successful
        if response.status_code == 200:
            # return response.json()
            original_data = response.json()

            # Traverse each record and extract user information
            for record in original_data["records"]:
                _groupname = record["groupname"]["value"]
                if _groupname == groupname:
                    group_info = {
                        "group_description": record["group_description"]["value"],
                        "members": record["members"]["value"].split(),
                    }

                    # Add user information to the dictionary with username as key
                    return group_info
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
