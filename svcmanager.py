# svcmanager.py file
from dotenv import load_dotenv
load_dotenv()
import yaml
from os import getenv

print(getenv("APP_KEY", "Yolo"))

# Trying to read the .env for more functions later
# We will try to generate a docker-compose file based on the .env file
# that laravel requires/wants to use as a service
with open(r'.env') as f:
    content = f.readlines()
content = [x.rstrip() for x in content]
print(content)

# Read the current docker-compose
with open(r'docker-compose.yml') as file:
    test = yaml.load(file, Loader=yaml.FullLoader)
    print(test['volumes'])

# Write as a new docker-compose. We could replace the main file here too
with open(r'docker-compose-new.yml' , 'w') as file:
    documents = yaml.dump(test, file)
