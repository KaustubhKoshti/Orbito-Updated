# 🚀 Orbito - Complete Setup Guide

## Overview
Orbito is now a comprehensive AI-Enhanced HR ERP System with multiple AI providers, advanced ATS capabilities, and n8n workflow automation.

## 🛠 What's Included

### ✅ Multi-AI Provider Support
- **OpenAI GPT-4** - Premium AI capabilities
- **Google Gemini** - Google's advanced AI
- **Anthropic Claude** - Ethical AI assistant  
- **Hugging Face** - Open-source models (offline capable)
- **Ollama** - Local AI models (privacy-focused)

### ✅ Advanced ATS (Applicant Tracking System)
- Resume parsing (PDF, DOC, DOCX)
- AI-powered candidate scoring
- Interview scheduling with automation
- Bulk candidate import
- Candidate timeline tracking
- Resume analysis with NLP

### ✅ n8n Workflow Automation
- Automated email notifications
- Interview reminders
- Leave request workflows
- Employee onboarding automation
- Achievement celebrations
- Job posting automation

### ✅ Document Processing
- PDF text extraction
- OCR capabilities
- Document classification
- File storage with MinIO

### ✅ Enhanced Features
- Real-time analytics
- Predictive hiring insights
- Advanced candidate matching
- Role-based dashboards
- Comprehensive audit trails

## 📋 Prerequisites

### Required
- **Node.js 18+** and npm/yarn
- **Python 3.8+**
- **Supabase account** (free tier works)

### Optional (for enhanced features)
- **OpenAI API key** (recommended for best AI results)
- **Google Gemini API key** (alternative AI provider)
- **Anthropic API key** (ethical AI option)
- **Docker & Docker Compose** (for full stack deployment)

## 🏁 Quick Setup (5 minutes)

### 1. Clone and Install Dependencies
```bash
# Clone project
git clone <your-repo-url>
cd Orbito

# Frontend setup
cd frontend
npm install

# Backend setup  
cd ../backend
python -m venv venv
# Windows:
venv\Scripts\activate
# Unix/macOS:
source venv/bin/activate
pip install -r requirements.txt
```

### 2. Supabase Database Setup
1. Go to [supabase.com](https://supabase.com) → Create new project
2. Copy your project URL and API keys
3. Go to **SQL Editor** → Paste contents of `database/schema.sql` → Run
4. Your database is ready! ✅

### 3. Environment Configuration

**Frontend (`frontend/.env.local`):**
```env
NEXT_PUBLIC_SUPABASE_URL=https://your-project-id.supabase.co  
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_anon_key_here
NEXT_PUBLIC_API_URL=http://localhost:8000
```

**Backend (`backend/.env`):**
```env
# Supabase (Required)
SUPABASE_URL=https://your-project-id.supabase.co
SUPABASE_KEY=your_anon_key_here
SUPABASE_SERVICE_KEY=your_service_role_key_here

# AI Providers (Choose at least one)
OPENAI_API_KEY=sk-your-openai-key-here          # Recommended
GEMINI_API_KEY=your-gemini-key-here             # Alternative
ANTHROPIC_API_KEY=sk-ant-your-anthropic-key     # Alternative

# Basic Configuration
FRONTEND_URL=http://localhost:3000
SECRET_KEY=orbito-super-secret-2024
```

### 4. Start the Application
```bash
# Option A: Use startup scripts
.\start-dev.ps1        # PowerShell
# or
start-dev.bat          # Command Prompt

# Option B: Manual start
# Terminal 1 (Backend):
cd backend
uvicorn app.main:app --reload --port 8000

# Terminal 2 (Frontend):  
cd frontend
npm run dev
```

### 5. Access Your Application
- **Frontend:** http://localhost:3000
- **Backend API:** http://localhost:8000
- **API Documentation:** http://localhost:8000/docs

## 🤖 AI Configuration Guide

### OpenAI (Recommended)
```env
OPENAI_API_KEY=sk-your-key-here
```
**Best for:** Job descriptions, policy chat, resume analysis
**Cost:** Pay-per-use, high quality

### Google Gemini (Free Tier Available)
```env
GEMINI_API_KEY=your-gemini-key
```  
**Best for:** General AI tasks, cost-effective
**Cost:** Generous free tier

### Hugging Face (Free/Offline)
```env
HUGGINGFACE_API_KEY=hf_your-key-here  # Optional
```
**Best for:** Privacy, offline capability, no usage costs
**Note:** Downloads models locally (~1-2GB)

### Ollama (Completely Free & Private)
```bash
# Install Ollama
# Windows/Mac: Download from ollama.ai
# Linux: curl -fsSL https://ollama.ai/install.sh | sh

# Pull a model
ollama pull llama2
# or
ollama pull codellama
```
```env
OLLAMA_HOST=http://localhost:11434
OLLAMA_MODEL=llama2
```

## 🔄 n8n Workflow Automation Setup

### Quick Setup (Docker)
```bash
# Start n8n with Docker
docker run -it --rm --name n8n -p 5678:5678 n8nio/n8n

# Access n8n at http://localhost:5678
# Default credentials: admin / orbito123
```

### Full Stack with Docker Compose
```bash
# Start everything (Frontend, Backend, n8n, Redis, MinIO, Ollama)
docker-compose up -d

# View logs
docker-compose logs -f
```

**Services Available:**
- **Frontend:** http://localhost:3000
- **Backend:** http://localhost:8000  
- **n8n:** http://localhost:5678
- **MinIO:** http://localhost:9001
- **Ollama:** http://localhost:11434

## 📊 Advanced Features Setup

### Resume Parsing & ATS
```bash
# Install additional dependencies for resume parsing
pip install spacy
python -m spacy download en_core_web_sm
```

### Email Integration
```env
# Add to backend/.env for email notifications
SMTP_SERVER=smtp.gmail.com
SMTP_PORT=587  
SMTP_USERNAME=your-email@gmail.com
SMTP_PASSWORD=your-app-password
```

### File Storage (MinIO)
```env
MINIO_ENDPOINT=localhost:9000
MINIO_ACCESS_KEY=orbito
MINIO_SECRET_KEY=orbito123  
MINIO_BUCKET=orbito-files
```

## 🏗 Development Workflow

### Running Tests
```bash
# Backend tests
cd backend
pytest

# Frontend tests
cd frontend  
npm run test
```

### Database Migrations
When you modify the database schema:
```bash
# Update database/schema.sql
# Run in Supabase SQL Editor
# Update TypeScript types:
cd frontend
npx supabase gen types typescript --project-id your-project > lib/supabase/types.ts
```

### Adding New AI Models
1. Add provider to `AIProvider` enum in `ai_service.py`
2. Implement `_init_your_provider()` method
3. Add to `_call_with_fallback()` logic
4. Update configuration in `config.py`

## 🔧 Troubleshooting

### Common Issues

**"AI features not working"**
- Check that you have at least one AI provider configured
- Verify API keys are correct
- Check backend logs for specific errors

**"Resume parsing fails"**  
- Install spaCy model: `python -m spacy download en_core_web_sm`
- Check file upload permissions
- Verify file types are supported (.pdf, .docx, .doc)

**"Workflows not triggering"**
- Ensure n8n is running on port 5678
- Check n8n webhook URLs are accessible
- Verify workflow webhooks are active

**"Database connection errors"**
- Double-check Supabase credentials
- Ensure RLS policies are properly configured
- Check if database schema was applied correctly

### Getting Help
1. Check the API documentation: http://localhost:8000/docs
2. Review logs in terminal output
3. Check browser developer console for frontend issues
4. Verify environment variables are loaded

## 🚀 Production Deployment

### Environment Variables for Production
```env
# Production security
SECRET_KEY=your-super-long-secret-key-here
ENVIRONMENT=production

# Production URLs  
FRONTEND_URL=https://your-domain.com
N8N_WEBHOOK_URL=https://n8n.your-domain.com
SUPABASE_URL=https://your-project.supabase.co

# File storage
UPLOAD_DIR=/app/uploads
MINIO_ENDPOINT=your-minio-endpoint.com
```

### Deployment Options
- **Frontend:** Vercel, Netlify, or any hosting service
- **Backend:** Railway, Render, DigitalOcean, AWS
- **Database:** Supabase (managed PostgreSQL)
- **n8n:** Self-hosted or n8n.cloud

## 🎉 You're All Set!

Your Orbito AI-Enhanced HR ERP System now includes:

✅ **Multi-AI Support** - Use any combination of AI providers  
✅ **Advanced ATS** - Resume parsing, candidate scoring, interview management  
✅ **Workflow Automation** - Automated HR processes with n8n  
✅ **Document Processing** - PDF parsing, file management  
✅ **Real-time Analytics** - HR insights and predictive analytics  
✅ **Enterprise Security** - Role-based access, audit trails  
✅ **Scalable Architecture** - Microservices-ready design

## 🔄 Next Steps

1. **Create your first admin user** through the signup process
2. **Set up company policies** for the AI chatbot  
3. **Configure n8n workflows** for your HR processes
4. **Upload job descriptions** and start receiving applications
5. **Customize the system** to match your company's needs

**Happy hiring! 🎯**