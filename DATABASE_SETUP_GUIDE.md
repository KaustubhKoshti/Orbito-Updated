# 🗃️ Orbito Database Setup Guide

## 📋 Overview
This guide helps you set up automatic profile creation in your Supabase database. When a user signs up, their profile will be automatically created in the `profiles` table.

## 🎯 What This Script Does

### ✅ **Automatic Features:**
1. **Profile Creation**: Automatically creates profile when user signs up
2. **RLS Policies**: Sets up secure Row Level Security policies (fixes infinite recursion)
3. **Data Extraction**: Extracts signup data from user metadata
4. **Error Handling**: Won't fail user creation if profile creation fails
5. **Conflict Resolution**: Handles duplicate records gracefully

### 📊 **Profile Data Mapping:**
- **User ID** → Profile ID (primary key)
- **Email** → Profile email
- **Metadata** → Profile fields (full_name, role, department, position)
- **Timestamps** → created_at, updated_at

## 🚀 Installation Steps

### **Step 1: Access Supabase Dashboard**
1. Go to https://supabase.com/dashboard
2. Select your project: `svmyyspmafltsohoieil`
3. Navigate to **SQL Editor** in the left sidebar

### **Step 2: Run the Database Script**
1. Click **"New Query"**
2. Copy the entire content of `database/auto_profile_creation.sql`
3. Paste it into the SQL Editor
4. Click **"Run"** (or press Ctrl+Enter)

### **Step 3: Verify Installation**
After running the script, you should see:
```
✅ Trigger created successfully
✅ Your profile created: Kaustubh Koshti (admin)
✅ Policies updated successfully
```

### **Step 4: Test the System**
1. **Refresh your dashboard**: Go to http://localhost:3000/debug
2. **Check profile status**: Should show "Profile exists: True"  
3. **Visit dashboard**: Go to http://localhost:3000/dashboard
4. **Expected result**: Dashboard should load with your admin interface

## 🔧 **Script Components**

### **1. Database Table**
```sql
CREATE TABLE profiles (
    id UUID PRIMARY KEY,
    email TEXT NOT NULL,
    full_name TEXT,
    role TEXT DEFAULT 'employee',
    department TEXT,
    position TEXT,
    created_at TIMESTAMPTZ,
    updated_at TIMESTAMPTZ
);
```

### **2. Automatic Trigger**
```sql
-- Trigger fires when new user signs up
CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW 
    EXECUTE FUNCTION handle_new_user();
```

### **3. RLS Policies** (Fixed)
- Users can read their own profile
- Users can update their own profile  
- Users can create their own profile
- **No infinite recursion** ✅

### **4. Your Profile Creation**
The script automatically creates your profile:
- **Name**: Kaustubh Koshti
- **Email**: kaustubhkoshti@gmail.com
- **Role**: admin
- **Department**: Engineering
- **Position**: Developer

## 🧪 **Testing New Users**

After installation, test with a new user signup:

### **Frontend Signup Process:**
1. User fills signup form with:
   - Email
   - Password
   - Full name
   - Role
   - Department
   - Position

2. **Backend processes signup:**
   - Creates user in `auth.users`
   - Trigger automatically creates profile in `profiles`
   - User can immediately access dashboard

3. **Dashboard loads with:**
   - User authentication ✅
   - Profile data ✅
   - Role-based navigation ✅

## 🔍 **Verification Queries**

### **Check if trigger exists:**
```sql
SELECT tgname, tgrelid::regclass 
FROM pg_trigger 
WHERE tgname = 'on_auth_user_created';
```

### **Check your profile:**
```sql
SELECT * FROM profiles 
WHERE email = 'kaustubhkoshti@gmail.com';
```

### **List all profiles:**
```sql
SELECT id, email, full_name, role 
FROM profiles 
ORDER BY created_at DESC;
```

## 🛠️ **Troubleshooting**

### **If script fails:**
1. **Check permissions**: Run as database owner
2. **Check existing triggers**: Script drops existing ones first
3. **Check RLS policies**: Script recreates them safely

### **If profile not created:**
1. **Check trigger exists**: Use verification query above
2. **Check user metadata**: Ensure frontend sends metadata
3. **Manual creation**: Use `create_missing_profile()` function

### **If dashboard still blank:**
1. **Refresh browser**: Clear cache and refresh
2. **Check debug page**: Visit http://localhost:3000/debug  
3. **Check console**: Look for authentication errors

## 🎉 **Expected Results**

After successful installation:

### ✅ **For New Users:**
- Sign up → Profile automatically created
- Sign in → Dashboard loads immediately  
- No blank pages

### ✅ **For Existing Users:**
- Your profile created during installation
- Dashboard works immediately
- Admin access to all features

### ✅ **System Benefits:**
- No more manual profile creation
- No more blank dashboards
- Automatic role-based access
- Secure database policies

---

## 📞 **Support**

If you encounter issues:
1. Check the verification queries
2. Look at Supabase logs in the dashboard
3. Test with the debug page: http://localhost:3000/debug

**File Location**: `D:\new orbito\Orbito\database\auto_profile_creation.sql`