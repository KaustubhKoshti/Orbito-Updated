@echo off
echo Starting Orbito ERP System...
echo.

REM Check if environment files exist
if not exist "frontend\.env.local" (
    echo ERROR: frontend\.env.local not found!
    echo Please copy .env.local.example to .env.local and configure your Supabase credentials
    pause
    exit /b 1
)

if not exist "backend\.env" (
    echo ERROR: backend\.env not found!
    echo Please copy .env.example to .env and configure your Supabase credentials
    pause
    exit /b 1
)

REM Start backend
echo Starting Backend (FastAPI)...
cd backend
call venv\Scripts\activate
pip install -r requirements.txt >nul 2>&1
start "Orbito Backend" cmd /k "uvicorn app.main:app --reload --port 8000"

REM Wait a moment for backend to start
timeout /t 3 /nobreak >nul

REM Start frontend
echo Starting Frontend (Next.js)...
cd ..\frontend
start "Orbito Frontend" cmd /k "npm run dev"

echo.
echo ✅ Orbito is starting up!
echo.
echo Frontend: http://localhost:3000
echo Backend API: http://localhost:8000
echo API Docs: http://localhost:8000/docs
echo.
echo Press any key to exit...
pause >nul