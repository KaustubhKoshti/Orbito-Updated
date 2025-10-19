@echo off
echo 🚀 Starting Orbito HR System...

REM Kill any existing processes
taskkill /f /im node.exe /im python.exe >nul 2>&1

echo 📊 Starting Backend (Port 8000)...
cd /d "D:\new orbito\Orbito\backend"
start /min cmd /c "venv\Scripts\python complete_app.py"

timeout /t 3 >nul

echo 🌐 Starting Frontend (Port 3000)...
cd /d "D:\new orbito\Orbito\frontend" 
start /min cmd /c "npm run dev"

echo ⏱️  Waiting for servers to initialize...
timeout /t 8 >nul

echo ✅ Opening Orbito Application...
start http://localhost:3000

echo.
echo 🎯 Orbito is ready!
echo     Frontend: http://localhost:3000
echo     Backend:  http://localhost:8000
echo     API Docs: http://localhost:8000/docs
echo.
pause