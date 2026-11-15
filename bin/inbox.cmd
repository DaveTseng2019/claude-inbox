@echo off
rem Windows entry point. Claude Code adds bin\ to PATH when the plugin is enabled.
rem Try python first; fall back to the py launcher (python.org installs without "Add to PATH").
python -c "" >nul 2>nul
if errorlevel 1 goto try_py
python "%~dp0..\inbox\inbox.py" %*
exit /b %errorlevel%
:try_py
py -3 "%~dp0..\inbox\inbox.py" %*
exit /b %errorlevel%
