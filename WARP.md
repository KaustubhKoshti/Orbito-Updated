# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Project Overview

Orbito is an AI-Enhanced ERP System with a modern full-stack architecture. The project is structured as a monorepo with separate frontend and backend directories, plus a database folder for migration scripts.

## Architecture

### Frontend (Next.js)
- **Framework**: Next.js 15.4.6 with React 19.1.0
- **Styling**: TailwindCSS v4 with shadcn/ui components
- **Key Features**: 
  - Role-based dashboard system (Admin, HR, Employee)
  - Calendar/Event management with drag-and-drop functionality
  - AI-powered job description generator
  - Policy chatbot and process guides
  - Leave management system

### Backend (Python - FastAPI)
- **Status**: Currently in development (placeholder files exist)
- **Framework**: Intended to use FastAPI with Python
- **Setup commands are documented in `backend/todo.txt`**

### Key Components Structure

#### Dashboard System
The application uses a role-based dashboard architecture:
- `DashboardLayout`: Main layout component with sidebar navigation
- Role-specific dashboards: AdminDashboard, HRDashboard, EmployeeDashboard
- Different navigation menus based on user role (admin/hr/employee)

#### Calendar System
Sophisticated event calendar with multiple views:
- `EventCalendar`: Main calendar component with month/week/day/agenda views
- Drag-and-drop functionality via `@dnd-kit` libraries
- Event management with create/update/delete operations
- Keyboard shortcuts for view switching (M/W/D/A keys)

#### UI Components
- Built with Radix UI primitives and shadcn/ui
- Custom components in `/components/ui/` directory
- Consistent design system using class-variance-authority

## Development Commands

### Complete Setup (First Time)
```bash
# Setup Supabase database
# 1. Create project at supabase.com
# 2. Run database/schema.sql in SQL Editor
# 3. Get API keys from Settings > API

# Frontend setup
cd frontend
npm install
cp .env.local.example .env.local
# Edit .env.local with Supabase credentials

# Backend setup
cd ../backend
python -m venv venv
# Windows:
venv\Scripts\activate
# Unix/MacOS:
source venv/bin/activate
pip install -r requirements.txt
cp .env.example .env
# Edit .env with Supabase and AI credentials
```

### Frontend Development
```bash
cd frontend
npm install
npm run dev          # Development server with Turbopack
npm run build        # Production build
npm start           # Production server
npm run lint        # ESLint
```

### Backend Development
```bash
cd backend
# Activate virtual environment first
uvicorn app.main:app --reload --port 8000
# API docs available at http://localhost:8000/docs
```

### Database Setup (Planned)
```bash
# Navigate to database directory
cd database

# Create migrations directory
mkdir migrations

# Initialize database
# (SQL scripts will be added here)
```

## Key File Locations

### Configuration Files
- `frontend/package.json` - Frontend dependencies and scripts
- `frontend/next.config.ts` - Next.js configuration
- `frontend/tsconfig.json` - TypeScript configuration
- `frontend/tailwind.config.js` - TailwindCSS configuration (implied by setup)

### Main Application Files
- `frontend/app/layout.tsx` - Root layout with fonts and metadata
- `frontend/app/page.tsx` - Homepage routing to dashboard
- `frontend/app/dashboard/page.tsx` - Main dashboard page
- `frontend/components/dashboard-layout.tsx` - Core dashboard layout

### Feature Components
- `frontend/components/event-calendar.tsx` - Main calendar component
- `frontend/components/job-description-generator.tsx` - AI job description tool
- `frontend/components/policy-chatbot.tsx` - AI-powered policy assistance
- `frontend/components/types.ts` - TypeScript type definitions

## Development Patterns

### Component Architecture
- Client-side components use `"use client"` directive
- Server components by default (Next.js App Router)
- Consistent use of TypeScript interfaces for type safety
- Props interfaces defined inline with components

### State Management
- React hooks for local state management
- Event handling patterns throughout calendar system
- Form state management in generator components

### Styling Approach
- TailwindCSS utility classes
- shadcn/ui component library for consistent design
- Custom CSS properties for dynamic styling (calendar views)
- Responsive design patterns with breakpoint-specific classes

### Calendar System Integration
When working with the calendar system:
- Events are typed with `CalendarEvent` interface
- Use existing drag-and-drop context (`CalendarDndProvider`)
- Follow established patterns for view switching and event handling
- Keyboard shortcuts are implemented (M/W/D/A for views)

### Role-Based Features
The application has three user roles with different capabilities:
- **Admin**: Full system access, user management, system settings
- **HR**: Recruitment tools, candidate management, job descriptions
- **Employee**: Personal leave requests, achievements, policy access

When adding new features, consider role-based access and add appropriate menu items to the respective role arrays in `dashboard-layout.tsx`.