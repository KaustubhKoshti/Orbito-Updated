# 🎯 ATS (Applicant Tracking System) Usage Guide - Orbito

## Overview
The ATS in Orbito is a comprehensive system that automates the entire hiring process from application to onboarding, powered by AI and integrated workflows.

## 🔄 Complete ATS Workflow

### Phase 1: Job Posting & Application
```
HR creates job → AI optimizes posting → Published to job boards → Candidates apply
```

### Phase 2: Resume Processing  
```
Resume uploaded → AI parsing → Skill extraction → Contact info → Experience analysis
```

### Phase 3: Candidate Screening
```
Parsed data → AI scoring → Ranking → Automated screening → Interview scheduling
```

### Phase 4: Interview Management
```
Schedule interviews → Send notifications → Collect feedback → Final scoring
```

### Phase 5: Decision & Automation
```
Hire/Reject decision → Automated workflows → Onboarding/Notifications
```

## 🎮 **Practical Usage Examples**

### **Example 1: HR Manager Daily Workflow**

**Morning: Review New Applications**
```bash
# Access ATS dashboard
http://localhost:3000/dashboard/candidates

# View candidates by status
GET /api/ats/candidates?status=applied&limit=20
```

**What HR sees:**
- List of new candidates with AI scores
- Resume parsing results
- Skill matching percentages
- Recommended actions (Interview/Reject/Review)

### **Example 2: Resume Upload & Parsing**

**Step 1: Candidate uploads resume**
```javascript
// Frontend: Resume upload component
const uploadResume = async (file) => {
  const formData = new FormData();
  formData.append('file', file);
  
  const response = await fetch('/api/ats/parse-resume', {
    method: 'POST',
    body: formData,
    headers: { 'Authorization': `Bearer ${token}` }
  });
  
  return response.json();
}
```

**Step 2: AI processes the resume**
```python
# Backend: What happens automatically
{
  "success": true,
  "parsed_data": {
    "contact_info": {
      "name": "John Smith",
      "email": "john@example.com", 
      "phone": "+1-555-123-4567",
      "linkedin": "linkedin.com/in/johnsmith"
    },
    "skills": ["Python", "React", "AWS", "Docker", "PostgreSQL"],
    "experience": [
      {
        "company": "Tech Corp Inc.",
        "dates": "2020-2023",
        "role": "Senior Developer"
      }
    ],
    "education": [
      {"degree": "Bachelor of Computer Science"}
    ],
    "summary": "Experienced software engineer with 5+ years...",
    "years_of_experience": 5
  }
}
```

### **Example 3: AI-Powered Candidate Scoring**

**HR scores candidate against job requirements:**
```http
POST /api/ats/candidates/123/score
{
  "required_skills": ["Python", "React", "AWS", "Docker"],
  "years_experience": 3,
  "education": "Bachelor's degree",
  "location": "Remote"
}
```

**AI returns detailed scoring:**
```json
{
  "final_score": 87.5,
  "breakdown": {
    "skills": 95.0,      // 4/4 skills matched
    "experience": 100.0,  // 5 years > 3 required  
    "education": 85.0,    // Has required degree
    "overall_fit": 70.0   // AI assessment
  },
  "recommendation": "Strong Hire - Excellent match for the role"
}
```

### **Example 4: Automated Interview Scheduling**

**HR schedules interview:**
```http
POST /api/ats/interviews
{
  "candidate_id": "123",
  "interviewer_id": "456", 
  "scheduled_at": "2024-10-15T14:00:00Z",
  "interview_type": "technical",
  "duration_minutes": 60,
  "meeting_url": "https://zoom.us/j/123456789"
}
```

**What happens automatically (via n8n workflows):**
1. **Email to candidate**: Interview confirmation with details
2. **Email to interviewer**: Meeting notification with candidate info  
3. **Calendar event**: Created for both parties
4. **24h reminder**: Automated reminder emails
5. **Interview questions**: AI generates relevant questions based on role

## 🤖 **AI Features in Action**

### **1. Intelligent Resume Parsing**
```python
# What the AI extracts automatically:
{
  "technical_skills": ["Python", "JavaScript", "AWS"],
  "soft_skills": ["Leadership", "Communication"], 
  "certifications": ["AWS Certified", "Scrum Master"],
  "languages": ["English", "Spanish"],
  "years_experience": 5,
  "industry_expertise": ["Fintech", "E-commerce"],
  "leadership_experience": true,
  "achievements": [
    "Increased system performance by 40%",
    "Led team of 8 developers", 
    "Launched 3 major products"
  ]
}
```

### **2. Smart Candidate Matching**
```python
# AI compares candidate to job requirements
job_requirements = {
  "required_skills": ["Python", "React", "AWS"],
  "nice_to_have": ["Docker", "Kubernetes"],
  "years_experience": 3,
  "industry": "Fintech"
}

# AI scoring logic:
skills_match = 95%      # Has Python, React, AWS + bonus Docker
experience_match = 100% # 5 years > 3 required
industry_match = 90%    # Fintech experience
culture_fit = 85%       # AI assessment based on resume content

final_score = weighted_average([95, 100, 90, 85]) = 92.5%
```

### **3. Automated Decision Making**
```python
# AI recommendations based on scoring:
if score >= 90:
    action = "Schedule Technical Interview"
elif score >= 75:
    action = "Schedule Phone Screen"  
elif score >= 60:
    action = "Review Manually"
else:
    action = "Send Rejection Email"
```

## 📊 **ATS Analytics & Insights**

### **Real-time Hiring Metrics**
```http
GET /api/ats/analytics/candidates?days=30
```

**Response:**
```json
{
  "analytics": {
    "total_candidates": 156,
    "average_score": 73.2,
    "by_status": {
      "applied": 45,
      "screening": 32, 
      "interviewing": 18,
      "hired": 8,
      "rejected": 53
    },
    "top_skills": [
      {"skill": "Python", "count": 89},
      {"skill": "JavaScript", "count": 76},  
      {"skill": "React", "count": 54}
    ],
    "conversion_rate": 12.8,  // hired / total applications
    "time_to_hire": 18.5      // average days
  }
}
```

## 🔄 **n8n Workflow Integrations**

### **Workflow 1: New Application Processing**
```javascript
// Triggered when candidate applies
{
  "trigger": "candidate_applied",
  "actions": [
    "parse_resume_with_ai",
    "score_against_requirements", 
    "send_confirmation_email",
    "notify_hiring_manager",
    "update_dashboard_metrics"
  ]
}
```

### **Workflow 2: Interview Scheduling**  
```javascript
{
  "trigger": "interview_scheduled",
  "actions": [
    "send_candidate_confirmation",
    "create_calendar_events",
    "prepare_interview_questions_ai",
    "set_reminder_24h_before", 
    "notify_interview_panel"
  ]
}
```

### **Workflow 3: Decision Automation**
```javascript
{
  "trigger": "interview_completed", 
  "actions": [
    "collect_feedback",
    "calculate_final_score",
    "auto_approve_if_score_high",
    "send_offer_letter_or_rejection",
    "update_candidate_status"
  ]
}
```

## 💼 **Role-Based ATS Access**

### **Admin Users Can:**
- View all candidates across all positions
- Access complete analytics and reports
- Manage ATS configuration and workflows
- Export data and generate compliance reports

### **HR Users Can:**  
- Manage candidates for their assigned roles
- Schedule interviews and collect feedback
- Access hiring metrics and insights
- Configure job requirements and scoring

### **Hiring Managers Can:**
- View candidates for their specific positions
- Provide interview feedback and ratings
- Access candidate timelines and notes
- Make hiring recommendations

## 📱 **Frontend ATS Components**

### **Main ATS Dashboard**
```typescript
// Components you'll interact with:
<CandidateList />           // List with filters and search
<CandidateProfile />        // Detailed candidate view
<ResumeParser />           // Upload and parse resumes
<InterviewScheduler />     // Calendar integration
<ScoringMatrix />          // AI scoring visualization
<AnalyticsDashboard />     // Hiring metrics and insights
```

### **Candidate Card Example**
```tsx
<CandidateCard>
  <Avatar src={candidate.avatar} />
  <Name>{candidate.name}</Name>
  <Score color={getScoreColor(candidate.score)}>
    {candidate.score}/100
  </Score>
  <Skills>{candidate.topSkills.join(', ')}</Skills>
  <Actions>
    <Button onClick={scheduleInterview}>Interview</Button>
    <Button onClick={viewProfile}>View Profile</Button>
  </Actions>
</CandidateCard>
```

## 🎯 **Practical Usage Scenarios**

### **Scenario 1: High-Volume Hiring**
```
• 200+ applications per week
• AI pre-screens and ranks all candidates
• Top 20% automatically scheduled for phone screens  
• HR focuses only on high-potential candidates
• 75% time savings on initial screening
```

### **Scenario 2: Specialized Role Hiring**
```
• Looking for rare skill combination
• AI identifies candidates with exact match
• Custom scoring weights for critical skills
• Automated skill verification questions
• Fast-track high-scoring specialists
```

### **Scenario 3: Bulk University Recruitment**
```
• Upload 500+ resumes from career fair
• AI processes all in parallel
• Automatic skill categorization  
• Group similar candidates together
• Schedule batch interviews by skill set
```

## 🔍 **ATS Data Flow**

```
Application → Resume Upload → AI Parsing → Data Extraction → 
Skill Matching → Scoring → Ranking → Workflow Triggers → 
Interview Scheduling → Feedback Collection → Final Decision → 
Onboarding/Rejection
```

## 📈 **Success Metrics**

The ATS tracks and optimizes:
- **Time to Fill**: Average days from posting to hire
- **Quality of Hire**: Performance ratings of hired candidates  
- **Source Effectiveness**: Which channels bring best candidates
- **Interviewer Efficiency**: Feedback quality and consistency
- **Candidate Experience**: Application completion and satisfaction rates

## 🎉 **Key Benefits**

1. **80% Faster Screening**: AI handles initial resume review
2. **Consistent Evaluation**: Standardized scoring across all candidates
3. **Better Matches**: AI identifies skills humans might miss  
4. **Automated Workflows**: Reduces manual administrative tasks
5. **Data-Driven Decisions**: Analytics guide hiring strategy
6. **Compliance Ready**: Audit trails for all hiring decisions

Your ATS is now a comprehensive, AI-powered hiring machine that transforms the recruitment process from manual and time-consuming to automated and intelligent! 🚀