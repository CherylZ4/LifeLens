# 
FROM python:3.9

# 
WORKDIR /python-docker

# 
COPY /backend/requirements.txt requirements.txt

COPY /backend/apikeys.py apikeys.py
# 
RUN pip install --no-cache-dir --upgrade -r requirements.txt

# 
COPY /backend/app .

# 
CMD ["uvicorn", "main:app", "--reload", "--host", "0.0.0.0", "--port", "8000"]
