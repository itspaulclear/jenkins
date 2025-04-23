@echo off
echo Activando el entorno virtual...

REM Verificar si el directorio venv existe
if not exist "venv" (
    python -m venv venv
)

REM Verificar si el archivo activate.bat existe en venv\Scripts (Windows)
if exist "venv\Scripts\activate.bat" (
    call venv\Scripts\activate.bat
) else (
    echo Error: No se pudo activar el entorno virtual
    exit /b 1
)

REM Asegurarse de que se usen pip y pytest del entorno virtual
set PIP_PATH=venv\Scripts\pip.exe
set PYTEST_PATH=venv\Scripts\pytest.exe

echo Instalando dependencias...
"%PIP_PATH%" install --upgrade pip
"%PIP_PATH%" install -r requirements.txt

REM Crear carpeta de reportes si no existe
if not exist reports (
    mkdir reports
)

echo Ejecutando pruebas con pytest...
"%PYTEST_PATH%" tests/ --junitxml=reports/test-results.xml --html=reports/test-results.html --self-contained-html

echo Pruebas finalizadas. Resultados guardados en la carpeta reports.
exit /b %ERRORLEVEL%


