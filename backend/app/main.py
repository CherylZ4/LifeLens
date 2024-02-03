from ast import List
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import requests

app = FastAPI()


@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.get("/users/")
async def get_users():
    # Replace the URL with your actual Kintone API URL
    kintone_url = "https://lifelens.kintone.com/k/v1/record.json?app=3&id=2"

    headers = {"X-Cybozu-API-Token": "UAAcDTKtR1wmtqtNZELqbKZpsFDwcRynN5CkvPmc"}

    try:
        # Make the API call to Kintone
        response = requests.get(kintone_url, headers=headers)

        # Check if the request was successful
        if response.status_code == 200:
            original_data = response.json()
            transformed_data = {
                "id": original_data["record"]["$id"]["value"],
                "first_name": original_data["record"]["first_name"]["value"],
                "last_name": original_data["record"]["last_name"]["value"],
                "birthday": original_data["record"]["birthday"]["value"],
                "food_restrictions": [
                    restriction.capitalize()
                    for restriction in original_data["record"]["food_restrictions"][
                        "value"
                    ]
                ],
                "interests": original_data["record"]["interests"]["value"],
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
