Write-Host "🚀 Starting Orbito ERP System..." -ForegroundColor Cyan
Write-Host ""

# Check if environment files exist
if (-not (Test-Path "frontend\.env.local")) {
    Write-Host "❌ ERROR: frontend\.env.local not found!" -ForegroundColor Red
    Write-Host "Please copy .env.local.example to .env.local and configure your Supabase credentials" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}

if (-not (Test-Path "backend\.env")) {
    Write-Host "❌ ERROR: backend\.env not found!" -ForegroundColor Red
    Write-Host "Please copy .env.example to .env and configure your Supabase credentials" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}

# Start backend
Write-Host "🐍 Starting Backend (FastAPI)..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd 'D:\Orbito\backend'; .\venv\Scripts\Activate.ps1; pip install -r requirements.txt; uvicorn app.main:app --reload --port 8000" -WindowStyle Normal

# Wait for backend to start
Start-Sleep -Seconds 3

# Start frontend  
Write-Host "⚛️  Starting Frontend (Next.js)..." -ForegroundColor Green
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd 'D:\Orbito\frontend'; npm run dev" -WindowStyle Normal

Write-Host ""
Write-Host "✅ Orbito is starting up!" -ForegroundColor Green
Write-Host ""
Write-Host "Frontend: http://localhost:3000" -ForegroundColor Cyan
Write-Host "Backend API: http://localhost:8000" -ForegroundColor Cyan  
Write-Host "API Docs: http://localhost:8000/docs" -ForegroundColor Cyan
Write-Host ""
Write-Host "Press any key to exit..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")