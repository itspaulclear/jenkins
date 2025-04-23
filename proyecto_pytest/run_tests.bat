@echo off
echo "activando el entorno virtual"
if[!"-d venv" ]; then
    python -m venv venv
fi

call venv\Scripts\activate

echo "instalando dependencias"
pip install --upgrade pip
pip install -r requirements.txt

echo "ejecutando pruebas con pytest"
pytest tests/ --junitxml=reports/test-results.xml --html=reports/test-results.html --self-contained-html

echo "pruebas finalizadas resultados en reports"
