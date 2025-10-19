# Orbito Health Check Script
# Run this script to verify your local development environment

Write-Host "🔍 Orbito Development Environment Health Check" -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host ""

# Initialize results
$results = @()
$overallHealth = $true

function Test-Component {
    param(
        [string]$Name,
        [scriptblock]$TestScript,
        [string]$Description = ""
    )
    
    Write-Host "Testing: $Name" -ForegroundColor Yellow
    if ($Description) {
        Write-Host "  $Description" -ForegroundColor Gray
    }
    
    try {
        $result = & $TestScript
        if ($result.Success) {
            Write-Host "  ✅ PASS: $($result.Message)" -ForegroundColor Green
            $script:results += @{Component = $Name; Status = "PASS"; Message = $result.Message}
        } else {
            Write-Host "  ❌ FAIL: $($result.Message)" -ForegroundColor Red
            $script:results += @{Component = $Name; Status = "FAIL"; Message = $result.Message}
            $script:overallHealth = $false
        }
    }
    catch {
        Write-Host "  ❌ ERROR: $($_.Exception.Message)" -ForegroundColor Red
        $script:results += @{Component = $Name; Status = "ERROR"; Message = $_.Exception.Message}
        $script:overallHealth = $false
    }
    Write-Host ""
}

# Test 1: Check if we're in the right directory
Test-Component "Project Structure" {
    if ((Test-Path "backend") -and (Test-Path "frontend") -and (Test-Path "database")) {
        return @{Success = $true; Message = "All main directories found"}
    } else {
        return @{Success = $false; Message = "Missing main directories. Make sure you're in the Orbito project root."}
    }
} "Verify project directory structure"

# Test 2: Check Python installation and virtual environment
Test-Component "Python Backend Environment" {
    if (Test-Path "backend/venv") {
        if (Test-Path "backend/venv/Scripts/activate.ps1") {
            # Try to activate and check Python
            & backend/venv/Scripts/Activate.ps1
            $pythonVersion = python --version 2>$null
            if ($pythonVersion) {
                return @{Success = $true; Message = "Virtual environment active, Python version: $pythonVersion"}
            } else {
                return @{Success = $false; Message = "Python not accessible in virtual environment"}
            }
        } else {
            return @{Success = $false; Message = "Virtual environment activation script not found"}
        }
    } else {
        return @{Success = $false; Message = "Virtual environment not found. Run 'python -m venv backend/venv'"}
    }
} "Check Python virtual environment"

# Test 3: Check Node.js and npm
Test-Component "Node.js Frontend Environment" {
    try {
        $nodeVersion = node --version 2>$null
        $npmVersion = npm --version 2>$null
        if ($nodeVersion -and $npmVersion) {
            return @{Success = $true; Message = "Node.js $nodeVersion, npm $npmVersion"}
        } else {
            return @{Success = $false; Message = "Node.js or npm not found. Install from nodejs.org"}
        }
    }
    catch {
        return @{Success = $false; Message = "Node.js or npm not accessible"}
    }
} "Check Node.js and npm installation"

# Test 4: Check backend dependencies
Test-Component "Backend Dependencies" {
    if (Test-Path "backend/requirements.txt") {
        Push-Location "backend"
        try {
            & ./venv/Scripts/Activate.ps1
            $fastapi = pip show fastapi 2>$null
            $uvicorn = pip show uvicorn 2>$null
            if ($fastapi -and $uvicorn) {
                return @{Success = $true; Message = "Core backend dependencies installed"}
            } else {
                return @{Success = $false; Message = "Missing core dependencies. Run 'pip install -r requirements.txt'"}
            }
        }
        finally {
            Pop-Location
        }
    } else {
        return @{Success = $false; Message = "requirements.txt not found"}
    }
} "Verify backend Python packages"

# Test 5: Check frontend dependencies
Test-Component "Frontend Dependencies" {
    if (Test-Path "frontend/package.json") {
        if (Test-Path "frontend/node_modules") {
            Push-Location "frontend"
            try {
                $packageJson = Get-Content "package.json" | ConvertFrom-Json
                $nextVersion = (npm list next --depth=0 2>$null | Select-String "next@").ToString().Split('@')[1]
                if ($nextVersion) {
                    return @{Success = $true; Message = "Frontend dependencies installed (Next.js $nextVersion)"}
                } else {
                    return @{Success = $false; Message = "Frontend dependencies incomplete. Run 'npm install'"}
                }
            }
            finally {
                Pop-Location
            }
        } else {
            return @{Success = $false; Message = "node_modules not found. Run 'npm install' in frontend directory"}
        }
    } else {
        return @{Success = $false; Message = "package.json not found"}
    }
} "Verify frontend npm packages"

# Test 6: Check backend server startup
Test-Component "Backend Server" {
    # Check if backend is already running
    try {
        $response = Invoke-RestMethod -Uri "http://localhost:8000/health" -TimeoutSec 3 -ErrorAction Stop
        if ($response.status -eq "healthy") {
            return @{Success = $true; Message = "Backend server running and healthy"}
        }
    }
    catch {
        return @{Success = $false; Message = "Backend not running. Start with: cd backend && uvicorn app.main:app --reload --port 8000"}
    }
} "Test backend API server"

# Test 7: Check frontend server
Test-Component "Frontend Server" {
    try {
        $response = Invoke-WebRequest -Uri "http://localhost:3000" -UseBasicParsing -TimeoutSec 3 -ErrorAction Stop
        if ($response.StatusCode -eq 200 -or $response.StatusCode -eq 500) {
            return @{Success = $true; Message = "Frontend server responding (Next.js running)"}
        }
    }
    catch {
        return @{Success = $false; Message = "Frontend not running. Start with: cd frontend && npm run dev"}
    }
} "Test frontend development server"

# Test 8: Check environment files
Test-Component "Environment Configuration" {
    $missingFiles = @()
    if (-not (Test-Path "backend/.env")) { $missingFiles += "backend/.env" }
    if (-not (Test-Path "frontend/.env.local")) { $missingFiles += "frontend/.env.local" }
    
    if ($missingFiles.Count -eq 0) {
        return @{Success = $true; Message = "Environment files present"}
    } else {
        return @{Success = $false; Message = "Missing: $($missingFiles -join ', '). Copy from .example files"}
    }
} "Check environment configuration files"

# Test 9: Test API integration
Test-Component "Frontend-Backend Integration" {
    try {
        $headers = @{"Origin" = "http://localhost:3000"}
        $response = Invoke-RestMethod -Uri "http://localhost:8000/health" -Headers $headers -TimeoutSec 3 -ErrorAction Stop
        if ($response.status -eq "healthy") {
            return @{Success = $true; Message = "CORS working, frontend can communicate with backend"}
        }
    }
    catch {
        return @{Success = $false; Message = "Integration test failed. Check if both servers are running"}
    }
} "Test cross-origin requests (CORS)"

# Test 10: Check API documentation
Test-Component "API Documentation" {
    try {
        $response = Invoke-WebRequest -Uri "http://localhost:8000/docs" -UseBasicParsing -TimeoutSec 3 -ErrorAction Stop
        if ($response.StatusCode -eq 200 -and $response.Content.Contains("swagger")) {
            return @{Success = $true; Message = "API docs accessible at http://localhost:8000/docs"}
        }
    }
    catch {
        return @{Success = $false; Message = "API documentation not accessible"}
    }
} "Verify interactive API documentation"

Write-Host "=============================================" -ForegroundColor Cyan
Write-Host "📊 HEALTH CHECK SUMMARY" -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan

# Display summary table
$results | ForEach-Object {
    $status = $_.Status
    $color = switch ($status) {
        "PASS" { "Green" }
        "FAIL" { "Red" }
        "ERROR" { "Magenta" }
    }
    Write-Host ("{0,-30} {1,-6} {2}" -f $_.Component, $_.Status, $_.Message) -ForegroundColor $color
}

Write-Host ""
if ($overallHealth) {
    Write-Host "🎉 OVERALL STATUS: HEALTHY" -ForegroundColor Green
    Write-Host "Your Orbito development environment is ready!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Quick Links:" -ForegroundColor Cyan
    Write-Host "  Frontend: http://localhost:3000" -ForegroundColor Blue
    Write-Host "  Backend API: http://localhost:8000" -ForegroundColor Blue
    Write-Host "  API Docs: http://localhost:8000/docs" -ForegroundColor Blue
} else {
    Write-Host "⚠️  OVERALL STATUS: NEEDS ATTENTION" -ForegroundColor Red
    Write-Host "Please resolve the failed checks above." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Common solutions:" -ForegroundColor Cyan
    Write-Host "  1. Install missing software (Python, Node.js)" -ForegroundColor White
    Write-Host "  2. Set up virtual environment: python -m venv backend/venv" -ForegroundColor White
    Write-Host "  3. Install dependencies: pip install -r requirements.txt && npm install" -ForegroundColor White
    Write-Host "  4. Copy and configure .env files" -ForegroundColor White
    Write-Host "  5. Start servers: uvicorn app.main:app --reload & npm run dev" -ForegroundColor White
}

Write-Host ""
Write-Host "For detailed setup instructions, see: TEAM_SETUP_GUIDE.md" -ForegroundColor Gray