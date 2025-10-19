# 👥 Orbito - Team Setup Guide
**Complete Step-by-Step Instructions for Team Members**

## 🎯 What You'll Have After Setup
- ✅ Full AI-Enhanced HR ERP System
- ✅ Multi-AI Provider Support (OpenAI, Gemini, Hugging Face, Ollama)
- ✅ Advanced ATS with Resume Parsing
- ✅ n8n Workflow Automation
- ✅ Real-time Analytics Dashboard
- ✅ Role-based Access (Admin, HR, Employee)

---

## 🛠 **STEP 1: Install Required Software**

### **A. Install Node.js (Required for Frontend)**
1. Go to [nodejs.org](https://nodejs.org)
2. Download **LTS version** (18.x or higher)
3. Run installer with default settings
4. Verify installation:
```bash
node --version    # Should show v18.x.x or higher
npm --version     # Should show 9.x.x or higher
```

### **B. Install Python (Required for Backend)**
1. Go to [python.org](https://python.org)
2. Download **Python 3.8+** (recommend 3.11)
3. **IMPORTANT**: Check "Add Python to PATH" during installation
4. Verify installation:
```bash
python --version     # Should show Python 3.8+ 
pip --version        # Should show pip version
```

### **C. Install Git (If Not Already Installed)**
1. Go to [git-scm.com](https://git-scm.com)
2. Download and install with default settings
3. Verify: `git --version`

---

## 📁 **STEP 2: Get the Project**

### **Option A: Clone from Repository (If Shared)**
```bash
git clone <repository-url>
cd Orbito
```

### **Option B: Copy Project Files**
If you received the project as a zip file:
1. Extract to your desired location (e.g., `C:\Projects\Orbito`)
2. Open terminal/command prompt in the project folder

---

## 🔧 **STEP 3: Install Project Dependencies**

### **A. Frontend Dependencies**
```bash
# Navigate to frontend folder
cd frontend

# Install all frontend packages
npm install
```
**What this installs:**
- Next.js framework
- React components
- Supabase client
- UI libraries (shadcn/ui, Tailwind)
- TypeScript and development tools

### **B. Backend Dependencies**
```bash
# Navigate to backend folder  
cd ../backend

# Create Python virtual environment
python -m venv venv

# Activate virtual environment
# Windows (Command Prompt):
venv\Scripts\activate
# Windows (PowerShell):
venv\Scripts\Activate.ps1
# macOS/Linux:
source venv/bin/activate

# Install all backend packages
pip install -r requirements.txt
```

**What this installs:**
- FastAPI framework
- AI libraries (OpenAI, Anthropic, Google Gemini, Hugging Face, Ollama)
- Resume processing tools (PyPDF2, spaCy, nltk)
- Database connectors (Supabase, PostgreSQL)
- Document processing (OCR, text extraction)
- Workflow automation tools

### **C. Additional AI Dependencies (Optional but Recommended)**
```bash
# For better resume parsing (in backend virtual environment)
python -m spacy download en_core_web_sm

# If you want to use Hugging Face models locally
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
```

---

## 🗄 **STEP 4: Database Setup (Supabase)**

### **A. Create Supabase Account**
1. Go to [supabase.com](https://supabase.com)
2. Sign up for free account
3. Click "New Project"
4. Choose organization, enter project name: **"Orbito"**
5. Create strong database password
6. Choose region closest to your team
7. Click "Create new project" (takes ~2 minutes)

### **B. Setup Database Schema**
1. In Supabase dashboard, go to **SQL Editor**
2. Open the file `database/schema.sql` from the project
3. Copy ALL contents and paste in SQL Editor
4. Click **"RUN"** 
5. ✅ You should see "Success" message

### **C. Get API Keys**
1. Go to **Settings** → **API**
2. Copy these values (you'll need them next):
   - **Project URL**: `https://xxxxx.supabase.co`
   - **anon public key**: `eyJhbGciOiJIUzI1NiIs...`
   - **service_role key**: `eyJhbGciOiJIUzI1NiIs...`

---

## ⚙️ **STEP 5: Environment Configuration**

### **A. Frontend Configuration**
```bash
# In frontend folder
cd frontend

# Copy example file
copy .env.local.example .env.local
# On macOS/Linux: cp .env.local.example .env.local

# Edit .env.local file with your text editor
```

**Edit `frontend/.env.local`:**
```env
NEXT_PUBLIC_SUPABASE_URL=https://your-project-id.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
NEXT_PUBLIC_API_URL=http://localhost:8000
```

### **B. Backend Configuration**
```bash
# In backend folder
cd backend

# Copy example file
copy .env.example .env
# On macOS/Linux: cp .env.example .env

# Edit .env file with your text editor
```

**Edit `backend/.env`:**
```env
# Supabase Configuration (Required)
SUPABASE_URL=https://your-project-id.supabase.co
SUPABASE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...your-anon-key
SUPABASE_SERVICE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...your-service-key

# Basic Configuration
FRONTEND_URL=http://localhost:3000
SECRET_KEY=orbito-super-secret-2024-change-this

# AI Configuration (Optional - choose one or more)
# For best results, get OpenAI key:
OPENAI_API_KEY=sk-your-openai-key-here

# Alternative free options:
# GEMINI_API_KEY=your-gemini-key-here
# HUGGINGFACE_API_KEY=hf_your-key-here

# n8n Automation (Optional)
N8N_WEBHOOK_URL=http://localhost:5678
```

**🔑 Getting AI API Keys (Optional):**

**OpenAI (Recommended for best results):**
1. Go to [platform.openai.com](https://platform.openai.com)
2. Sign up/login
3. Go to API → API Keys → Create new secret key
4. Copy key (starts with `sk-`)

**Google Gemini (Free tier available):**
1. Go to [ai.google.dev](https://ai.google.dev)
2. Get API key for Gemini
3. Copy key

**Hugging Face (Free):**
1. Go to [huggingface.co](https://huggingface.co)
2. Sign up → Settings → Access Tokens → New token
3. Copy token (starts with `hf_`)

---

## 🚀 **STEP 6: Run the Application**

### **Method A: Automatic Startup (Recommended)**

**Windows:**
```bash
# From project root directory
.\start-dev.ps1
```

**What this does:**
- Starts backend on port 8000
- Starts frontend on port 3000  
- Opens both in separate terminal windows
- Shows you the URLs to access

### **Method B: Manual Startup**

**Terminal 1 (Backend):**
```bash
cd backend
# Activate virtual environment
venv\Scripts\activate    # Windows
# source venv/bin/activate  # macOS/Linux

# Start backend
uvicorn app.main:app --reload --port 8000
```

**Terminal 2 (Frontend):**
```bash
cd frontend
npm run dev
```

---

## 🌐 **STEP 7: Access Your Application**

Once both servers are running:

- **🎨 Frontend (Main App)**: http://localhost:3000
- **⚡ Backend API**: http://localhost:8000  
- **📚 API Documentation**: http://localhost:8000/docs

---

## 👤 **STEP 8: Create Your First User**

1. Go to http://localhost:3000
2. You'll see the login page
3. Click **"Sign Up"** tab
4. Fill in details:
   - **Full Name**: Your name
   - **Email**: Your email  
   - **Password**: Create strong password
   - **Role**: Choose Admin (for full access)
   - **Department**: Your department
   - **Position**: Your role

5. Click **"Create Account"**
6. ✅ You should be redirected to the dashboard!

---

## 🔧 **Troubleshooting Common Issues**

### **"Python not found" Error**
**Solution:**
```bash
# Try these variations:
python3 --version
py --version

# If none work, reinstall Python with "Add to PATH" checked
```

### **"Module not found" Error**
**Solution:**
```bash
# Make sure virtual environment is activated
cd backend
venv\Scripts\activate
pip install -r requirements.txt
```

### **Frontend Won't Start**
**Solution:**
```bash
cd frontend
# Clear cache and reinstall
rm -rf node_modules package-lock.json  # macOS/Linux
# rmdir /s node_modules && del package-lock.json  # Windows
npm install
```

### **Database Connection Error**
**Solution:**
1. Double-check Supabase URL and keys in `.env` files
2. Ensure database schema was applied successfully
3. Check Supabase dashboard is accessible

### **"Port already in use" Error**
**Solution:**
```bash
# Kill processes using ports 3000 or 8000
# Windows:
netstat -ano | findstr :3000
taskkill /PID <process-id> /F

# macOS/Linux:
lsof -ti:3000 | xargs kill -9
```

---

## 🎉 **Verification Checklist**

After setup, verify everything works:

- [ ] ✅ Frontend loads at http://localhost:3000
- [ ] ✅ Backend API accessible at http://localhost:8000  
- [ ] ✅ Can create user account
- [ ] ✅ Can login and see dashboard
- [ ] ✅ API docs load at http://localhost:8000/docs
- [ ] ✅ No console errors in browser developer tools

---

## 🚀 **Optional: Enhanced Features Setup**

### **A. n8n Workflow Automation**
```bash
# Install Docker Desktop from docker.com
# Then run:
docker run -it --rm --name n8n -p 5678:5678 n8nio/n8n

# Access n8n at: http://localhost:5678
# Default credentials: admin / orbito123
```

### **B. Ollama (Free Local AI)**
```bash
# Install Ollama from ollama.ai
# Pull a model:
ollama pull llama2

# Your .env file should have:
OLLAMA_HOST=http://localhost:11434
OLLAMA_MODEL=llama2
```

### **C. Full Stack with Docker**
If you have Docker installed:
```bash
# Start everything at once
docker-compose up -d

# Access all services:
# Frontend: http://localhost:3000
# Backend: http://localhost:8000
# n8n: http://localhost:5678
# MinIO: http://localhost:9001
```

---

## 📞 **Getting Help**

### **If You're Stuck:**
1. Check the **troubleshooting section** above
2. Look at terminal/console error messages
3. Verify all **environment variables** are set correctly
4. Ensure all **dependencies** are installed
5. Check **ports 3000 and 8000** are not in use by other applications

### **Quick Health Check:**
```bash
# Test if backend is working
curl http://localhost:8000/health
# Should return: {"status":"healthy","service":"orbito-backend"}

# Test if Supabase connection works
curl http://localhost:8000/api/auth/signup -X POST
# Should return error about missing data (means API is working)
```

---

## 🎯 **What Your Team Can Do Now**

After successful setup, your team can:

### **HR Team:**
- ✅ Create job postings with AI-generated descriptions
- ✅ Upload and parse candidate resumes automatically  
- ✅ Score candidates with AI against job requirements
- ✅ Schedule interviews with automated notifications
- ✅ Track hiring metrics and analytics

### **Admin Team:**
- ✅ Manage user roles and permissions
- ✅ Configure system settings and workflows
- ✅ Access comprehensive analytics and reports
- ✅ Set up n8n automation workflows

### **All Users:**
- ✅ Manage their profiles and settings
- ✅ Use AI policy chatbot for company questions
- ✅ Submit and track leave requests  
- ✅ View achievements and recognition
- ✅ Access company calendar and events

---

## 🔄 **Next Steps for Your Team**

1. **Everyone completes setup** following this guide
2. **Admin user** sets up initial company data (policies, departments)
3. **HR team** creates first job postings and tests ATS
4. **Configure AI providers** based on team budget/preferences  
5. **Set up n8n workflows** for automated processes
6. **Customize** the system for your company's needs

---

## 🎉 **Congratulations!**

Your team now has access to a **professional, AI-enhanced HR ERP system** that includes:

✅ **Multi-AI Provider Support** - Choose from OpenAI, Gemini, Hugging Face, or Ollama  
✅ **Advanced ATS** - Resume parsing, candidate scoring, interview management  
✅ **Workflow Automation** - n8n integration for automated HR processes  
✅ **Role-Based Access** - Secure, role-specific functionality  
✅ **Real-time Analytics** - Hiring insights and metrics  
✅ **Enterprise Features** - Audit trails, compliance, scalability  

**Welcome to the future of HR management! 🚀**

---

**📧 Need Help?** 
- Check API documentation: http://localhost:8000/docs
- Review error logs in terminal windows
- Verify environment configuration files