# Orbito - AI-Enhanced HR ERP System

Orbito is a modern, AI-powered Human Resources Enterprise Resource Planning (ERP) system built with Next.js, FastAPI, and Supabase. It features role-based access control, AI-powered job description generation, policy chatbots, and comprehensive HR management tools.

## 🚀 Features

### Core HR Management
- **Role-Based Access Control**: Admin, HR, and Employee roles with different permissions
- **Employee Profiles**: Comprehensive profile management with departments and positions
- **Leave Management**: Request, approve, and track leave applications
- **Achievement Tracking**: Recognition and points system for employee achievements
- **Calendar & Events**: Company-wide calendar with event management

### AI-Powered Features
- **AI Job Description Generator**: Generate compelling job descriptions using OpenAI/Claude
- **Policy Chatbot**: AI assistant for answering company policy questions
- **Resume Analysis**: Automated resume screening against job requirements
- **Smart Notifications**: AI-powered notification and workflow automation

### Technical Features
- **Modern Tech Stack**: Next.js 15, React 19, FastAPI, Supabase
- **Authentication**: Secure authentication with Supabase Auth
- **Real-time Updates**: Live updates using Supabase subscriptions
- **Responsive Design**: Mobile-first design with TailwindCSS
- **Type Safety**: Full TypeScript implementation

## 🛠 Architecture

### Frontend (Next.js)
- **Framework**: Next.js 15.4.6 with App Router
- **UI**: TailwindCSS v4 + shadcn/ui components
- **Authentication**: Supabase Auth with middleware protection
- **State Management**: React Context + Supabase client

### Backend (FastAPI)
- **API Framework**: FastAPI with async/await
- **Authentication**: Supabase integration with JWT verification
- **AI Services**: OpenAI GPT-4 and Anthropic Claude integration
- **Database**: Supabase PostgreSQL with Row Level Security

### Database (Supabase)
- **PostgreSQL**: Full-featured database with real-time capabilities
- **Row Level Security**: Database-level access control
- **Real-time**: Live updates and subscriptions
- **Storage**: File storage for resumes and documents

## 📋 Prerequisites

- Node.js 18+ and npm/yarn
- Python 3.8+
- Supabase account (free tier works)
- OpenAI API key (optional, for AI features)
- Anthropic API key (optional, alternative to OpenAI)

## 🏁 Quick Start

### 1. Clone and Setup

```bash
git clone <repository-url>
cd Orbito
```

### 2. Setup Supabase

1. Create a new project at [supabase.com](https://supabase.com)
2. Go to Settings > API to get your keys
3. Run the database schema:
   ```sql
   -- Copy and paste the contents of database/schema.sql
   -- into the Supabase SQL Editor
   ```

### 3. Setup Frontend

```bash
cd frontend
npm install

# Copy environment template
cp .env.local.example .env.local

# Edit .env.local with your Supabase credentials
NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
NEXT_PUBLIC_API_URL=http://localhost:8000
```

### 4. Setup Backend

```bash
cd ../backend

# Create virtual environment
python -m venv venv

# Activate virtual environment
# Windows:
venv\\Scripts\\activate
# Unix/macOS:
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Copy environment template
cp .env.example .env

# Edit .env with your configuration
SUPABASE_URL=your_supabase_url
SUPABASE_KEY=your_supabase_anon_key
SUPABASE_SERVICE_KEY=your_supabase_service_key
OPENAI_API_KEY=your_openai_key  # Optional
ANTHROPIC_API_KEY=your_anthropic_key  # Optional
```

### 5. Run the Application

**Start Backend (Terminal 1):**
```bash
cd backend
uvicorn app.main:app --reload --port 8000
```

**Start Frontend (Terminal 2):**
```bash
cd frontend
npm run dev
```

### 6. Access the Application

- **Frontend**: http://localhost:3000
- **Backend API**: http://localhost:8000
- **API Documentation**: http://localhost:8000/docs

## 👥 User Roles

### Admin
- Full system access
- User management and role assignment
- System settings and configuration
- All HR and employee features

### HR
- Recruitment and candidate management
- Job description creation (with AI)
- Leave request approval
- Achievement management
- Employee data access

### Employee
- Personal profile management
- Leave request submission
- Achievement viewing
- Policy chat access
- Process guides

## 🤖 AI Features Setup

### OpenAI Integration
```bash
# Add to backend/.env
OPENAI_API_KEY=sk-...
```

### Anthropic Integration
```bash
# Add to backend/.env  
ANTHROPIC_API_KEY=sk-ant-...
```

### AI Capabilities
- **Job Description Generation**: Creates comprehensive, engaging job postings
- **Policy Q&A**: Answers employee questions about company policies
- **Resume Screening**: Analyzes resumes against job requirements
- **Smart Suggestions**: Provides contextual recommendations

## 🔒 Security Features

- **Authentication**: Secure login with email verification
- **Authorization**: Role-based access control (RBAC)
- **Row Level Security**: Database-level access control
- **Protected Routes**: Middleware-based route protection
- **API Security**: JWT token validation and CORS protection

## 📊 Database Schema

Key tables:
- `profiles` - User profiles with roles and metadata
- `departments` - Organization structure
- `job_descriptions` - Job postings and requirements
- `candidates` - Applicant information and status
- `leave_requests` - Leave applications and approvals
- `achievements` - Employee recognition system
- `events` - Calendar and company events
- `policies` - Company policies for AI chat
- `notifications` - System notifications

## 🚀 Deployment

### Frontend (Vercel)
```bash
# Install Vercel CLI
npm i -g vercel

# Deploy
cd frontend
vercel --prod
```

### Backend (Railway/Render)
```bash
# Create Dockerfile (included)
# Deploy to Railway/Render with environment variables
```

### Database (Supabase)
- Already hosted and managed
- Configure production environment variables
- Set up proper RLS policies

## 🧪 Development

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
```bash
# Apply schema changes in Supabase dashboard
# Update types with:
cd frontend
npx supabase gen types typescript --project-id your-project-id > lib/supabase/types.ts
```

## 📈 Monitoring

- **Supabase Dashboard**: Database metrics and logs
- **Vercel Analytics**: Frontend performance metrics
- **FastAPI Logs**: Backend API monitoring
- **Error Tracking**: Built-in error handling

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🆘 Support

For support and questions:
- Check the documentation
- Review the API documentation at `/docs`
- Create an issue on GitHub

## 🛣 Roadmap

- [ ] Advanced reporting and analytics
- [ ] Mobile app (React Native)
- [ ] Integration with external HR tools
- [ ] Advanced AI features (document processing)
- [ ] Multi-tenant support
- [ ] Advanced workflow automation

---

**Built with ❤️ using modern technologies to enhance HR operations with AI.**