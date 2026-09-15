@echo off
set GIT="C:\Program Files\Git\cmd\git.exe"
set GH="C:\Program Files\GitHub CLI\gh.exe"
cd /d C:\Users\abhis\.gemini\antigravity\scratch\food-ordering-app-react-native

%GIT% config user.name "Abhishek Bhagat"
%GIT% config user.email "abhishekb@users.noreply.github.com"
%GIT% add README.md CONTRIBUTING.md SECURITY.md "enatega-multivendor-web\package.json"
%GIT% commit -m "chore: update project ownership to Abhishek-bhagat9"
%GH% auth setup-git
%GIT% push origin main
echo DONE!
