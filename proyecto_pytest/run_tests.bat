@echo off
echo Activando el entorno virtual...

REM Verificar si el directorio venv existe
if not exist "venv" (
    python -m venv venv
)

REM Verificar si el archivo activate existe en venv/Scripts (Windows)
if exist "venv\Scripts\activate.bat" (
    call venv\Scripts\activate.bat
) else (
    echo Error: No se pudo activar el entorno virtual
    exit /b 1
)

echo Instalando dependencias...
python -m pip install --upgrade pip
python -m pip install -r requirements.txt

REM Limpiar y crear directorio de reportes
if exist reports (
    rmdir /s /q reports
)
mkdir reports

echo Ejecutando pruebas con pytest...
pytest tests/ --junitxml=reports/test-results.xml --html=reports/test-results.html --self-contained-html

REM Verificar que se haya generado el reporte HTML
if exist reports\test-results.html (
    echo Reporte HTML generado correctamente.
) else (
    echo ERROR: No se generó el reporte HTML.
    exit /b 1
)

echo Pruebas finalizadas. Resultados guardados en la carpeta reports.
