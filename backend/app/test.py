from openai import OpenAI
import apikeys

client = OpenAI(api_key=apikeys.OPENAI_API)

user_interest = "cats, dogs, skiing"
completion = client.chat.completions.create(
    model="gpt-3.5-turbo",
    messages=[
        {
            "role": "user",
            "content": "give me 10 birthday gift recommendations given the person's interest is "
            + user_interest
            + '. Only list the items and return it only in an string of items with "," in between, make it brief',
        },
    ],
)
text_generated = completion.choices[0].message
print(str(text_generated["content"]).split("\n"))
