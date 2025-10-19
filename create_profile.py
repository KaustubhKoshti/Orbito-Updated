#!/usr/bin/env python3
"""
Simple script to create a profile for the authenticated user
"""
import os
from supabase import create_client, Client
from datetime import datetime

# Your Supabase configuration
SUPABASE_URL = "https://svmyyspmafltsohoieil.supabase.co"
SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InN2bXl5c3BtYWZsdHNvaG9pZWlsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTkyNTg5MDQsImV4cCI6MjA3NDgzNDkwNH0.AEy7F85Xc-tT-uqi1UvHBPpjdSK_TlqbYNAOI9SMcd0"

# Your user details
USER_ID = "9693cc90-5032-4f5a-a0cb-1a027bb7c1a9"
EMAIL = "kaustubhkoshti@gmail.com"
FULL_NAME = "Kaustubh Koshti"
ROLE = "admin"
DEPARTMENT = "Engineering" 
POSITION = "Developer"

def create_profile():
    # Initialize Supabase client
    supabase: Client = create_client(SUPABASE_URL, SUPABASE_KEY)
    
    print(f"🔄 Creating profile for user: {EMAIL}")
    
    # Check if profile already exists
    try:
        existing = supabase.table('profiles').select('*').eq('id', USER_ID).execute()
        if existing.data:
            print(f"✅ Profile already exists: {existing.data[0]}")
            return existing.data[0]
    except Exception as e:
        print(f"⚠️ Could not check existing profile: {e}")
    
    # Create new profile
    profile_data = {
        "id": USER_ID,
        "email": EMAIL, 
        "full_name": FULL_NAME,
        "role": ROLE,
        "department": DEPARTMENT,
        "position": POSITION,
        "created_at": datetime.utcnow().isoformat(),
        "updated_at": datetime.utcnow().isoformat()
    }
    
    try:
        result = supabase.table('profiles').insert(profile_data).execute()
        if result.data:
            print(f"🎉 Profile created successfully:")
            print(f"   Name: {result.data[0]['full_name']}")
            print(f"   Role: {result.data[0]['role']}")
            print(f"   Department: {result.data[0]['department']}")
            print(f"   Position: {result.data[0]['position']}")
            print()
            print("✅ Now refresh your dashboard - it should work!")
            return result.data[0]
        else:
            print("❌ Profile creation failed - no data returned")
            return None
            
    except Exception as e:
        print(f"❌ Profile creation failed: {e}")
        return None

if __name__ == "__main__":
    print("🚀 Orbito Profile Creator")
    print("=" * 30)
    create_profile()