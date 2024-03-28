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
for dir in models schemas plugin controller converter;
do
  mkdir $dir
  touch $dir/__init__.py
done

mkdir -p api/v1
touch api/__init__.py
touch api/v1/__init__.py

mkdir core
touch core/__init__.py
touch core/build.py
touch core/setup.py

mkdir config
touch config/__init__.py
touch config/setting.py

mkdir cron
touch cron/__init__.py
touch cron/config.py
touch cron/task.py

mkdir errors
touch errors/__init__.py
touch errors/exception.py


mkdir handlers
touch handlers/__init__.py
touch handlers/exception.py


mkdir tools
touch tools/__init__.py
touch tools/log.py


mkdir utils
touch utils/__init__.py
touch utils/session.py
touch utils/sql.py


mkdir script
touch script/startup.sh
echo "alembic upgrade head" >> script/startup.sh
echo "uvicorn main:app --host 0.0.0.0" >> script/startup.sh

# Create the files
touch .gitignore .env main.py README.md
echo "__pycache__" >> .gitignore
echo "venv" >> .gitignore
echo ".vscode" >> .gitignore
echo ".pytest_cache" >> .gitignore
echo ".env" >> .gitignore 

touch .flake8
echo "[flake8]" >> .flake8
echo "max-line-length = 88" >> .flake8
echo "extend-ignore = E203" >> .flake8
echo "exclude = .git,__pycache__,venv,alembic,tools,tests" >> .flake8


python -m venv venv


poetry init -n

source venv/Scripts/activate

echo "Installing packages..."

poetry add fastapi alembic uvicorn sqlalchemy pydantic pydantic-settings psycopg2-binary psycopg2 requests flake8

echo "Packages installed."

echo "Creating alembic configuration..."
alembic init alembic


