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
REM Verificar si pip está disponible
where pip >nul 2>&1
if %errorlevel% neq 0 (
    echo "Error: pip no está disponible"
    exit 1
)

pip install --upgrade pip
pip install -r requirements.txt

REM Verificar si el directorio reports existe, si no, crearlo
if not exist "reports" (
    mkdir reports
)

echo "ejecutando pruebas con pytest"
REM Verificar si pytest está disponible
where pytest >nul 2>&1
if %errorlevel% neq 0 (
    echo "Error: pytest no está disponible"
    exit 1
)

pytest tests/ --junitxml=reports/test-results.xml --html=reports/test-results.html --self-contained-html

echo "pruebas finalizadas resultados en reports"


