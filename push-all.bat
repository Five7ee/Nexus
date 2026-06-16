@echo off
cd /d "F:\OneDrive\Cours\EDNA\M2\PFE V2\Nexus-main"
git add index.html view.html steps.json
git add -f models/*.glb 2>nul
git add images/ 2>nul
git status
set /p MSG="Message de commit (Entree = 'Update'): "
if "%MSG%"=="" set MSG=Update
git commit -m "%MSG%"
git pull origin main --rebase 2>nul || git pull origin main
git push origin main --set-upstream 2>nul || git push origin main
echo.
echo Done !
pause
