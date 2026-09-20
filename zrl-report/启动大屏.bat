@echo off
cd /d %~dp0
echo ================================================
echo  zrl-report dashboard server  (port 12587)
echo  URL: http://localhost:12587/zrl-report/index.html
echo  NOTE: start the backend (port 13576) first,
echo        or the dashboard will have no data.
echo ================================================
node server.js
pause
