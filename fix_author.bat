@echo off
set GIT="C:\Program Files\Git\cmd\git.exe"
set GH="C:\Program Files\GitHub CLI\gh.exe"
cd /d C:\Users\abhis\.gemini\antigravity\scratch\food-ordering-app-react-native

:: Set correct identity for Abhishek-bhagat9
%GIT% config user.name "Abhishek-bhagat9"
%GIT% config user.email "222944168+Abhishek-bhagat9@users.noreply.github.com"

:: Rewrite all commit authors using git bash + filter-branch
"C:\Program Files\Git\bin\bash.exe" -c "git filter-branch --env-filter 'export GIT_AUTHOR_NAME=\"Abhishek-bhagat9\"; export GIT_AUTHOR_EMAIL=\"222944168+Abhishek-bhagat9@users.noreply.github.com\"; export GIT_COMMITTER_NAME=\"Abhishek-bhagat9\"; export GIT_COMMITTER_EMAIL=\"222944168+Abhishek-bhagat9@users.noreply.github.com\"' --tag-name-filter cat -f -- --branches --tags"

%GH% auth setup-git
%GIT% push origin main --force
echo DONE!
