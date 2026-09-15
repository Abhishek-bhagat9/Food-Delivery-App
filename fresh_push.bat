@echo off
set GIT="C:\Program Files\Git\cmd\git.exe"
set GH="C:\Program Files\GitHub CLI\gh.exe"
cd /d C:\Users\abhis\.gemini\antigravity\scratch\food-ordering-app-react-native

echo [1] Wiping git history completely...
rmdir /s /q .git

echo [2] Fresh git init...
%GIT% init
%GIT% config user.name "Abhishek-bhagat9"
%GIT% config user.email "222944168+Abhishek-bhagat9@users.noreply.github.com"

echo [3] Staging all files...
%GIT% add .

echo [4] Single clean commit...
%GIT% commit -m "Initial commit: Food Delivery App"

echo [5] Setting branch and remote...
%GIT% branch -M main
%GIT% remote add origin https://github.com/Abhishek-bhagat9/Food-Delivery-App.git

echo [6] Pushing...
%GH% auth setup-git
%GIT% push -u origin main --force

echo DONE!
