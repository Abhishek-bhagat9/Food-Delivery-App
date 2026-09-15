@echo off
set GIT="C:\Program Files\Git\cmd\git.exe"
set GH="C:\Program Files\GitHub CLI\gh.exe"
cd /d C:\Users\abhis\.gemini\antigravity\scratch\food-ordering-app-react-native
%GIT% add .
%GIT% commit --amend --no-edit
%GH% auth setup-git
%GIT% push -u origin main --force
