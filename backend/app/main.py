from ast import List
from datetime import datetime
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import requests
from openai import OpenAI
import apikeys

client = OpenAI(api_key=apikeys.OPENAI_API)
app = FastAPI()


class NewUser(BaseModel):
    first_name: str
    last_name: str
    email: str
    birthday: str
    address: str
    food_restrictions: list[str]
    interests: str
    username: str


class NewGroup(BaseModel):
    groupname: str
    description: str
    members: str


class AddMember(BaseModel):
    new_username: str
    groupname: str


@app.get("/")
async def root():
    return {"message": "Hello World"}


# Users
@app.post("/user/add/")
async def add_user(record: NewUser):
    # Define the URL to add a new record in the Kintone database
    url = "https://lifelens.kintone.com/k/v1/record.json"

    # Prepare the data for the new record
    data = {
        "app": 3,
        "record": {
            "first_name": {"value": record.first_name},
            "last_name": {"value": record.last_name},
            "email": {"value": record.email},
            "birthday": {"value": record.birthday},
            "address": {"value": record.address},
            "food_restrictions": {"value": record.food_restrictions},
            "interests": {"value": record.interests},
            "username": {"value": record.username},
        },
    }

    headers = {
        "Content-Type": "application/json",
        "X-Cybozu-API-Token": apikeys.KINTONE_USER,
    }

    try:
        # Make the API call to Kintone to add the new record
        response = requests.post(url, json=data, headers=headers)

        # Check if the request was successful
        if response.status_code == 200:
            return {"message": "Record added successfully"}
        else:
            return {"error": response.status_code}
    except Exception as e:
        return {"error": str(e)}


@app.get("/users/")
async def get_all_users():
    # Replace the URL with your actual Kintone API URL
    kintone_url = "https://lifelens.kintone.com/k/v1/records.json?app=3"
    # kintone_url = "https://lifelens.kintone.com/k/v1/record.json?app=3&id=2"

    headers = {"X-Cybozu-API-Token": apikeys.KINTONE_USER}

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

    headers = {"X-Cybozu-API-Token": apikeys.KINTONE_USER}

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

    headers = {"X-Cybozu-API-Token": apikeys.KINTONE_GROUP}

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


@app.post("/group/new/")
def add_user(record: NewGroup):
    # Define the URL to add a new record in the Kintone database
    url = "https://lifelens.kintone.com/k/v1/record.json"

    # Prepare the data for the new record
    data = {
        "app": 4,
        "record": {
            "groupname": {"value": record.groupname},
            "description": {"value": record.description},
            "members": {"value": record.members},
        },
    }

    headers = {
        "Content-Type": "application/json",
        "X-Cybozu-API-Token": apikeys.KINTONE_GROUP,
    }

    try:
        # Make the API call to Kintone to add the new record
        response = requests.post(
            url,
            json=data,
            headers=headers,
        )

        # Check if the request was successful
        if response.status_code == 200:
            return {"message": "Record added successfully"}
        else:
            return {"error": response.status_code}
    except Exception as e:
        return {"error": str(e)}


@app.put("/group/add/")
def add_user(record: AddMember):
    # Replace the URL with your actual Kintone API URL
    kintone_url = "https://lifelens.kintone.com/k/v1/records.json?app=4"

    headers = {"X-Cybozu-API-Token": apikeys.KINTONE_GROUP}

    id = -1
    members = ""

    try:
        # Make the API call to Kintone
        response = requests.get(kintone_url, headers=headers)

        # Check if the request was successful
        if response.status_code == 200:
            # return response.json()
            original_data = response.json()

            # Traverse each record and extract user information
            for _record in original_data["records"]:
                _groupname = _record["groupname"]["value"]
                if _groupname == record.groupname:
                    id = _record["$id"]["value"]
                    members = _record["members"]["value"]
            if id == -1:
                raise HTTPException(status_code=201, detail="group now found")
            # check duplicates
            member_list = members.split()
            flag = False
            for member in member_list:
                if member == record.new_username:
                    flag = True
            if not (flag):
                members += " " + record.new_username
            data = {
                "app": 4,
                "id": id,
                "record": {"members": {"value": members}},
            }
            kintone_url_2 = "https://lifelens.kintone.com/k/v1/record.json"
            response = requests.put(kintone_url_2, json=data, headers=headers)
            if response.status_code == 200:
                return {"members": members.split()}
            else:
                raise HTTPException(
                    status_code=response.status_code,
                    detail="Failed to modify data from Kintone API",
                )

        else:
            # Raise an HTTPException if the request was unsuccessful
            raise HTTPException(
                status_code=response.status_code,
                detail="Failed to fetch data from Kintone API",
            )
    except Exception as e:
        # Handle any exceptions that occur during the API call
        raise HTTPException(status_code=500, detail=str(e))


# birthday
@app.get("/group/birthday/{group_name}")
def get_birthday_reminders(group_name: str):
    kintone_url = "https://lifelens.kintone.com/k/v1/records.json?app=4"
    headers = {"X-Cybozu-API-Token": apikeys.KINTONE_GROUP}

    # return datetime.now()

    try:
        response = requests.get(kintone_url, headers=headers)
        if response.status_code == 200:
            original_data = response.json()
            group_info = {}
            for record in original_data["records"]:
                _groupname = record["groupname"]["value"]
                if _groupname == group_name:
                    group_info = {
                        "members": record["members"]["value"].split(),
                    }
            if group_info == {}:
                raise HTTPException(status_code=204, detail="Group not found")

            kintone_url = "https://lifelens.kintone.com/k/v1/records.json?app=3"
            headers = {"X-Cybozu-API-Token": apikeys.KINTONE_USER}

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
                        if record["username"]["value"] in group_info["members"]:
                            # Calculate days until next birthday
                            birthday_str = record["birthday"]["value"]
                            birthday_date = datetime.strptime(birthday_str, "%Y-%m-%d")
                            today = datetime.now()
                            next_birthday = datetime(
                                today.year, birthday_date.month, birthday_date.day
                            )
                            if next_birthday < today:
                                next_birthday = datetime(
                                    today.year + 1,
                                    birthday_date.month,
                                    birthday_date.day,
                                )
                            days_until_birthday = (next_birthday - today).days

                            # Add user information to the dictionary with username as key
                            transformed_data[record["username"]["value"]] = {
                                "birthday": birthday_str,
                                "days_until_birthday": days_until_birthday,
                            }
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

            completion = client.chat.completions.create(
                model="gpt-3.5-turbo",
                messages=[
                    {
                        "role": "user",
                        "content": group_info["members"]
                        + ", try to count how many names are there",
                    },
                ],
            )
            return completion.choices[0].message

        else:
            # Raise an HTTPException if the request was unsuccessful
            raise HTTPException(
                status_code=response.status_code,
                detail="Failed to fetch data from Kintone API",
            )
    except Exception as e:
        # Handle any exceptions that occur during the API call
        raise HTTPException(status_code=500, detail=str(e))
