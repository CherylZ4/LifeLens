from ast import List
from datetime import datetime
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import requests
import json
from openai import OpenAI
from apikeys import OPENAI_API_KEY, KINTONE_GROUP, KINTONE_USER

client = OpenAI(api_key=OPENAI_API_KEY)
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
    phone_number: str
    questions: list[list[str]]
    pronoun: str


class ModifyUser(BaseModel):
    username: str
    address: str
    food_restrictions: list[str]
    interests: str
    questions: list[list[str]]
    pronoun: str


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
@app.get("/user/exist/{username}")
async def does_user_exist(username: str):
    kintone_url = "https://lifelens.kintone.com/k/v1/records.json?app=3"
    headers = {"X-Cybozu-API-Token": KINTONE_USER}
    try:
        response = requests.get(kintone_url, headers=headers)
        if response.status_code == 200:
            original_data = response.json()
            for record in original_data["records"]:
                if record["username"]["value"] == username:
                    return True
            return False
        else:
            raise HTTPException(
                status_code=response.status_code,
                detail="Failed to fetch data from Kintone API",
            )
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@app.put("/user/modify")
async def change_user_data(new_data: ModifyUser):
    kintone_url = "https://lifelens.kintone.com/k/v1/records.json?app=3"
    headers = {"X-Cybozu-API-Token": KINTONE_USER}

    id = -1

    try:
        response = requests.get(kintone_url, headers=headers)
        if response.status_code == 200:
            original_data = response.json()
            for _record in original_data["records"]:
                _username = _record["username"]["value"]
                if _username == new_data.username:
                    id = _record["$id"]["value"]
            if id == -1:
                raise HTTPException(status_code=201, detail="group now found")

            questions_str = ""
            for arr in new_data.questions:
                questions_str += arr[0] + "|" + arr[1] + "|"
            questions_str = questions_str[:-1]

            data = {
                "app": 3,
                "id": id,
                "record": {
                    "address": {"value": new_data.address},
                    "food_restrictions": {
                        "value": new_data.food_restrictions,
                    },
                    "interests": {"value": new_data.interests},
                    "questions": {"value": questions_str},
                    "pronoun": {"value": new_data.pronoun},
                },
            }
            kintone_url_2 = "https://lifelens.kintone.com/k/v1/record.json"
            response = requests.put(kintone_url_2, json=data, headers=headers)
            if response.status_code == 200:
                return {"message": "user information successfully updated"}
            else:
                raise HTTPException(
                    status_code=response.status_code,
                    detail="Failed to modify data from Kintone API",
                )
        else:
            raise HTTPException(
                status_code=response.status_code,
                detail="Failed to fetch data from Kintone API",
            )
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@app.post("/user/add/")
async def add_user(record: NewUser):
    url = "https://lifelens.kintone.com/k/v1/record.json"
    questions_str = ""
    for arr in record.questions:
        questions_str += arr[0] + "|" + arr[1] + "|"
    questions_str = questions_str[:-1]
    print(questions_str)

    data = {
        "app": 3,
        "record": {
            "first_name": {"value": record.first_name},
            "last_name": {"value": record.last_name},
            "pronoun": {"value": record.pronoun},
            "email": {"value": record.email},
            "birthday": {"value": record.birthday},
            "address": {"value": record.address},
            "food_restrictions": {"value": record.food_restrictions},
            "interests": {"value": record.interests},
            "phone_number": {"value": record.phone_number},
            "username": {"value": record.username},
            "questions": {"value": questions_str},
        },
    }

    headers = {
        "Content-Type": "application/json",
        "X-Cybozu-API-Token": KINTONE_USER,
    }
    try:
        response = requests.post(url, json=data, headers=headers)
        if response.status_code == 200:
            return {"message": "Record added successfully"}
        else:
            return {"status_code": response.status_code}
            # raise HTTPException(status_code=207, detail="fields alrefhsfshady exists")
    except Exception as e:
        print(e)
        return {"error": e}


# @app.get("/users/")
# async def get_all_users():
#     kintone_url = "https://lifelens.kintone.com/k/v1/records.json?app=3"
#     headers = {"X-Cybozu-API-Token": KINTONE_USER}
#     try:
#         response = requests.get(kintone_url, headers=headers)
#         if response.status_code == 200:
#             original_data = response.json()
#             transformed_data = {}
#             for record in original_data["records"]:
#                 username = record["username"]["value"]
#                 user_info = {
#                     "id": record["$id"]["value"],
#                     "first_name": record["first_name"]["value"],
#                     "last_name": record["last_name"]["value"],
#                     "address": record["address"]["value"],
#                     "birthday": record["birthday"]["value"],
#                     "food_restrictions": [
#                         restriction.capitalize()
#                         for restriction in record["food_restrictions"]["value"]
#                     ],
#                     "interests": record["interests"]["value"],
#                     "phone_number": record["phone_number"]["value"],
#                 }
#                 transformed_data[username] = user_info
#             return transformed_data
#         else:
#             raise HTTPException(
#                 status_code=response.status_code,
#                 detail="Failed to fetch data from Kintone API",
#             )
#     except Exception as e:
#         raise HTTPException(status_code=500, detail=str(e))


@app.get("/get/{username}")
async def get_user_by_username(username: str):
    kintone_url = "https://lifelens.kintone.com/k/v1/records.json?app=3"
    headers = {"X-Cybozu-API-Token": KINTONE_USER}
    try:
        response = requests.get(kintone_url, headers=headers)
        if response.status_code == 200:
            original_data = response.json()
            for record in original_data["records"]:
                _username = record["username"]["value"]
                if _username == username:
                    _questions = record["questions"]["value"].split("|")
                    qs_size = len(_questions)
                    if qs_size % 2 == 1:
                        raise HTTPException(
                            status_code=201, detail="invalid input type"
                        )
                    questions_double_ar = []
                    for index in range(0, qs_size, 2):
                        questions_double_ar.append(
                            [_questions[index], _questions[index + 1]]
                        )

                    user_info = {
                        "id": record["$id"]["value"],
                        "first_name": record["first_name"]["value"],
                        "last_name": record["last_name"]["value"],
                        "pronoun": record["pronoun"]["value"],
                        "address": record["address"]["value"],
                        "birthday": record["birthday"]["value"],
                        "food_restrictions": [
                            restriction.capitalize()
                            for restriction in record["food_restrictions"]["value"]
                        ],
                        "interests": record["interests"]["value"],
                        "phone_number": record["phone_number"]["value"],
                        "questions": questions_double_ar,
                    }
                    return user_info
            return {}
        else:
            raise HTTPException(
                status_code=response.status_code,
                detail="Failed to fetch data from Kintone API",
            )
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


# Groups
@app.get("/group/{groupname}")
async def get_group_by_name(groupname: str):
    kintone_url = "https://lifelens.kintone.com/k/v1/records.json?app=4"
    headers = {"X-Cybozu-API-Token": KINTONE_GROUP}
    try:
        response = requests.get(kintone_url, headers=headers)
        if response.status_code == 200:
            original_data = response.json()
            for record in original_data["records"]:
                _groupname = record["groupname"]["value"]
                if _groupname == groupname:
                    group_info = {
                        "group_description": record["group_description"]["value"],
                        "members": record["members"]["value"].split(),
                    }
                    return group_info
            return {}
        else:
            raise HTTPException(
                status_code=response.status_code,
                detail="Failed to fetch data from Kintone API",
            )
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@app.post("/group/new/")
def add_user(record: NewGroup):
    url = "https://lifelens.kintone.com/k/v1/record.json"
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
        "X-Cybozu-API-Token": KINTONE_GROUP,
    }
    try:
        response = requests.post(
            url,
            json=data,
            headers=headers,
        )
        if response.status_code == 200:
            return {"message": "Record added successfully"}
        else:
            return {"error": response.status_code}
    except Exception as e:
        return {"error": str(e)}


@app.put("/group/add/")
def add_user(record: AddMember):
    kintone_url = "https://lifelens.kintone.com/k/v1/records.json?app=4"
    headers = {"X-Cybozu-API-Token": KINTONE_GROUP}

    id = -1
    members = ""

    try:
        response = requests.get(kintone_url, headers=headers)
        if response.status_code == 200:
            original_data = response.json()
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
            raise HTTPException(
                status_code=response.status_code,
                detail="Failed to fetch data from Kintone API",
            )
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@app.get("/grouplist/{username}")
def get_group_list_for_user(username: str):
    kintone_url = "https://lifelens.kintone.com/k/v1/records.json?app=4"
    headers = {"X-Cybozu-API-Token": KINTONE_GROUP}

    try:
        response = requests.get(kintone_url, headers=headers)
        if response.status_code == 200:
            original_data = response.json()
            transformed_data = {"groups": []}
            for record in original_data["records"]:
                members = record["members"]["value"].split()
                if username in members:
                    transformed_data["groups"].append(record["groupname"]["value"])
            return transformed_data
        else:
            raise HTTPException(
                status_code=response.status_code,
                detail="Failed to fetch data from Kintone API",
            )
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


# birthday
@app.get("/group/birthdays/{group_name}")
def get_birthday_reminders(group_name: str):
    kintone_url = "https://lifelens.kintone.com/k/v1/records.json?app=4"
    headers = {"X-Cybozu-API-Token": KINTONE_GROUP}

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
            headers = {"X-Cybozu-API-Token": KINTONE_USER}
            try:
                response = requests.get(kintone_url, headers=headers)
                if response.status_code == 200:
                    original_data = response.json()
                    transformed_data = {}
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
                            transformed_data[record["username"]["value"]] = {
                                "birthday": birthday_str,
                                "days_until_birthday": days_until_birthday,
                            }
                    return transformed_data
                else:
                    raise HTTPException(
                        status_code=response.status_code,
                        detail="Failed to fetch data from Kintone API",
                    )
            except Exception as e:
                raise HTTPException(status_code=500, detail=str(e))
        else:
            raise HTTPException(
                status_code=response.status_code,
                detail="Failed to fetch data from Kintone API",
            )
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@app.get("/group/birthday/{username}")
def get_birthday_suggestions(username: str):
    kintone_url = "https://lifelens.kintone.com/k/v1/records.json?app=3"
    headers = {"X-Cybozu-API-Token": KINTONE_USER}

    try:
        response = requests.get(kintone_url, headers=headers)
        if response.status_code == 200:
            original_data = response.json()
            for record in original_data["records"]:
                if record["username"]["value"] == username:
                    user_interest = record["interests"]["value"]
                    completion = client.chat.completions.create(
                        model="gpt-3.5-turbo",
                        messages=[
                            {
                                "role": "user",
                                "content": "give me 10 birthday gift recommendations given the person's interest is "
                                + user_interest
                                + '. Only list the items and return it only in an string of items with "," in between, only 10 lines, make it brief',
                            },
                        ],
                    )
                    text_generated = completion.choices[0].message
                    return {"items": text_generated.content.split("\n")}
            raise HTTPException(status_code=205, detail="user not found")
        else:
            raise HTTPException(
                status_code=response.status_code,
                detail="Failed to fetch data from Kintone API",
            )
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
