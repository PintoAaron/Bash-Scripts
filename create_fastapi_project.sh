# Check if a project name was provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 ProjectName"
    exit 1
fi

# Create the project directory
mkdir $1

# Change to the project directory
cd $1

# Create the subdirectories and an __init__.py file in each one
for dir in models schemas utils tests plugins controller converter;
do
  mkdir $dir
  touch $dir/__init__.py
done

# Create the api directory with a v1 subdirectory
mkdir -p api/v1
touch api/__init__.py
touch api/v1/__init__.py

# Create the core directory with build.py and setup.py
mkdir core
touch core/__init__.py
touch core/build.py
touch core/setup.py

# Create the config directory with settings.py
mkdir config
touch config/__init__.py
touch config/settings.py

mkdir cron
touch cron/__init__.py
touch cron/config.py
touch cron/task.py

# Create the files
touch .gitignore .env main.py


python -m venv venv


poetry init -n

source venv/Scripts/activate

echo "Installing packages..."

poetry add python-dotenv fastapi alembic uvicorn sqlalchemy pydantic pydantic-settings passlib[bcrypt] psycopg2-binary psycopg2 celery

pip freeze > requirements.txt
