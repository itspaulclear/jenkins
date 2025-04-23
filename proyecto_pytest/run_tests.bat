@echo off
echo Activando el entorno virtual...

REM Crear el entorno virtual si no existe
if not exist "venv" (
    python -m venv venv
)

REM Activar el entorno virtual
call venv\Scripts\activate.bat

echo Instalando dependencias...
call venv\Scripts\pip install --upgrade pip
call venv\Scripts\pip install -r requirements.txt

REM Crear directorio de reportes si no existe
if not exist "reports" (
    mkdir reports
)

echo Ejecutando pruebas con pytest...
call venv\Scripts\pytest tests/ --junitxml=reports/test-results.xml --html=reports/test-results.html --self-contained-html

echo Pruebas finalizadas. Resultados guardados en la carpeta reports.


