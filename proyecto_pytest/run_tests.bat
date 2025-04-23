@echo off
echo "activando el entorno virtual..."
if[ ! -d "venv" ]; then
    python -m venv venv
fi

if [ -f "venv/bin/activate" ]; then
    call venv/bin/activate
elif [ -f "venv/Scripts/activate" ]; then
    call venv/Scripts/activate
else
    echo "Error: No se pudo activar el entorno virtual"
    exit 1
fi

echo "instalando dependencias..."
pip install --upgrade pip --break-system-packages
pip install -r requirements.txt --break-system-packages

echo "ejecutando pruebas con pytest"
venv/bin/python -m pytest tests/ --junitxml=reports/test-results.xml --html=reports/test-results.html --self-contained-html

echo "pruebas finalizadas resultados en reports"
