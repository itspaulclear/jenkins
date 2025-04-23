@echo off
setlocal

echo Verificando entorno virtual...
if not exist "venv" (
    python -m venv venv
)

echo Instalando dependencias...
venv\Scripts\python.exe -m pip install --upgrade pip
venv\Scripts\python.exe -m pip install -r requirements.txt

REM Limpiar y crear carpeta de reportes
if exist reports (
    rmdir /s /q reports
)
mkdir reports

echo Ejecutando pruebas con pytest...
venv\Scripts\python.exe -m pytest tests/ --junitxml=reports/test-results.xml --html=reports/test-results.html --self-contained-html

REM Verificar si se generó el reporte
if exist reports\test-results.html (
    echo Reporte generado correctamente.
) else (
    echo ERROR: No se generó el reporte HTML.
    exit /b 1
)

echo Pruebas finalizadas. Resultados en carpeta reports.
endlocal
