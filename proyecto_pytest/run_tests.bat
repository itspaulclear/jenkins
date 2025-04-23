@echo off
echo "activando el entorno virtual..."

REM Verificar si el directorio venv existe
if not exist "venv" (
    python -m venv venv
)

REM Verificar si el archivo activate existe en venv/Scripts (Windows)
if exist "venv\Scripts\activate" (
    call venv\Scripts\activate
) else (
    echo "Error: No se pudo activar el entorno virtual"
    exit 1
)

echo "instalando dependencias..."
pip install --upgrade pip
pip install -r requirements.txt

echo "ejecutando pruebas con pytest"
pytest tests/ --junitxml=reports/test-results.xml --html=reports/test-results.html --self-contained-html

echo "pruebas finalizadas resultados en reports"

