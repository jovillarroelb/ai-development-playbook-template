#!/bin/bash

echo "=== AI Development Playbook Bootstrap ==="

mkdir -p src tests docs

echo "Seleccione backend:"
echo "1) Node (Express)"
echo "2) Django"
echo "3) FastAPI"
read backend_choice

if [ "$backend_choice" == "1" ]; then
    npm init -y
    npm install express
    mkdir -p src/controllers src/services src/routes
    echo "Backend: Node + Express" >> docs/STACK_DECISIONS.md
fi

if [ "$backend_choice" == "2" ]; then
    python3 -m venv venv
    source venv/bin/activate
    pip install django
    django-admin startproject app .
    echo "Backend: Django" >> docs/STACK_DECISIONS.md
fi

if [ "$backend_choice" == "3" ]; then
    python3 -m venv venv
    source venv/bin/activate
    pip install fastapi uvicorn
    echo "Backend: FastAPI" >> docs/STACK_DECISIONS.md
fi

echo "=== Bootstrap finalizado ==="