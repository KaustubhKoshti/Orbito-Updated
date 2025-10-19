# Quick Health Check for Orbito
Write-Host "🔍 Quick Orbito Health Check" -ForegroundColor Cyan
Write-Host "=============================" -ForegroundColor Cyan
Write-Host ""

$passed = 0
$total = 8

# Test 1: Project structure
Write-Host "1. Project Structure..." -ForegroundColor Yellow
if ((Test-Path "backend") -and (Test-Path "frontend")) {
    Write-Host "   ✅ PASS - Directories found" -ForegroundColor Green
    $passed++
} else {
    Write-Host "   ❌ FAIL - Missing directories" -ForegroundColor Red
}

# Test 2: Backend virtual environment
Write-Host "2. Backend Environment..." -ForegroundColor Yellow
if (Test-Path "backend/venv") {
    Write-Host "   ✅ PASS - Virtual environment found" -ForegroundColor Green
    $passed++
} else {
    Write-Host "   ❌ FAIL - Virtual environment missing" -ForegroundColor Red
}

# Test 3: Frontend dependencies
Write-Host "3. Frontend Dependencies..." -ForegroundColor Yellow
if (Test-Path "frontend/node_modules") {
    Write-Host "   ✅ PASS - Node modules found" -ForegroundColor Green
    $passed++
} else {
    Write-Host "   ❌ FAIL - Run 'npm install' in frontend" -ForegroundColor Red
}

# Test 4: Backend server
Write-Host "4. Backend Server..." -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "http://localhost:8000/health" -TimeoutSec 2 -ErrorAction Stop
    if ($response.status -eq "healthy") {
        Write-Host "   ✅ PASS - Backend running" -ForegroundColor Green
        $passed++
    }
} catch {
    Write-Host "   ❌ FAIL - Backend not running" -ForegroundColor Red
}

# Test 5: Frontend server
Write-Host "5. Frontend Server..." -ForegroundColor Yellow
try {
    $response = Test-NetConnection -ComputerName localhost -Port 3000 -InformationLevel Quiet
    if ($response) {
        Write-Host "   ✅ PASS - Frontend running" -ForegroundColor Green
        $passed++
    } else {
        Write-Host "   ❌ FAIL - Frontend not running" -ForegroundColor Red
    }
} catch {
    Write-Host "   ❌ FAIL - Frontend not running" -ForegroundColor Red
}

# Test 6: API Documentation
Write-Host "6. API Documentation..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://localhost:8000/docs" -UseBasicParsing -TimeoutSec 2 -ErrorAction Stop
    if ($response.StatusCode -eq 200) {
        Write-Host "   ✅ PASS - API docs accessible" -ForegroundColor Green
        $passed++
    }
} catch {
    Write-Host "   ❌ FAIL - API docs not accessible" -ForegroundColor Red
}

# Test 7: CORS (Frontend-Backend communication)
Write-Host "7. Frontend-Backend Integration..." -ForegroundColor Yellow
try {
    $headers = @{"Origin" = "http://localhost:3000"}
    $response = Invoke-RestMethod -Uri "http://localhost:8000/health" -Headers $headers -TimeoutSec 2 -ErrorAction Stop
    if ($response.status -eq "healthy") {
        Write-Host "   ✅ PASS - CORS working" -ForegroundColor Green
        $passed++
    }
} catch {
    Write-Host "   ❌ FAIL - Integration not working" -ForegroundColor Red
}

# Test 8: Environment files
Write-Host "8. Environment Files..." -ForegroundColor Yellow
$envCount = 0
if (Test-Path "backend/.env") { $envCount++ }
if (Test-Path "frontend/.env.local") { $envCount++ }

if ($envCount -eq 2) {
    Write-Host "   ✅ PASS - Environment files present" -ForegroundColor Green
    $passed++
} elseif ($envCount -eq 1) {
    Write-Host "   ⚠️  PARTIAL - Some env files missing" -ForegroundColor Yellow
} else {
    Write-Host "   ❌ FAIL - Environment files missing" -ForegroundColor Red
}

Write-Host ""
Write-Host "=============================" -ForegroundColor Cyan
Write-Host "📊 SUMMARY" -ForegroundColor Cyan
Write-Host "=============================" -ForegroundColor Cyan

$percentage = [math]::Round(($passed / $total) * 100)
Write-Host "Score: $passed/$total ($percentage%)" -ForegroundColor $(if ($percentage -ge 80) {"Green"} elseif ($percentage -ge 60) {"Yellow"} else {"Red"})

if ($percentage -ge 80) {
    Write-Host "🎉 EXCELLENT - System is ready!" -ForegroundColor Green
    Write-Host ""
    Write-Host "🔗 Quick Links:" -ForegroundColor Cyan
    Write-Host "   Frontend: http://localhost:3000" -ForegroundColor Blue
    Write-Host "   Backend: http://localhost:8000" -ForegroundColor Blue
    Write-Host "   API Docs: http://localhost:8000/docs" -ForegroundColor Blue
} elseif ($percentage -ge 60) {
    Write-Host "⚠️  GOOD - Some issues to resolve" -ForegroundColor Yellow
} else {
    Write-Host "❌ NEEDS WORK - Multiple issues found" -ForegroundColor Red
}

Write-Host ""